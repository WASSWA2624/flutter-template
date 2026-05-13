# State Management Strategy

## Owning Scope

This file defines Riverpod usage, provider types, state rules, controller conventions, and dependency injection style.

Dependencies are listed in [`dependencies.md`](./dependencies.md). Feature architecture is defined in [`architecture.md`](./architecture.md).

## Recommended Tool

Use Riverpod for:

- State management.
- Dependency injection.
- Async state.
- Repository providers.
- Service providers.
- Test overrides.

## Provider Types

| Use Case | Recommended Provider |
|---|---|
| Stateless dependency | `Provider` |
| Async fetch | `FutureProvider` |
| Stream data | `StreamProvider` |
| Screen controller | `Notifier` |
| Async screen controller | `AsyncNotifier` |
| Code-generated provider | `@riverpod` |

## State Rules

- Keep providers small.
- Keep UI state close to the feature.
- Do not create one global app state object.
- Keep business logic out of widgets.
- Use immutable state models.
- Use `AsyncValue` for loading/error/data states.
- Use provider overrides in tests.
- Avoid reading providers from services unless intentionally designed.

## Controller Example

```dart
@riverpod
class LoginController extends _$LoginController {
  @override
  LoginState build() {
    return const LoginState();
  }

  Future<void> submit() async {
    if (!state.canSubmit) return;

    state = state.copyWith(isSubmitting: true, error: null);

    final signIn = ref.read(signInUseCaseProvider);
    final result = await signIn(
      email: state.email,
      password: state.password,
    );

    state = result.when(
      success: (_) => state.copyWith(isSubmitting: false),
      failure: (failure) => state.copyWith(
        isSubmitting: false,
        error: failure,
      ),
    );
  }
}
```

## State Model Example

```dart
@freezed
class LoginState with _$LoginState {
  const factory LoginState({
    @Default('') String email,
    @Default('') String password,
    @Default(false) bool isSubmitting,
    AppFailure? error,
  }) = _LoginState;

  const LoginState._();

  bool get canSubmit => email.isNotEmpty && password.isNotEmpty && !isSubmitting;
}
```

## Dependency Injection Example

```dart
@riverpod
Dio dio(DioRef ref) {
  return ApiClientFactory.create(ref.read(appConfigProvider));
}

@riverpod
AuthRepository authRepository(AuthRepositoryRef ref) {
  return AuthRepositoryImpl(
    remoteDataSource: ref.read(authRemoteDataSourceProvider),
    localDataSource: ref.read(authLocalDataSourceProvider),
  );
}
```

## Rebuild Control

- Watch only the state a widget needs.
- Use `select` for small state slices.
- Split large widgets into smaller widgets.
- Keep global providers focused on shared app state only.
- Avoid refreshing expensive providers unnecessarily.

Performance rules are expanded in [`performance.md`](./performance.md).


## Provider Lifecycle Rules

- Use `autoDispose` for short-lived screen state when state should reset after leaving the screen.
- Keep long-lived app state explicit, such as auth session, theme mode, and locale.
- Cancel timers, subscriptions, and in-flight operations through provider lifecycle hooks.
- Avoid provider families with unbounded keys unless their cache behavior is controlled.
