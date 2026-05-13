# 12 - State management and dependency injection

## Goal

Use Riverpod for state management, dependency injection, async state, service providers, repository providers, and test overrides.

## Applies app rules

- [`state_management.md`](../app-rules/state_management.md)
- [`dependencies.md`](../app-rules/dependencies.md)
- [`architecture.md`](../app-rules/architecture.md)
- [`performance.md`](../app-rules/performance.md)
- [`testing.md`](../app-rules/testing.md)
- [`code_generation.md`](../app-rules/code_generation.md)

## Provider strategy

| Use case | Provider type |
|---|---|
| Stateless dependency | `Provider` |
| Async fetch | `FutureProvider` |
| Stream data | `StreamProvider` |
| Screen controller | `Notifier` |
| Async screen controller | `AsyncNotifier` |
| Generated provider | `@riverpod` |

## Files to create

```txt
lib/app/app_providers.dart
lib/core/network/network_providers.dart
lib/core/storage/storage_providers.dart
lib/core/theme/theme_providers.dart
lib/core/localization/locale_provider.dart
lib/features/*/presentation/controllers/
lib/features/*/presentation/state/
```

## Global app providers

Keep global app state limited to truly global concerns:

- app config
- logger
- router
- theme mode
- locale
- auth/session state
- preferences service
- secure storage service
- API client factory
- database connection

Do not create one huge global app state object.

## Feature controller pattern

Use immutable state models and small controllers:

```dart
@riverpod
class LoginController extends _$LoginController {
  @override
  LoginState build() => const LoginState();

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

## State rules

- Keep providers small.
- Keep UI state close to the feature.
- Use immutable state objects.
- Use `AsyncValue` for loading/error/data states where appropriate.
- Use provider overrides in tests.
- Avoid reading providers from services unless intentionally designed.
- Use `autoDispose` for short-lived screen state.
- Keep long-lived state explicit.

## Rebuild control

- Watch only the state a widget needs.
- Use `select` for small state slices.
- Split large widgets into smaller widgets.
- Avoid refreshing expensive providers unnecessarily.
- Cancel timers, streams, and in-flight requests through provider lifecycle hooks.

## Acceptance criteria

- Riverpod is used for DI and state.
- Global providers are focused and limited.
- Feature controllers own screen actions and UI state.
- Widgets stay mostly declarative.
- Providers are easy to override in tests.
- Code generation runs without conflicts.
