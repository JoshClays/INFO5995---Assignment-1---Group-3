# POC README

## Title
Predictable local session token generated with `java.util.Random`

## Video File
- `pocs/Group4_Info5995_POC.mp4`

## Purpose
This PoC supports the Assignment 1 `pocs/` submission item. It demonstrates the selected Task 3 vulnerability: the app generates its session token with `java.util.Random` and stores that value in `SessionPrefs/sessionToken` after successful login.

## AI Assistance
- AI was used to help structure the PoC workflow, draft the narration, draft this README, and organise the evidence so the claims stayed aligned with the assignment scope.
- The PoC itself was still validated manually by running the APK, logging in on the emulator, inspecting `SessionPrefs.xml`, and checking the decompiled code paths.
- AI was not used to invent exploit results beyond what was observed in the emulator and supported by the decompiled files.

## Core Claim
- The app's session token is generated with `java.util.Random`, which is not suitable for a security-sensitive secret.
- The generated value is stored as `SessionPrefs/sessionToken`, so it is treated as session state.
- Because the APK is local-only, the strongest evidence-backed impact claim is local session-token replay or analysis in a privileged assessment environment, not proven remote account takeover.

## What The Video Demonstrates
1. A successful login moves the user to the profile screen.
2. After login, `SessionPrefs.xml` contains a `sessionToken` value.
3. `Login.java` shows that successful login calls `createSession()`.
4. `createSession()` stores the generated token in `SessionPrefs/sessionToken`.
5. `generateSessionToken()` uses `java.util.Random` and `nextInt(62)` to build the token.
6. `Profile.java` removes `sessionToken` on logout.
7. The correct fix is to replace `java.util.Random` with `java.security.SecureRandom`.

## Reproduction Environment
- Host machine:
  - Model: MacBook Air
  - Chip: Apple M4
  - CPU cores: 10
  - Memory: 16 GB
  - Architecture: arm64
  - Operating system: macOS 15.5
- Android tooling observed locally:
  - Android SDK `adb`: version `37.0.0-14910828`
  - Installed AVDs: `Medium_Phone_API_36.1`, `Pixel_8`
- Emulator used for the recorded PoC:
  - AVD name: `Medium_Phone_API_36.1`
  - Android Studio UI during recording showed Android `16.0`

## How To Reproduce The PoC
1. Start the `Medium_Phone_API_36.1` Android emulator in Android Studio.
2. Install the APK from `original-apk/a1_case1.apk`.
3. Open the app and register a test username and password.
4. Move to the login screen and log in with the same credentials.
5. Confirm that the app opens the profile screen after successful login.
6. Inspect app-private storage and open `SessionPrefs.xml`.
7. Confirm that a `sessionToken` value exists after login.
8. Open the decompiled `Login.java` file and confirm:
   - the login handler calls `createSession()`
   - `createSession()` stores `SessionPrefs/sessionToken`
   - `generateSessionToken()` uses `java.util.Random`
9. Open `Profile.java` and confirm that logout removes `sessionToken`.
10. Log out and verify that the same session key is removed from `SessionPrefs`.

## Primary Evidence
- `decompiled/jadx-a1_case1/sources/com/example/mastg_test0016/Login.java:52-59`
  - Successful login calls `createSession()` and then opens `Profile`.
- `decompiled/jadx-a1_case1/sources/com/example/mastg_test0016/Login.java:174-176`
  - `createSession()` stores the generated value in `SessionPrefs/sessionToken`.
- `decompiled/jadx-a1_case1/sources/com/example/mastg_test0016/Login.java:183-189`
  - `generateSessionToken()` uses `new Random()` and `nextInt(62)` over an alphanumeric alphabet.
- `decompiled/jadx-a1_case1/sources/com/example/mastg_test0016/Profile.java:49-52`
  - Logout removes the same `sessionToken` key.
- `decompiled/apktool-a1_case1/AndroidManifest.xml:5-13`
  - No `INTERNET` permission or visible first-party backend path is present.

## Safe Interpretation
- This PoC shows that the app uses a deterministic non-cryptographic PRNG for a session token.
- This PoC shows that the weak random value is actually stored and managed as session state.
- This PoC does not prove remote session hijacking or server-side account takeover.

## Fix Demonstrated
- Replace `java.util.Random` with `java.security.SecureRandom` when generating the session token.
- The root cause is predictability, not just token length.

## One-Paragraph Summary
The PoC demonstrates that the APK creates a session token after successful login, stores it as `SessionPrefs/sessionToken`, and generates it with `java.util.Random`. Because `java.util.Random` is a deterministic non-cryptographic PRNG, the token is unsuitable as a secure session secret. The evidence supports a local session-token weakness in a privileged assessment environment, and the appropriate mitigation is to replace `java.util.Random` with `SecureRandom`.
