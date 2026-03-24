#!/bin/bash

# Common ADB locations on macOS
PATHS=(
    "$HOME/Library/Android/sdk/platform-tools/adb"
    "/usr/local/bin/adb"
    "/opt/homebrew/bin/adb"
    "adb"
)

ADB_BIN=""
for p in "${PATHS[@]}"; do
    if command -v "$p" &> /dev/null; then
        ADB_BIN="$p"
        break
    fi
done

if [ -z "$ADB_BIN" ]; then
    echo "Error: adb not found. Please ensure Android SDK Platform-Tools are installed."
    exit 1
fi

APK_PATH="./original-apk/a1_case1.apk"
PACKAGE_NAME="com.example.mastg_test0016"
ACTIVITY_NAME="com.example.mastg_test0016.MainActivity"

echo "Using adb at: $ADB_BIN"
echo "Installing APK..."
"$ADB_BIN" install "$APK_PATH"

echo "Launching App..."
"$ADB_BIN" shell am start -n "$PACKAGE_NAME/$ACTIVITY_NAME"
