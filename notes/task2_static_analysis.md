# Task 2 Static Analysis Notes

## A. App behavior summary

### Observed dynamically
- The app presents a registration-style screen, a login screen, and a profile screen with a logout button.
- Registering appears to save entered credentials locally, and successful login transitions to the profile screen.

### Confirmed by static analysis
- The app is a small local demo focused on login/session handling rather than a real service-backed account system. `MainActivity` collects a username and password, saves them to an internal file named `credentials.txt`, and then opens `Login` ([MainActivity.java](../decompiled/jadx-a1_case1/sources/com/example/mastg_test0016/MainActivity.java)).
- `Login` reads `credentials.txt`, checks whether the entered username/password pair matches a stored line, and on success creates a session token in `SharedPreferences` before opening `Profile` ([Login.java](../decompiled/jadx-a1_case1/sources/com/example/mastg_test0016/Login.java)).
- `Profile` only exposes a logout button that deletes the stored session token; no backend, remote API, or server-side validation is present in the app package or manifest ([Profile.java](../decompiled/jadx-a1_case1/sources/com/example/mastg_test0016/Profile.java), [AndroidManifest.xml](../decompiled/apktool-a1_case1/AndroidManifest.xml)).
- The UI text explicitly says the case is about an insecure login session mechanism using `Java.Util.Random`, which aligns with the token-generation code path ([strings.xml](../decompiled/jadx-a1_case1/resources/res/values/strings.xml)).

## B. Main components

- `MainActivity` (`com.example.mastg_test0016.MainActivity`)
  - Launcher activity and registration-style entry screen.
  - Reads username/password from the UI, writes them to `credentials.txt`, and opens `Login`.
  - Evidence: `MainActivity.onCreate`, `saveCredentialsToFile`.

- `Login` (`com.example.mastg_test0016.Login`)
  - Login screen and main authentication logic.
  - Reads username/password input, checks them against `credentials.txt`, generates a session token, stores it in `SharedPreferences`, and opens `Profile`.
  - Evidence: `Login.onCreate`, `checkCredentials`, `createSession`, `generateSessionToken`.

- `Profile` (`com.example.mastg_test0016.Profile`)
  - Post-login screen.
  - Provides a logout button that removes the stored session token.
  - Evidence: `Profile.onCreate`, `clearSession`.

- `credentials.txt`
  - Internal app file used as the credential store.
  - Holds registered username/password pairs as plaintext lines.
  - Evidence: `MainActivity.saveCredentialsToFile`, `Login.checkCredentials`.

- `SessionPrefs` with key `sessionToken`
  - `SharedPreferences` store used for session state.
  - Holds the generated session token after successful login.
  - Evidence: `Login.createSession`, `Login.getSessionToken`, `Profile.clearSession`.

- UI layouts
  - `activity_main.xml`: registration screen with overview text, username/password fields, Register button, and Login button.
  - `activity_login.xml`: login screen with username/password fields and Login button.
  - `activity_profile.xml`: profile screen with a `WebView` placeholder and Log out button.

### Notes on omitted components
- No fragments were found in the first-party package.
- No SQLite/Room database classes were found.
- No Retrofit/OkHttp/Volley/WebView loading logic was found. A `WebView` widget exists in `activity_profile.xml`, but no first-party code references it.
- No explicit authentication backend, API client, or network permission was found in the manifest.

## C. Important assets

- Username/password pairs in `credentials.txt`
  - Security relevance: these are the primary authentication secrets accepted by `Login.checkCredentials`.
  - Evidence: `MainActivity.saveCredentialsToFile` writes `Username: <user> Password: <pass>`; `Login.checkCredentials` reads and compares them.
- Session token stored under `SessionPrefs` / `sessionToken`
  - Security relevance: this is the app's only explicit session artifact and is created immediately after successful login.
  - Evidence: `Login.createSession` stores the generated token; `Profile.clearSession` deletes it.
