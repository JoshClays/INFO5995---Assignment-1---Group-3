# INFO5995 - Assignment 1 - Phase 2 : Static Analysis

# AI Log: Task 2 System and Threat Model Preparation

## Session goal

Use static analysis of the decompiled APK to:

- summarise the app purpose and main features
- identify the main components, assets, and data flows
- define assignment-focused assumptions and attacker goals
- prepare ranked randomness/cryptography code locations for Task 3

## Scope applied

- Assignment scope kept to randomness and cryptography issues only
- Static analysis focused on manifest, first-party activities, layouts, local storage, and randomness-related code
- No time spent on unrelated bug classes beyond minimal context needed for the system model

## What was checked first

- `decompiled/apktool-a1_case1/AndroidManifest.xml`
- first-party source files under `decompiled/jadx-a1_case1/sources/com/example/mastg_test0016/`
- key layouts under `decompiled/jadx-a1_case1/resources/res/layout/`
- resource strings under `decompiled/jadx-a1_case1/resources/res/values/strings.xml`

Confirmed first-party code surface:

- `MainActivity.java`
- `Login.java`
- `Profile.java`

## Main static findings established

- The app has three first-party activities only:
  - `MainActivity`
  - `Login`
  - `Profile`
- Registration-style input in `MainActivity` stores username and password into `credentials.txt` using internal file storage
- `Login` reads `credentials.txt` and compares plaintext username/password pairs locally
- Successful login creates a session token and stores it in `SharedPreferences` under:
  - prefs name: `SessionPrefs`
  - key: `sessionToken`
- `Profile` removes `sessionToken` on logout
- No app-defined backend, API client, or internet permission was found
- The strongest randomness-relevant code path is `Login.generateSessionToken()`, which uses `java.util.Random`

## Evidence commands used

- `sed -n '1,220p' decompiled/apktool-a1_case1/AndroidManifest.xml`
- `find decompiled/jadx-a1_case1/sources -type f \\( -name '*.java' -o -name '*.kt' \\) | rg -v '/(androidx|android|kotlin|kotlinx|com/google|org/intellij|org/jetbrains)/'`
- `sed -n '1,240p' decompiled/jadx-a1_case1/sources/com/example/mastg_test0016/MainActivity.java`
- `sed -n '1,260p' decompiled/jadx-a1_case1/sources/com/example/mastg_test0016/Login.java`
- `sed -n '1,260p' decompiled/jadx-a1_case1/sources/com/example/mastg_test0016/Profile.java`
- `rg -n "login|register|auth|token|session|password|reset|otp|code|SharedPreferences|SQLite|Room|Retrofit|OkHttp|Volley|WebView|Random|SecureRandom|UUID|Math\\.random|Cipher|Key|SecretKey|MessageDigest|AES|DES|RSA|IV|salt|hash|Base64|openFileOutput|openFileInput" decompiled/jadx-a1_case1/sources/com/example/mastg_test0016 decompiled/jadx-a1_case1/resources/res`
- `rg -n "WebView|loadUrl|loadData|getSettings|setJavaScriptEnabled|Retrofit|OkHttp|Volley|HttpURLConnection|Socket|https?://|INTERNET" decompiled/jadx-a1_case1/sources/com/example/mastg_test0016 decompiled/apktool-a1_case1/AndroidManifest.xml decompiled/jadx-a1_case1/resources/res`
- `nl -ba decompiled/jadx-a1_case1/sources/com/example/mastg_test0016/MainActivity.java | sed -n '1,220p'`
- `nl -ba decompiled/jadx-a1_case1/sources/com/example/mastg_test0016/Login.java | sed -n '1,260p'`
- `nl -ba decompiled/jadx-a1_case1/sources/com/example/mastg_test0016/Profile.java | sed -n '1,220p'`

## Task 2 output created

- Added `notes/task2_static_analysis.md`

This note includes:

- app behavior summary
- readable main components section
- important assets
- key data flows
- simple system model
- direct assumptions and attacker goals
- Task 3 preparation notes with ranked candidate code locations
- evidence checklist for later screenshots/reporting

## Task 3 lead recorded

Highest-value candidate for the vulnerability analysis:

- `decompiled/jadx-a1_case1/sources/com/example/mastg_test0016/Login.java`
  - `createSession()` at lines 174-177
  - `generateSessionToken()` at lines 183-189

Reason:

- the token is used as session state
- it is generated with `java.util.Random`
- the app overview string explicitly says the case is about insecure login/session randomness

## Limits recorded

- `getSessionToken()` exists, but no first-party caller was found
- `activity_profile.xml` contains a `WebView`, but no first-party code loads content into it
- Local data paths are confirmed through Android storage APIs, not hardcoded absolute paths in code

## Git audit trail intended for this session

- commit Task 2 note and log with a short progress-focused message
