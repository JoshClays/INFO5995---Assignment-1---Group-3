# Task 3 Randomness/Crypto Inventory

## Scope note
- Source of truth used for scope: updated Assignment 1 instructions provided in the task prompt, plus code/resource evidence from the decompiled APK.
- Environment limitation: the updated PDF spec/rubric files are present, but this environment does not currently have a working PDF text extractor. No conclusion below depends on unseen PDF text; the analysis stays aligned to the user-supplied updated marking constraints: focus on randomness/cryptography and prioritize one strong issue.

## Task 2 Validation Status

### Confirmed
- `Login.generateSessionToken()` uses `java.util.Random` to build a 16-character alphanumeric token. Evidence: `decompiled/jadx-a1_case1/sources/com/example/mastg_test0016/Login.java:183-189`.
- `Login.createSession()` stores the generated token in `SharedPreferences` under `SessionPrefs` / `sessionToken`. Evidence: `decompiled/jadx-a1_case1/sources/com/example/mastg_test0016/Login.java:174-176`.
- `Profile.clearSession()` removes `sessionToken` on logout. Evidence: `decompiled/jadx-a1_case1/sources/com/example/mastg_test0016/Profile.java:49-52`.
- The first-party app logic is a local 3-activity demo (`MainActivity`, `Login`, `Profile`) with no first-party network permission and no backend/API client evidence. Evidence: `decompiled/apktool-a1_case1/AndroidManifest.xml:5-13`, plus the only first-party source files under `com/example/mastg_test0016`.
- The app resources explicitly frame the case around insecure login-session randomness. Evidence: `decompiled/jadx-a1_case1/resources/res/values/strings.xml:151`, referenced by `decompiled/jadx-a1_case1/resources/res/layout/activity_main.xml:38-47`.

### Refined
- `Login.getSessionToken()` exists, but no first-party caller was found. The token is therefore confirmed as a stored session artifact, but not as an actively revalidated guard elsewhere in the visible APK.
- `MainActivity.randomNumberGenerator()` is real and uses `Random`, but no call site was found in the first-party package. It is likely demo or dead code, not the main security issue.
- The app also handles plaintext credentials (`credentials.txt`), but that is secondary context only because the updated marking scope is randomness/cryptography.

### Contradicted
- None from Task 2.

## Inventory Table

| ID | File/Class | Method | API/helper used | Value produced/handled | Security role | Reachability/evidence | Security relevance ranking | Notes |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| R1 | `Login.java` | `generateSessionToken()` | `java.util.Random`, `nextInt(62)` | 16-char alphanumeric token | Session token | Called by `createSession()` after successful credential check. Evidence: `Login.java:52-59`, `174-189`. | Critical | Core in-scope randomness issue. Token is intended to represent authenticated state. |
| R2 | `Login.java` | `createSession()` | `SharedPreferences.Editor.putString` | `sessionToken` persisted in `SessionPrefs` | Session state persistence | Called immediately after `checkCredentials(...)` returns true. Evidence: `Login.java:52-59`, `174-176`. | High | Confirms R1 feeds a security-sensitive sink. |
| R3 | `Login.java` | `getSessionToken()` | `SharedPreferences.getString` | Stored `sessionToken` | Session token retrieval | Method exists but no first-party caller found. Evidence: `Login.java:179-180`; search found no call sites. | Medium | Supports intent of token as session artifact, but no active validation path is visible. |
| R4 | `Profile.java` | `clearSession()` | `SharedPreferences.Editor.remove` | Deletes `sessionToken` | Session termination | Bound to logout button. Evidence: `Profile.java:35-39`, `49-52`. | High | Confirms the token is lifecycle-managed as session state. |
| R5 | `Login.java` | `checkCredentials()` | `openFileInput`, `BufferedReader` | Username/password pairs from `credentials.txt` | Credential handling | Called from login button handler. Evidence: `Login.java:49-58`, `71-172`. | Medium | Security-sensitive data handling, but outside the updated randomness/crypto marking focus. |
| R6 | `MainActivity.java` | `saveCredentialsToFile()` | `openFileOutput`, raw bytes | Plaintext username/password line | Credential storage | Called from Register button handler. Evidence: `MainActivity.java:31-38`, `54-85`. | Medium | Useful context for Q&A, but not the selected in-scope issue. |
| R7 | `MainActivity.java` | `randomNumberGenerator()` | `java.util.Random`, `nextInt(100)` | Integer 0-99 | UI/demo-only random value | No call site found in first-party code. Evidence: `MainActivity.java:17-20`; search found no callers. | Low | Randomness is present, but not connected to a protected asset or trust decision. |
| R8 | `strings.xml` + `activity_main.xml` | n/a | Resource string reference | Overview text about insecure login session randomness | UI-only explanatory text | Displayed on launch screen. Evidence: `strings.xml:151`, `activity_main.xml:38-47`. | Low | Supports assignment framing, not itself a vulnerability. |

## Negative Search Results
- No first-party `SecureRandom` usage found.
- No first-party `Cipher`, `MessageDigest`, `Mac`, `KeyStore`, `SecretKey`, `encrypt`, `decrypt`, `hash`, `iv`, or `nonce` usage found.
- No first-party hardcoded secret or crypto helper class was found.
- Most additional keyword hits come from Android/support libraries and are not part of the app's own security design.

## Selection Outcome
- Strongest in-scope issue: `Login.generateSessionToken()` using `java.util.Random` for a session token.
- Reason: it is the only first-party randomness path that directly creates a security-relevant value and feeds the app's explicit session storage path.