- Session token generation logic
  - Security relevance: the entropy source and generation algorithm determine whether the session token is predictable.
  - Evidence: `Login.generateSessionToken` builds a 16-character token from an alphanumeric alphabet using `java.util.Random`.
- Registration/login input values in UI fields
  - Security relevance: they are the direct source of stored credentials and login attempts.
  - Evidence: `activity_main.xml`, `activity_login.xml`, and the corresponding `EditText` reads in `MainActivity.onCreate` and `Login.onCreate`.

### Values that appear less security-relevant
- `MainActivity.randomNumberGenerator()`
  - It uses `Random`, but there is no caller in the first-party code and no security sink connected to it.
- `WebView` in `activity_profile.xml`
  - Present in layout only; no content load or security use is confirmed.

## D. Data flows

### Registration flow
1. User enters username and password in `MainActivity`.
2. `MainActivity.saveCredentialsToFile` writes a plaintext line to internal storage file `credentials.txt`.
3. App starts `Login`.

### Login flow
1. User enters username and password in `Login`.
2. `Login.checkCredentials` opens `credentials.txt`, reads it line by line, splits on spaces, and compares the entered pair to the stored values.
3. If no match is found, the app shows `Wrong Credential`.
4. If a match is found, `Login.createSession` stores a generated token in `SharedPreferences` and the app starts `Profile`.

### Session creation/storage flow
1. `Login.generateSessionToken` creates a 16-character alphanumeric string using `Random.nextInt(62)`.
2. `Login.createSession` stores that token at `SessionPrefs` / `sessionToken`.
3. `Login.getSessionToken` can retrieve it, but no caller was found in the first-party code.

### Logout flow
1. User taps `Log out` in `Profile`.
2. `Profile.clearSession` removes `sessionToken` from `SessionPrefs`.
3. No navigation away from `Profile` and no revalidation logic were found in `Profile`.

### Network/backend flow
- None confirmed.
- Static evidence found no app-defined network client, no `INTERNET` permission, and no remote endpoint strings in the first-party package.

## E. Initial system model draft

### Simple text model
- User interacts with three activities: `MainActivity` -> `Login` -> `Profile`.
- App logic stores credentials in internal file storage (`credentials.txt`) and stores a session token in `SharedPreferences` (`SessionPrefs` / `sessionToken`).
- The session token is generated locally by `Login.generateSessionToken` using `java.util.Random`.
- No backend or remote verification is present; both credential validation and session state are local to the device.

### Mermaid diagram
```mermaid
flowchart LR
    U[User]
    M[MainActivity\nregister UI]
    L[Login\ncredential check + session creation]
    P[Profile\nlogout UI]
    F[(Internal file\ncredentials.txt)]
    S[(SharedPreferences\nSessionPrefs/sessionToken)]
    R[Random-based token generator\nLogin.generateSessionToken()]

    U -->|enter username/password| M
    M -->|write plaintext credentials| F
    M -->|startActivity| L
    U -->|enter login credentials| L
    L -->|read + compare| F
    L -->|on success| R
    R -->|16-char token| S
    L -->|startActivity| P
    P -->|logout removes token| S
```

## F. Assumptions and attacker goals

### Core assumptions
- The attacker can obtain and reverse engineer the APK, because the assignment context is a mobile APK reverse-engineering setting.
- The attacker can run the app on their own device/emulator and create their own accounts to observe behavior.
- The attacker can inspect app logic statically and can read local app data on a rooted device, emulator, or through other strong local access. This is realistic for mobile app assessment, even though `android:allowBackup="false"` reduces easy backup-based extraction.
- No server-side checks exist in this app, so any authentication/session guarantees must come entirely from local code and locally stored values.

### Realistic attacker capabilities
- Read decompiled Java/smali and resource files.
- Observe when login succeeds and when a session token is created.
- Read or tamper with locally stored `credentials.txt` and `SharedPreferences` when operating with local device-level access.
- Reproduce the token generation algorithm because it is present in the APK.

