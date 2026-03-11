#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
APK_PATH="${1:-$ROOT_DIR/original-apk/a1_case1.apk}"

JAVA_HOME_DIR="$ROOT_DIR/tools/java/jdk-21.0.10+7-jre"
JAVA_BIN="$JAVA_HOME_DIR/bin/java"
JADX_BIN="$ROOT_DIR/tools/jadx/jadx-1.5.5/bin/jadx"
APKTOOL_JAR="$ROOT_DIR/tools/apktool/apktool_3.0.1.jar"
XDG_STATE_ROOT="$ROOT_DIR/tools/runtime"

APK_NAME="$(basename "$APK_PATH" .apk)"
JADX_OUT="$ROOT_DIR/decompiled/jadx-$APK_NAME"
APKTOOL_OUT="$ROOT_DIR/decompiled/apktool-$APK_NAME"

if [[ ! -f "$APK_PATH" ]]; then
  echo "APK not found: $APK_PATH" >&2
  exit 1
fi

if [[ ! -x "$JAVA_BIN" ]]; then
  echo "Java runtime not found or not executable: $JAVA_BIN" >&2
  exit 1
fi

if [[ ! -x "$JADX_BIN" ]]; then
  echo "jadx not found or not executable: $JADX_BIN" >&2
  exit 1
fi

if [[ ! -f "$APKTOOL_JAR" ]]; then
  echo "apktool JAR not found: $APKTOOL_JAR" >&2
  exit 1
fi

rm -rf "$JADX_OUT" "$APKTOOL_OUT"
mkdir -p "$JADX_OUT" "$APKTOOL_OUT"
mkdir -p \
  "$XDG_STATE_ROOT/config" \
  "$XDG_STATE_ROOT/cache" \
  "$XDG_STATE_ROOT/data"

export JAVA_HOME="$JAVA_HOME_DIR"
export PATH="$JAVA_HOME_DIR/bin:$PATH"
export XDG_CONFIG_HOME="$XDG_STATE_ROOT/config"
export XDG_CACHE_HOME="$XDG_STATE_ROOT/cache"
export XDG_DATA_HOME="$XDG_STATE_ROOT/data"

set +e
"$JADX_BIN" --output-dir "$JADX_OUT" "$APK_PATH"
JADX_STATUS=$?
set -e

"$JAVA_BIN" -jar "$APKTOOL_JAR" decode --force --output "$APKTOOL_OUT" "$APK_PATH"

echo "jadx output: $JADX_OUT"
echo "apktool output: $APKTOOL_OUT"

if [[ "$JADX_STATUS" -ne 0 ]]; then
  echo "warning: JADX exited with status $JADX_STATUS; inspect output for partial decompilation limits" >&2
fi
