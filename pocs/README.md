# POC README

## Title
Predictable local session token generated with `java.util.Random`

## Purpose
This POC is for the Assignment 1 `pocs/` submission item and is written to support a short video demonstration.

The core claim is narrow and evidence-backed:
- The app generates its session token with `java.util.Random`, which is not suitable for a security-sensitive secret.
- That token is stored as `SessionPrefs/sessionToken` immediately after successful login.
- Because the APK is local-only, the strongest claim we should make in the video is predictable local session-token reconstruction or replay, not proven remote account takeover.

## Primary evidence
- `decompiled/jadx-a1_case1/sources/com/example/mastg_test0016/Login.java:52-59`
  - Successful login calls `createSession()` and then opens `Profile`.
- `decompiled/jadx-a1_case1/sources/com/example/mastg_test0016/Login.java:174-176`
  - `createSession()` stores the generated value in `SessionPrefs/sessionToken`.
- `decompiled/jadx-a1_case1/sources/com/example/mastg_test0016/Login.java:183-189`
  - `generateSessionToken()` uses `new Random()` and `nextInt(62)` over an alphanumeric alphabet.
- `decompiled/jadx-a1_case1/sources/com/example/mastg_test0016/Profile.java:49-52`
  - Logout deletes the same `sessionToken` key.
- `decompiled/apktool-a1_case1/AndroidManifest.xml:5-13`
  - No `INTERNET` permission or first-party backend component is visible.
- `decompiled/jadx-a1_case1/resources/res/values/strings.xml:151`
  - The app text itself says the test case is about insecure login-session randomness.

## Recommended video outcome
Record one short POC video, ideally `pocs/predictable-session-token.mp4`, showing:
1. The app is a local login demo.
2. Successful login creates a session token.
3. The token generator uses `java.util.Random`.
4. The stored value is treated as session state.
5. The correct fix is `SecureRandom`.

## Recording plan

### Segment 1: Scope and app context
Show:
- The app running in the emulator/device.
- The overview text on the main screen if visible.
- The manifest or notes showing there is no backend/network path.

Say:
"This APK is a local login/session demo. Our chosen vulnerability is not plaintext storage or a generic Android issue. It is the use of `java.util.Random` to generate the app's session token."

### Segment 2: Successful login creates session state
Show:
- A registration if needed.
- A successful login path from `Login` to `Profile`.
- `Login.java` lines `52-59` and `174-176`.

Say:
"After credentials are accepted, the app immediately calls `createSession()` and then opens the `Profile` activity. `createSession()` stores a generated token under `SessionPrefs/sessionToken`, so this value is the app's session artifact."

### Segment 3: Weak randomness at the generation point
Show:
- `Login.java` lines `183-189`.

Say:
"The token is produced by `new Random()` and `nextInt(62)` for 16 characters. `java.util.Random` is deterministic and not a cryptographically secure random source, so it is not appropriate for session secrets."

### Segment 4: Session lifecycle evidence
Show:
- `Profile.java` lines `49-52`.

Say:
"Logout deletes the exact same `sessionToken` key. That confirms the weak random value is being managed as session state rather than as a harmless UI identifier."

### Segment 5: Threat model and impact
Show:
- `notes/task3/threat-model.md` and `notes/task3/attack-scenario.md`, or summarise them on screen.

Say:
"Our attacker is a reverse engineer or local attacker with strong local access on a test device or emulator. With the APK, the algorithm, and a narrow login time window, they can try to reconstruct or replay the locally stored token. We are not claiming remote takeover because no backend or server-side token validation is visible in this APK."

### Segment 6: Fix
Show:
- `notes/task3/fix.md`.

Say:
"The fix is to replace `java.util.Random` with `java.security.SecureRandom` for token generation. That addresses the root cause because the problem is predictability, not just token length."

## Strongest safe POC script
If time is limited, this is the minimum defensible flow:
1. Show app login success.
2. Show `Login.java:52-59`.
3. Show `Login.java:174-176`.
4. Show `Login.java:183-189`.
5. Show `Profile.java:49-52`.
6. State the local-only impact boundary.
7. Show the `SecureRandom` fix.

This version is enough to support the written claim even if no live storage extraction is shown.

## Optional stronger demo
Only include this segment if you validate it on your actual demo environment first.

Possible stronger segment:
- Use emulator/rooted-device local access to inspect or modify the app's stored `SessionPrefs` value after login.
- Compare the stored token with the generation logic and explain how replay or reconstruction becomes plausible because the algorithm is deterministic and non-cryptographic.

Safe wording:
"In this environment we can inspect or replay the local `sessionToken`, which demonstrates why a predictable PRNG is unsuitable for session state."

Unsafe wording to avoid:
- "This definitely gives remote account takeover."
- "We proved server-side session hijacking."
- "Any attacker can do this without local access."

## Presenter notes
- Keep the POC segment evidence-first. Show code and app behavior together.
- Do not overclaim beyond what the APK proves.
- If asked why this counts as security-relevant, point to `createSession()` and `clearSession()` using `SessionPrefs/sessionToken`.
- If asked why not focus on plaintext credentials, say it exists, but the rubric for Assignment 1 marks randomness/cryptography issues only.

## Suggested submission contents
- `pocs/README.md`
- `pocs/predictable-session-token.mp4`

## One-sentence conclusion
The POC demonstrates that the app's only explicit session token is generated with `java.util.Random` and stored as the app's session-state artifact, making it unsuitable as a secure session secret.
