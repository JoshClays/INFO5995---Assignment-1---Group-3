# AI Log: Task 1 Decompile Setup

## Session goal

Set up a clean, reproducible APK decompilation workflow for `original-apk/a1_case1.apk`, then validate the minimum evidence required by Task 1.

## What was checked first

- Project structure and APK location
- Git status before changes
- Local availability of `jadx`, `apktool`, `java`, and `adb`

Verified initial state:

- APK path: `original-apk/a1_case1.apk`
- Git branch was clean on `master`
- `jadx`, `apktool`, `java`, and `adb` were not installed in the WSL environment

## Tooling decision

- Preferred readable Java output: `jadx`
- Preferred decoded manifest/resources output: `apktool`
- Because system installs were blocked by interactive `sudo`, a fully local toolchain was used inside the repo

Pinned tool versions resolved from official release metadata:

- JRE: `21.0.10+7`
- JADX: `1.5.5`
- Apktool: `3.0.1`

Hashes were verified after download:

- JRE tarball SHA-256: `991be6ac6725e76109ecbd131d658f992dcbeacba3a8b4b6650302c8012b52fb`
- JADX zip SHA-256: `38a5766d3c8170c41566b4b13ea0ede2430e3008421af4927235c2880234d51a`
- Apktool JAR SHA-256: `b947b945b4bc455609ba768d071b64d9e63834079898dbaae15b67bf03bcd362`

## Commands used

Environment checks:

- `ls -la`
- `rg --files -g '*.apk'`
- `git status --short --branch`
- `command -v jadx`
- `command -v apktool`
- `java -version`
- `command -v adb`

Package and metadata checks:

- `apt-cache policy apktool`
- `apt-cache policy default-jre-headless`
- `apt-cache search '^adb$'`
- `curl -fsSL https://api.github.com/repos/skylot/jadx/releases/latest`
- `curl -fsSL https://api.github.com/repos/iBotPeaches/Apktool/releases/latest`
- `curl -fsSL https://api.adoptium.net/v3/assets/latest/21/hotspot?architecture=x64&image_type=jre&os=linux`

Project-local setup:

- added `tools/` to `.gitignore`
- created `scripts/decompile.sh`
- extracted the JRE and `jadx` into `tools/`
- stored `apktool_3.0.1.jar` in `tools/apktool/`

Decompilation:

- `scripts/decompile.sh`

Validation:

- `nl -ba decompiled/apktool-a1_case1/AndroidManifest.xml | sed -n '1,120p'`
- `nl -ba decompiled/jadx-a1_case1/sources/com/example/mastg_test0016/MainActivity.java | sed -n '1,220p'`
- `nl -ba decompiled/jadx-a1_case1/sources/com/example/mastg_test0016/Login.java | sed -n '1,240p'`
- `nl -ba decompiled/jadx-a1_case1/sources/com/example/mastg_test0016/Login.java | sed -n '70,210p'`

## Validated Task 1 evidence

- Package name: `com.example.mastg_test0016`
  - Source: `decompiled/apktool-a1_case1/AndroidManifest.xml`, line 2
- Main activity: `com.example.mastg_test0016.MainActivity`
  - Source: `decompiled/apktool-a1_case1/AndroidManifest.xml`, lines 8-12
- Manifest path: `decompiled/apktool-a1_case1/AndroidManifest.xml`
- Primary login-related class: `decompiled/jadx-a1_case1/sources/com/example/mastg_test0016/Login.java`
  - class declaration at line 25
  - credential verification at lines 71-103
  - session token generation at lines 183-189
- Secondary registration-like class: `decompiled/jadx-a1_case1/sources/com/example/mastg_test0016/MainActivity.java`
  - launcher activity at lines 24-30
  - saves credentials to `credentials.txt` at lines 54-60

## Decompilation limitations recorded

- `jadx` completed with `19` reported errors and exited with status `3`
- The wrapper script was updated so `apktool` still runs even when `jadx` reports partial failure
- This limitation does not block Task 1 because the required manifest and app-auth classes were still readable

## Git audit trail created during this session

- `ff00aa5` `Add local decompilation workflow script`
- `85b0396` `Keep decompiler runtime state inside repo`
- `40fe966` `Continue apktool decode after JADX warnings`
- `79a0618` `Add decompiled APK outputs`

## Screenshot recommendation

Take one screenshot with:

- explorer visible
- `decompiled/apktool-a1_case1/AndroidManifest.xml` open to line 2 and lines 7-12
- `decompiled/jadx-a1_case1/sources/com/example/mastg_test0016/Login.java` open to lines 25-60

This gives direct visual evidence for decompilation success, manifest access, package name, launcher activity, and a login-related class in one frame.

## Exact next step for Phase 2

Start the scoped vulnerability review from:

- `decompiled/jadx-a1_case1/sources/com/example/mastg_test0016/MainActivity.java` line 17
- `decompiled/jadx-a1_case1/sources/com/example/mastg_test0016/Login.java` lines 174-189

Both methods use `java.util.Random`, which fits the assignment's allowed randomness/cryptography scope and should be validated next.
