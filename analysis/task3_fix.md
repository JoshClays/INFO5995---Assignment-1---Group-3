# Task 3 Fix

## Exact Mitigation
- Replace `java.util.Random` in `Login.generateSessionToken()` with a cryptographically secure random source such as `java.security.SecureRandom`.

## Why This Fix Addresses the Root Cause
- The root cause is not token length or alphabet choice; it is the use of a deterministic non-cryptographic PRNG for a security-sensitive token.
- `SecureRandom` is designed for secrets such as session identifiers and provides unpredictability that `java.util.Random` does not.

## Code-Level Replacement Suggestion

```java
import java.security.SecureRandom;

private static final SecureRandom SECURE_RANDOM = new SecureRandom();
private static final char[] TOKEN_ALPHABET =
        "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789".toCharArray();

private String generateSessionToken() {
    StringBuilder sb = new StringBuilder(32);
    for (int i = 0; i < 32; i++) {
        sb.append(TOKEN_ALPHABET[SECURE_RANDOM.nextInt(TOKEN_ALPHABET.length)]);
    }
    return sb.toString();
}
```

## Why This Version Is Better
- It keeps the implementation simple and close to the original code path, which is easy to explain in a report or Q&A.
- It replaces the weak randomness source with a CSPRNG.
- It also increases token length from 16 to 32 characters, adding a safety margin even though the main improvement is the stronger randomness source.

## Additional Defensive Improvements
- If the token is meant to guard access, add an explicit session-validation check before showing protected screens.
- Expire the token on app restart or after a short inactivity period if persistent login is unnecessary.
- If a future version adds a backend, move session issuance and validation server-side instead of trusting a purely local token.

## Minimal Fix Statement
- Recommended fix: use `SecureRandom` for session-token generation and treat `sessionToken` as a real secret, not a random-looking UI value.
