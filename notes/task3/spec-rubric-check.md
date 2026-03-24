# Task 3 Spec/Rubric Check

## Source of Truth
- `assignment_details/assignment1-spec-2.txt`
- `assignment_details/assignment1-rubric-2.txt`

## Current Status Against the Marked Scope
- Satisfied: the analysis stays inside the Assignment 1 scope of randomness/cryptography vulnerabilities.
- Satisfied: the work focuses on one strong issue rather than broad unrelated bug hunting.
- Satisfied: the chosen issue is the security-sensitive use of `java.util.Random` for `SessionPrefs/sessionToken`.

## Rubric Check

### System & Threat Model (4 marks)
- Current state: likely `Exceeds Expectations` in the written notes.
- Why: `threat-model.md` identifies protected assets, attacker capabilities, attacker constraints, and links them directly to the chosen vulnerability.
- Main supporting files: `threat-model.md`, `core-vulnerability.md`, `attack-scenario.md`.

### Vulnerability Discovery & Explanation (6 marks)
- Current state: likely `Exceeds Expectations` in the written notes.
- Why: the package identifies the correct in-scope issue, shows discovery evidence, explains why `java.util.Random` is unsuitable, and gives a concrete step-by-step attack scenario.
- Main supporting files: `core-vulnerability.md`, `attack-scenario.md`, `evidence-checklist.md`, `notes/task2_static_analysis.md`.
- Remaining caution: if you want a live demo, validate the exact Android runtime behavior of `Random` on the demo device first.

### Fix / Mitigation (2 marks)
- Current state: likely `Exceeds Expectations`.
- Why: `fix.md` proposes `SecureRandom`, explains why it addresses the root cause, and gives a concrete replacement snippet.

### Recorded Presentation & Q&A (3 marks)
- Current state: not satisfied yet by the current written notes alone.
- Why: the spec/rubric require a recorded presentation and defensible tutorial Q&A. The notes support that work, but they are not a substitute for the actual video and live defense.

## Spec Task Check

### Task 3
- Satisfied: one well-validated core vulnerability selected.
- Satisfied: the remaining notes still document the selected randomness/crypto issue with exact code location, security role, and supporting evidence.

### Task 4
- Satisfied: generation site, weakness explanation, realistic attacker model, attacker knowledge, and step-by-step attack scenario are documented.

### Task 5 Supporting Materials
- Satisfied: AI log exists and records sources, reasoning, limitations, and deliverables.
- Outstanding outside this note set: `report.pdf`, `presentation.mp4`, `pocs/` video + README, and `activity-log.pdf`.

## Bottom Line
- The current Task 3/4 written package is aligned with the spec/rubric and is strong enough to support an `Exceeds Expectations` level written defense for system/threat model, vulnerability discovery/explanation, and fix/mitigation.
- The remaining work for full assignment compliance is mainly submission packaging and presentation/Q&A performance, not another change in the chosen vulnerability.
