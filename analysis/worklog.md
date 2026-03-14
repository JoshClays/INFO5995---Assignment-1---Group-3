# Analysis Worklog

## 2026-03-14 22:36:54 AEDT
- Checked: `notes/task2_static_analysis.md`, first-party source files, manifest, main-screen resources, and a keyword sweep over the app package/resources for randomness and crypto terms.
- Found: Task 2's core claim is still correct. `Login.generateSessionToken()` uses `java.util.Random`; the token is stored in `SessionPrefs/sessionToken`; `Profile.clearSession()` removes it; no first-party backend/network path is visible.
- Conclusion change: strengthened confidence in the session-token randomness issue; refined that `getSessionToken()` has no visible caller and `MainActivity.randomNumberGenerator()` is non-security dead/demo code.
- Next step: capture the inventory in a reusable markdown artifact and commit the validation/inventory milestone.

## 2026-03-14 22:36:54 AEDT
- Checked: ability to extract the updated assignment PDFs locally.
- Found: no working PDF text extraction toolchain is available in this environment (`pdftotext`, `pypdf`, `pip`, and `ensurepip` unavailable).
- Conclusion change: analysis will align to the updated constraints explicitly provided in the task prompt and will document the environment limitation rather than guessing unseen PDF wording.
- Next step: continue with evidence-backed Task 3/4 deliverables focused only on randomness/cryptography.

## 2026-03-14 22:37:43 AEDT
- Checked: exact `Login` to `Profile` call path, token storage/removal lifecycle, and whether any first-party code reads the stored session token.
- Found: the strongest in-scope issue remains `Login.generateSessionToken()` because it is the only first-party randomness path feeding the explicit session artifact. `getSessionToken()` exists but has no visible first-party caller.
- Conclusion change: impact statement was tightened to avoid overclaiming. The issue is confirmed as weak session-token generation, while full authorization bypass is not statically proven in the visible APK.
- Next step: draft the threat model and attack scenario around predictable local session-token creation.
