# Error Handling Strategy

## Owning Scope

This file defines the app error system, failure categories, user-facing error rules, error flow, and common UI state pattern.

Network error mapping is defined in [`network_api.md`](./network_api.md). Localization rules for error text are defined in [`localization_i18n.md`](./localization_i18n.md).

## Error System

Create a consistent error system.

```txt
core/errors/
  app_exception.dart
  app_failure.dart
  error_mapper.dart
  error_reporter.dart
```

## Failure Categories

```txt
Network failure
Authentication failure
Authorization failure
Validation failure
Database failure
Cache failure
Sync failure
Unknown failure
```

## App Result Type

Use one app-wide result type for use cases, repositories, and data operations that can fail.

```dart
sealed class AppResult<T> {
  const AppResult();

  const factory AppResult.success(T data) = AppSuccess<T>;
  const factory AppResult.failure(AppFailure failure) = AppFailureResult<T>;

  R when<R>({
    required R Function(T data) success,
    required R Function(AppFailure failure) failure,
  }) {
    return switch (this) {
      AppSuccess<T>(:final data) => success(data),
      AppFailureResult<T>(:final failure) => failure(failure),
    };
  }
}

class AppSuccess<T> extends AppResult<T> {
  const AppSuccess(this.data);
  final T data;
}

class AppFailureResult<T> extends AppResult<T> {
  const AppFailureResult(this.failure);
  final AppFailure failure;
}
```

Do not create separate public result types for network, database, and feature layers unless the app has a strong domain-specific reason. Specialized implementations should map back to `AppResult<T>` before crossing layer boundaries.

## User-Facing Errors

Do not expose technical messages to users.

Bad:

```txt
DioException [connection timeout]
```

Good:

```txt
We could not connect. Check your internet connection and try again.
```

All user-facing error messages must be localized.

## Error Flow

```txt
Low-level exception
↓
Data source catches/maps it
↓
Repository returns failure
↓
Controller updates state
↓
UI shows localized message
```

## UI State Pattern

Every major screen should handle:

```txt
initial
loading
success
empty
error
refreshing
```

Example:

```dart
sealed class ProfileUiState {
  const ProfileUiState();
}

class ProfileLoading extends ProfileUiState {
  const ProfileLoading();
}

class ProfileLoaded extends ProfileUiState {
  const ProfileLoaded(this.profile);
  final Profile profile;
}

class ProfileError extends ProfileUiState {
  const ProfileError(this.failure);
  final AppFailure failure;
}
```

## Error Rules

- Convert low-level exceptions into app-level failures.
- Do not expose stack traces to users.
- Log useful internal details safely.
- Show localized user-friendly messages.
- Keep loading, success, empty, and error states consistent.
- Provide retry actions when useful.
- Avoid swallowing errors silently.


## Failure-to-Message Rule

Failures should not contain final user-facing strings. Convert failures to localized messages close to the presentation layer so the active locale is respected.
