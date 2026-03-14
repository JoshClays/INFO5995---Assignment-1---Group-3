# Task 3 Attack Scenario

## Scenario Name
- Predictable local session-token reconstruction and replay.

## Preconditions
- The attacker has the APK and can reverse engineer it.
- The attacker has a controlled assessment environment with local access strong enough to inspect or modify app-private data.
- The attacker can observe or trigger a successful login event and record the approximate creation time of the token.

## Step-by-Step Scenario
1. Reverse engineer the APK and confirm that `Login.generateSessionToken()` creates the session token with `new Random()` and `nextInt(62)` over a fixed alphanumeric alphabet.
2. Confirm that a successful login immediately stores the generated value in `SessionPrefs/sessionToken`, making that value the app's session artifact.
3. Observe a login event on the target test device, or trigger one in a controlled reproduction, so the attacker can narrow when the token was generated.
4. Reproduce the token-generation algorithm offline and search candidate `java.util.Random` states consistent with the observed login window until the generated 16-character token matches the stored value or a candidate set small enough for practical local testing.
5. Use local storage access to replay the recovered token by writing it back into `SessionPrefs/sessionToken`, or validate the reconstruction by comparing it against the value already stored there.
6. Relaunch or continue interacting with the app with the replayed session artifact in place, demonstrating that the token is predictable/reproducible rather than an unguessable session secret.

## Attacker Leverage
- The attacker does not need to break encryption because no cryptographic protection is present.
- The attacker wins by exploiting deterministic, non-cryptographic token generation for a security-sensitive value.

## Impact
- Immediate, evidence-backed impact: the app's session token is predictable enough to be reconstructed or replayed in a local assessment setting, so it fails the security requirement for an authentication/session secret.
- If later code or a future version of the app starts trusting `sessionToken` as an access-control gate, this same weakness becomes a direct impersonation primitive.

## Defensible Boundary
- This scenario does not claim a proven remote takeover because the visible APK has no backend and no visible later token-validation path.
- The strongest claim supported by the current evidence is predictable local session simulation/replay, not confirmed server-side session hijacking.
