# Security Strategy

## Owning Scope

This file defines generic security rules, secure storage boundaries, input validation responsibility, logging safety, and the production security checklist.

Auth-specific token lifecycle is defined in [`authentication_session.md`](./authentication_session.md). Storage type responsibilities are defined in [`storage_strategy.md`](./storage_strategy.md).

## Security Principles

- Use HTTPS only.
- Never hard-code API secrets.
- Never log tokens, passwords, or private user data.
- Store sensitive values securely.
- Validate user input.
- Sanitize displayed backend content where needed.
- Keep dependencies updated.
- Disable verbose logging in production.
- Clear sensitive data on logout.
- Handle session expiry safely.
- Do not expose stack traces to users.

## Secure Storage Service

Create one app-level secure storage wrapper.

```dart
abstract interface class SecureStorageService {
  Future<void> write(String key, String value);
  Future<String?> read(String key);
  Future<void> delete(String key);
  Future<void> clear();
}
```

Do not use `FlutterSecureStorage` directly inside feature code.

## Input Validation Boundary

Validation should happen at multiple levels:

| Layer | Validation Purpose |
|---|---|
| UI | Required fields, field format, instant feedback |
| Domain | Business rules |
| Backend | Authoritative validation |

Do not trust client-side validation only.

Detailed validation conventions are owned by [`validation.md`](./validation.md).

## Logging Security

Logs must remove:

- Tokens.
- Passwords.
- Authorization headers.
- Refresh tokens.
- Personal sensitive data.
- Raw payment or private account data.

Example:

```dart
class LogSanitizer {
  static Map<String, dynamic> sanitize(Map<String, dynamic> data) {
    final copy = Map<String, dynamic>.from(data);
    copy.remove('password');
    copy.remove('accessToken');
    copy.remove('refreshToken');
    copy.remove('authorization');
    return copy;
  }
}
```

Observability conventions are defined in [`observability.md`](./observability.md).

## Production Security Checklist

```txt
HTTPS enforced
No secrets in source code
No verbose API logs
No stack traces shown to users
Secure storage used for tokens
Session cleared on logout
Expired tokens handled
Dependencies reviewed
Release build tested
Web security headers configured by backend/hosting
```

## Secret Handling Rule

Frontend apps cannot safely keep private secrets.

Values embedded in Dart code, JavaScript bundles, app packages, desktop binaries, or configuration files should be treated as discoverable by users.


## Web Security Hosting Requirements

For Flutter web deployments, the hosting/backend layer should configure appropriate security headers for the product, commonly including HTTPS enforcement, HSTS, content security policy, frame protection, and secure cookie attributes where cookies are used.

Do not rely on client-side code to protect server resources.
