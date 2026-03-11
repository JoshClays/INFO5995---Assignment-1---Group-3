# Task 1 Decompilation Workflow

## Scope

This workflow covers INFO5995 Assignment 1 Phase 1 Task 1 for `original-apk/a1_case1.apk`.

## Local toolchain used

- Java runtime: Adoptium Temurin JRE `21.0.10+7` stored under `tools/java/jdk-21.0.10+7-jre`
- JADX: `1.5.5` stored under `tools/jadx/jadx-1.5.5`
- Apktool: `3.0.1` stored under `tools/apktool/apktool_3.0.1.jar`

All three downloads were hash-checked before use.

## Reproducible command sequence

1. Verify repo state and APK location:
   - `git status --short --branch`
   - `rg --files -g '*.apk'`
2. Run the local decompilation wrapper:
   - `scripts/decompile.sh`
3. Validate the decompiled output from files:
   - `decompiled/apktool-a1_case1/AndroidManifest.xml`
   - `decompiled/jadx-a1_case1/sources/com/example/mastg_test0016/*.java`

## Output folders

- `decompiled/jadx-a1_case1/`
- `decompiled/apktool-a1_case1/`

## Validated findings

- Package name: `com.example.mastg_test0016`
  - Evidence: `decompiled/apktool-a1_case1/AndroidManifest.xml`, line 2
- Main activity: `com.example.mastg_test0016.MainActivity`
  - Evidence: `decompiled/apktool-a1_case1/AndroidManifest.xml`, lines 8-12
- Login-related class: `decompiled/jadx-a1_case1/sources/com/example/mastg_test0016/Login.java`
  - Evidence:
    - class declaration at line 25
    - login button handler and navigation to `Profile` at lines 47-60
    - credential check against `credentials.txt` at lines 71-103
    - session token generation at lines 183-189
- Secondary registration-like class: `decompiled/jadx-a1_case1/sources/com/example/mastg_test0016/MainActivity.java`
  - Why it matters: it is the launcher activity and it saves username/password pairs before sending the user to `Login`
  - Evidence:
    - class declaration at line 16
    - launcher UI setup at lines 24-30
    - transition to `Login` at lines 31-48
    - credential file write at lines 54-60

## Limitations observed

- `jadx` completed with partial decompilation warnings and exited with status `3`
- Console summary reported `19` `jadx` errors
- Despite that, the app package `com/example/mastg_test0016` decompiled cleanly enough for Task 1 validation
- `apktool` completed successfully and produced a decoded manifest/resources tree

## Best screenshot for Task 1 evidence

Use a split-editor screenshot with the file explorer visible.

- Left pane: `decompiled/apktool-a1_case1/AndroidManifest.xml` showing line 2 and lines 7-12
- Right pane: `decompiled/jadx-a1_case1/sources/com/example/mastg_test0016/Login.java` showing lines 25-60
- Keep the explorer expanded so `decompiled/jadx-a1_case1/` and `decompiled/apktool-a1_case1/` are visible in the same frame

That single screenshot shows:

- the APK was decompiled
- the manifest is accessible
- the package name is visible
- the launcher activity is visible
- at least one login-related class is visible

## Phase 2 starting point

For Phase 2, inspect randomness and cryptography-relevant logic first:

- `decompiled/jadx-a1_case1/sources/com/example/mastg_test0016/MainActivity.java` lines 17-20
- `decompiled/jadx-a1_case1/sources/com/example/mastg_test0016/Login.java` lines 174-189

These are the clearest starting points for a scoped vulnerability analysis that stays within the updated rubric.
