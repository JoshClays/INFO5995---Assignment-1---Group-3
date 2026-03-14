# Task 3 AI Log

## Scope
- Objective: produce a Task 3 to Task 4 quality investigation package aligned to the updated assignment focus on randomness and cryptography.
- Baseline used: `notes/task2_static_analysis.md`.

## Evidence Sources Read
- `notes/task2_static_analysis.md`
- `decompiled/jadx-a1_case1/sources/com/example/mastg_test0016/MainActivity.java`
- `decompiled/jadx-a1_case1/sources/com/example/mastg_test0016/Login.java`
- `decompiled/jadx-a1_case1/sources/com/example/mastg_test0016/Profile.java`
- `decompiled/apktool-a1_case1/AndroidManifest.xml`
- `decompiled/jadx-a1_case1/resources/res/values/strings.xml`
- `decompiled/jadx-a1_case1/resources/res/layout/activity_main.xml`

## Key Confirmed Facts
- `Login.generateSessionToken()` uses `java.util.Random` and `nextInt(62)` to create a 16-character alphanumeric token.
- `Login.createSession()` stores that value in `SessionPrefs/sessionToken`.
- `Profile.clearSession()` removes the same preference key on logout.
- No first-party backend/network path was found.
- `MainActivity.randomNumberGenerator()` exists but has no visible caller in the first-party package.

## Key Reasoning Decisions
- Selected weak session-token generation as the core issue because it is the only first-party randomness path directly tied to a protected asset.
- Treated plaintext credential storage as contextual background only, because the updated marking scope is randomness/cryptography.
- Limited the exploit claim to local session-token reconstruction/replay because no visible code proves later authorization checks based on `sessionToken`.

## Constraints and Limitations
- The updated PDF spec/rubric files could not be text-extracted in this environment because no working PDF text extraction toolchain was available.
- No live PoC execution was performed in this turn.
- Exact runtime seeding details for Android's `Random` implementation were not validated on-device.

## Deliverables Produced
- `notes/task3/inventory.md`
- `notes/task3/core-vulnerability.md`
- `notes/task3/threat-model.md`
- `notes/task3/attack-scenario.md`
- `notes/task3/fix.md`
- `notes/task3/evidence-checklist.md`
- `notes/task3/worklog.md`

## Commit Trail So Far
- `197739f` `validate task2 findings and inventory randomness paths`
- `93870af` `document core weak session token vulnerability`
- `d22d80b` `add threat model and attack scenario for predictable session token`
