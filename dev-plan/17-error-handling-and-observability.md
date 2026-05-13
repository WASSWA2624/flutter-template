# 17 - Error handling and observability

## Goal

Create a safe, consistent error system and observability layer for logs, crash reporting, analytics abstraction, and user-facing failure messages.

## Applies app rules

- [`error_handling.md`](../app-rules/error_handling.md)
- [`observability.md`](../app-rules/observability.md)
- [`network_api.md`](../app-rules/network_api.md)
- [`security.md`](../app-rules/security.md)
- [`localization_i18n.md`](../app-rules/localization_i18n.md)
- [`startup_flow.md`](../app-rules/startup_flow.md)

## Files to create

```txt
lib/core/errors/app_exception.dart
lib/core/errors/app_failure.dart
lib/core/errors/app_result.dart
lib/core/errors/error_mapper.dart
lib/core/errors/error_reporter.dart
lib/core/logging/app_logger.dart
lib/core/logging/log_level.dart
lib/core/logging/log_sanitizer.dart
lib/core/observability/analytics_service.dart
lib/core/observability/crash_reporter.dart
```

## Failure categories

Define app-level failure categories:

```txt
network
timeout
unauthorized
forbidden
notFound
validation
conflict
storage
sync
unknown
```

Each failure should contain enough information for developers and safe information for users.

## Error flow

```txt
API/storage throws exception
↓
Data source catches low-level exception when appropriate
↓
Repository maps exception to AppFailure
↓
Controller stores failure in state
↓
UI renders localized safe message
↓
ErrorReporter logs sanitized technical details
```

## User-facing messages

Rules:

- Never show stack traces to users.
- Never show raw tokens, passwords, personal data, or private server details.
- Use localized message keys.
- Use generic fallback messages for unknown failures.
- Keep technical details in sanitized logs only.

## Logger

Create a logger wrapper:

```dart
abstract interface class AppLogger {
  void info(String message, [Map<String, Object?> context]);
  void warning(String message, [Map<String, Object?> context]);
  void error(String message, Object error, StackTrace stackTrace, [Map<String, Object?> context]);
}
```

Add a sanitizer that removes:

- tokens
- passwords
- authorization headers
- cookies
- private user fields
- raw request/response bodies unless explicitly safe

## Crash reporting and analytics

Create abstractions only:

```dart
abstract interface class CrashReporter {
  Future<void> recordError(Object error, StackTrace stackTrace, {bool fatal = false});
}

abstract interface class AnalyticsService {
  Future<void> trackEvent(String name, Map<String, Object?> parameters);
}
```

Do not add a concrete vendor in the reusable foundation. Product apps may implement these adapters later.

## Acceptance criteria

- App failures and result types exist.
- Network/storage errors map to safe failures.
- User-facing errors are localized.
- Logs are sanitized.
- Crash/analytics interfaces exist without vendor lock-in.
- Startup and runtime errors are captured consistently.
