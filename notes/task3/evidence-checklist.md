# Task 3 Evidence Checklist

## Core Evidence to Capture

| ID | Evidence item | Why it matters | Status | Primary source |
| --- | --- | --- | --- | --- |
| E1 | `Login.generateSessionToken()` uses `java.util.Random` and `nextInt(62)` | Proves weak randomness in the selected issue | Confirmed | `decompiled/jadx-a1_case1/sources/com/example/mastg_test0016/Login.java:183-189` |
| E2 | `Login.createSession()` stores generated value in `SessionPrefs/sessionToken` | Proves the weak random value is treated as session state | Confirmed | `decompiled/jadx-a1_case1/sources/com/example/mastg_test0016/Login.java:174-176` |
| E3 | Login button call path: `checkCredentials()` -> `createSession()` -> `Profile` | Proves the token is created only after successful login | Confirmed | `decompiled/jadx-a1_case1/sources/com/example/mastg_test0016/Login.java:49-59` |
| E4 | `Profile.clearSession()` removes `sessionToken` | Proves the same value is lifecycle-managed as a session artifact | Confirmed | `decompiled/jadx-a1_case1/sources/com/example/mastg_test0016/Profile.java:35-39`, `49-52` |
| E5 | `strings.xml` overview mentions insecure login session randomness via `Java.Util.Random` | Supports assignment framing and presentation narrative | Confirmed | `decompiled/jadx-a1_case1/resources/res/values/strings.xml:151` |
| E6 | `activity_main.xml` displays the overview string on the main screen | Links the resource evidence to the visible UI | Confirmed | `decompiled/jadx-a1_case1/resources/res/layout/activity_main.xml:38-47` |
| E7 | Manifest shows only three first-party activities and no `INTERNET` permission | Supports the local-only threat model and impact boundary | Confirmed | `decompiled/apktool-a1_case1/AndroidManifest.xml:5-13` |
| E8 | `MainActivity.randomNumberGenerator()` has no visible first-party caller | Helps rule out the lower-value randomness path | Confirmed | `decompiled/jadx-a1_case1/sources/com/example/mastg_test0016/MainActivity.java:17-20` plus call-site search |
| E9 | No first-party `SecureRandom` / `Cipher` / `hash` helpers found | Supports the claim that no stronger crypto path exists to offset the weakness | Confirmed | first-party keyword sweep over `com/example/mastg_test0016` |

## Optional Human Validation Before Submission or Demo
- Validate the exact Android runtime behavior of `new Random()` on the emulator/device used for any live PoC.
- If presenting a live replay demo, verify the exact on-device location/name of the `SessionPrefs` XML file in that environment.
- If the tutor asks about impact, be ready to state that remote session hijacking is not proven because no backend or later token-validation logic is visible.

## Ready-to-Reuse Report Claims
- "The app's session token is generated with `java.util.Random`, which is not suitable for security-sensitive secrets."
- "The weak token is immediately stored as `SessionPrefs/sessionToken`, showing it is intended to represent session state."
- "Because the APK is local-only, the strongest evidence-backed exploit claim is predictable local session-token reconstruction or replay."
