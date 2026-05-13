# Testing Strategy

## Owning Scope

This file defines test types, test structure, minimum tests per feature, responsive tests, localization tests, and test rules.

CI execution is defined in [`ci_cd_quality_gates.md`](./ci_cd_quality_gates.md).

## Test Types

| Test Type | Purpose |
|---|---|
| Unit tests | Business logic, validators, use cases |
| Widget tests | UI behavior and state rendering |
| Integration tests | Full user flows |
| Golden tests | Visual consistency |
| Responsive tests | Layout behavior across breakpoints |
| Localization tests | Locale keys and localized UI behavior |

## Test Structure

```txt
test/
  core/
    validators_test.dart
    error_mapper_test.dart

  features/
    auth/
      application/
        sign_in_use_case_test.dart
      presentation/
        login_page_test.dart
      data/
        auth_repository_impl_test.dart

  helpers/
    test_app.dart
    provider_overrides.dart

integration_test/
  app_startup_test.dart
  auth_flow_test.dart
```

## Minimum Tests Per Feature

Each feature should test:

```txt
Use cases
Repositories
Controllers
Validation
Important UI states
Navigation guards
Offline behavior when relevant
Permission behavior when relevant
```

## Responsive Testing

Test key screens at:

```txt
small mobile
large mobile
tablet
small desktop
large desktop
```

Breakpoint definitions are owned by [`responsive_adaptive_design.md`](./responsive_adaptive_design.md).

## Localization Testing

Test that:

- Required keys exist.
- Missing keys fail checks.
- Important screens render localized values.
- Dynamic values use placeholders.
- Plural messages behave correctly.

Localization rules are owned by [`localization_i18n.md`](./localization_i18n.md).

## Test Rules

- Do not depend on real APIs in unit/widget tests.
- Use provider overrides for dependencies.
- Keep tests deterministic.
- Avoid arbitrary delays.
- Prefer fake clocks when testing time.
- Test failure states, not only success states.
- Test logout/session expiry flows.
- Test offline and sync behavior for offline-capable features.


## Test Data Rules

- Keep fixtures small and explicit.
- Do not use production credentials in tests.
- Use provider overrides for repositories and services.
- Test route guards with authenticated, unauthenticated, and unauthorized states.