### Realistic attacker goals
- Predict or reproduce session tokens generated after login, because the token appears to represent authenticated session state.
- Recover plaintext credentials from local storage.
- Manipulate or replay locally stored session state to bypass or simulate login state on the device.

### Assignment-focused framing
- The strongest Task 3 direction is the randomness used for session-token generation, because it directly produces a security-sensitive value rather than a UI-only identifier.

## G. Task 3 preparation notes

### Ranked candidate randomness/crypto-related locations

1. `Login.generateSessionToken()`
   - Helper/API used: `java.util.Random`, `nextInt(62)`, fixed alphanumeric alphabet.
   - Suspected security role: creates the session token stored after successful login.
   - Why ranked highest: this is directly tied to authenticated session state via `createSession()`.

2. `Login.createSession()`
   - Helper/API used: `SharedPreferences.Editor.putString`.
   - Suspected security role: persists the generated session token under `sessionToken`.
   - Why relevant: this is the sink showing the token is treated as a security-relevant session artifact.

3. `MainActivity.randomNumberGenerator()`
   - Helper/API used: `java.util.Random`, `nextInt(100)`.
   - Suspected security role: unclear; likely demo or leftover helper only.
   - Why ranked lower: no caller or security use was found.

### Candidate issue prioritisation
- Highest priority: insecure randomness in `Login.generateSessionToken`, because it creates a token intended for session handling.
- Secondary context: plaintext local credential storage is clearly present, but it is outside the assignment's main randomness/cryptography marking scope.
- Low priority: `MainActivity.randomNumberGenerator()` because it currently looks disconnected from any asset or trust decision.

### Confirmed vs inferred
- Confirmed: token generation uses `java.util.Random`; token is stored as `sessionToken` in `SharedPreferences`; the app overview string explicitly frames the case around insecure login session randomness.
- Inferred: the stored token is intended to represent authenticated state, because it is created immediately after successful login and removed on logout, even though no later token validation path is implemented in the visible first-party code.

## H. Evidence checklist

- Capture the manifest showing only three first-party activities and no internet permission:
  - `decompiled/apktool-a1_case1/AndroidManifest.xml`
- Capture the overview string and main screen text that explicitly mention insecure login/session randomness:
  - `decompiled/jadx-a1_case1/resources/res/values/strings.xml`
  - `decompiled/jadx-a1_case1/resources/res/layout/activity_main.xml`
- Capture plaintext credential storage code:
  - `MainActivity.saveCredentialsToFile`
- Capture credential validation code reading `credentials.txt`:
  - `Login.checkCredentials`
- Capture session token generation code:
  - `Login.generateSessionToken`
- Capture session token persistence and deletion:
  - `Login.createSession`
  - `Profile.clearSession`
- Capture profile layout showing the `WebView` placeholder and logout button, in case asked whether any network/browser functionality exists:
  - `activity_profile.xml`

## End-of-task summary

### 1. What is confidently established
- The app is a local three-activity demo: register credentials, log in against a local plaintext file, then create/delete a locally stored session token.
- The only clearly security-relevant randomness path is `Login.generateSessionToken()`, which uses `java.util.Random` for a session token.
- No backend/API layer is present in the first-party code or manifest.

### 2. What is still uncertain
- Whether any hidden runtime-only behavior exists outside the decompiled first-party Java code, though no evidence of this appeared in the manifest or resource search.
- Whether the generated session token is intended to gate access elsewhere in a broader version of the app, because `getSessionToken()` exists but is not called in the visible code.
- The exact internal filesystem path of `credentials.txt` and the preferences XML is not hardcoded in app code; only the storage APIs confirm internal app storage use.

### 3. Best next step for Task 3
- Focus Task 3 on `Login.generateSessionToken()` and trace its security role through `createSession()` and `clearSession()`.
- Build the argument around why `java.util.Random` is inappropriate for session-token generation, using the code path and the app's own overview string as supporting evidence.
