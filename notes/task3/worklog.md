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

## 2026-03-14 22:38:27 AEDT
- Checked: what an attacker must actually know and do to exploit the chosen issue in this local-only APK.
- Found: the most realistic model is a reverse engineer with local device/emulator access who can observe login timing, reproduce the deterministic token generator, and replay the locally stored session artifact.
- Conclusion change: threat and impact framing now explicitly centers on local session-token reconstruction/replay, which is strong enough for the assignment while staying within the evidence.
- Next step: write the mitigation, evidence checklist, and AI log; then commit the final documentation stage.

## 2026-03-14 22:39:14 AEDT
- Checked: mitigation quality, reusable evidence list, and whether the documentation package is sufficient for report/presentation/Q&A reuse.
- Found: `SecureRandom` replacement is the direct root-cause fix; the strongest remaining uncertainty is not the weakness itself but the exact end-to-end impact in this local-only APK.
- Conclusion change: final package now explicitly separates confirmed weakness from impact boundary, which should improve defensibility under questioning.
- Next step: commit the final documentation set and produce the closing summary with commit hashes and remaining validation items.

## 2026-03-14 23:29:00 AEDT
- Checked: `assignment_details/assignment1-spec-2.txt` and `assignment_details/assignment1-rubric-2.txt` against the current Task 3 notes and AI log.
- Found: the Task 3/4 written analysis aligns well with the marked scope and rubric criteria, but the notes still referenced the earlier PDF-tooling limitation and needed an explicit spec/rubric compliance pass.
- Conclusion change: the package needs a small compliance pass, not a finding change. The vulnerability choice and evidence remain the same.
- Next step: update the notes/AI log to cite the text spec/rubric directly and add a concise compliance audit.
