# Observability Strategy

## Owning Scope

This file defines logging, crash reporting, and analytics boundaries.

Security logging rules are defined in [`security.md`](./security.md). Environment controls are defined in [`environment_configuration.md`](./environment_configuration.md).

## Logging

Logging should help developers understand app behavior without exposing private data.

Log:

- Startup events.
- Environment name.
- Non-sensitive network failure summaries.
- Sync status changes.
- Feature flag evaluation when useful.
- Important state transitions.

Do not log:

- Tokens.
- Passwords.
- Private personal data.
- Authorization headers.
- Full sensitive request/response bodies.

## Crash Reporting

Crash reporting should be product-specific and wrapped behind an app service.

```dart
abstract interface class CrashReporter {
  Future<void> recordError(Object error, StackTrace stackTrace);
  Future<void> setUserId(String? userId);
}
```

Rules:

- Enable crash reporting only where approved.
- Avoid sending sensitive values.
- Clear user identifiers on logout.
- Keep implementation replaceable.

## Analytics

Analytics should be optional and privacy-aware.

```dart
abstract interface class AnalyticsService {
  Future<void> trackEvent(String name, Map<String, Object?> properties);
}
```

Rules:

- Do not track sensitive values.
- Use stable event names.
- Keep analytics calls out of low-level widgets when possible.
- Respect user consent and product policy.
- Keep provider-specific SDKs behind an abstraction.

## Observability Rule

Observability should improve debugging and product understanding without weakening privacy or security.


## Privacy Boundary

Observability must never collect more user data than the product needs. Analytics and crash reports should avoid raw personal data, secrets, tokens, and full request payloads.
