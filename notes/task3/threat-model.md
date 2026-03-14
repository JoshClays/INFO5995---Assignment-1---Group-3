# Task 3 Threat Model

## Chosen Vulnerability
- Predictable session-token generation in `Login.generateSessionToken()` using `java.util.Random`.

## Protected Assets
- `SessionPrefs/sessionToken`, which is the app's only explicit session artifact after successful login.
- The app's intended authenticated state transition from `Login` to `Profile`.
- The security property that a session token should be unguessable to anyone who knows the app code.

## Attacker Types
- Reverse engineer / assessor with the APK and a controlled device or emulator.
- Local attacker with temporary access to the device plus elevated local access (root, emulator access, instrumentation, or repackaging) sufficient to inspect or modify app-private storage.

## Attacker Capabilities
- Decompile the APK and recover the exact token algorithm, alphabet, length, and storage path.
- Observe when a login succeeds, or trigger login on a controlled test instance.
- Approximate the token-creation time closely enough to narrow candidate PRNG states.
- Read or overwrite `SessionPrefs/sessionToken` once local storage access is available.

## Attacker Observations Needed
- The token format: 16 characters from `[A-Za-z0-9]`. Confirmed in `Login.java:183-189`.
- The fact that a token is created only after successful login and is stored in `SessionPrefs/sessionToken`. Confirmed in `Login.java:52-59`, `174-176`.
- The fact that logout removes that same token. Confirmed in `Profile.java:49-52`.
- Approximate timing of the login event or another way to narrow the PRNG state search.

## Attacker Constraints
- No first-party backend or remote session validation is visible in the APK, so the exploit scope is local rather than remote.
- The visible APK does not show a later authorization check against `sessionToken`, so the strongest proven impact is session-token prediction/replay as a local artifact.
- Access to app-private storage requires stronger-than-normal local capabilities; this is realistic in an APK assessment setting but should be stated explicitly.

## Attacker Goal
- Reconstruct or inject the same session token value the app would treat as valid-looking authenticated state, allowing local replay or simulation of the app's session artifact.

## Why This Threat Model Fits This APK
- The assignment context is APK reverse engineering, so assuming code disclosure is realistic.
- The app is fully local: credential checking, token generation, token storage, and logout are all performed on-device.
- Because there is no server-side session layer to target, the most realistic attacker is a local reverse engineer trying to predict or replay the locally generated session token.

## Fact / Inference / Uncertainty Split
- Confirmed facts: algorithm, storage path, creation path, logout path, and lack of first-party network permission.
- Strong inference: `sessionToken` is intended as authenticated state because it is the only explicit session artifact created after login and deleted on logout.
- Remaining uncertainty: the exact end-to-end authorization effect of replaying `sessionToken` is limited by the lack of visible token-validation logic elsewhere in the APK.
