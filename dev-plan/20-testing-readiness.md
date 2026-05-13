# 20 - Testing readiness

## Goal

Create a practical test structure for unit, widget, integration, golden, responsive, localization, and provider override tests.

## Applies app rules

- [`testing.md`](../app-rules/testing.md)
- [`ci_cd_quality_gates.md`](../app-rules/ci_cd_quality_gates.md)
- [`responsive_adaptive_design.md`](../app-rules/responsive_adaptive_design.md)
- [`localization_i18n.md`](../app-rules/localization_i18n.md)
- [`reusable_components.md`](../app-rules/reusable_components.md)
- [`state_management.md`](../app-rules/state_management.md)

## Test structure

Create:

```txt
test/
  core/
    validators_test.dart
    responsive/
    theme/
    widgets/
  features/
    auth/
    home/
    settings/
  helpers/
    pump_app.dart
    provider_overrides.dart
    test_data.dart
    viewport_sizes.dart
  fixtures/
  fakes/

integration_test/
  app_startup_test.dart
  navigation_test.dart
  auth_flow_test.dart
```

## Test types

| Test type | Purpose |
|---|---|
| Unit | validators, mappers, use cases, repositories, services |
| Widget | shared components and page states |
| Integration | full flows across routing/state/storage |
| Golden | visual consistency for design-system components |
| Responsive | layout behavior across breakpoints |
| Localization | locale keys and localized UI behavior |

## Minimum tests per feature

Each feature should include tests for:

- controller initial state
- success path
- failure path
- loading state
- empty state where relevant
- validation errors where relevant
- repository contract behavior
- responsive rendering for important pages

## Responsive test matrix

Create viewport constants for:

| Width | Purpose |
|---:|---|
| `320` | Extra-small mobile safety check |
| `360` | Small mobile |
| `430` | Large mobile |
| `768` | Tablet |
| `1024` | Small desktop / landscape tablet |
| `1440` | Large desktop |
| `1920` | Extra-large desktop |

Test important screens at these widths.

## Test helpers

Create `pumpApp` helper that wraps widgets with:

- `ProviderScope`
- test provider overrides
- `MaterialApp` or `MaterialApp.router`
- localization delegates
- theme
- fixed viewport helpers where needed

## Commands

```bash
flutter test
flutter test integration_test
```

For generated code before tests:

```bash
dart run build_runner build --delete-conflicting-outputs
flutter test
```

## Acceptance criteria

- Test folders and helpers exist.
- Shared components have widget tests.
- Responsive utilities have unit/widget tests.
- Theme and localization have baseline tests.
- Integration startup/navigation tests exist.
- Tests can override providers without touching production code.
