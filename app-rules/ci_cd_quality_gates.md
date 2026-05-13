# CI/CD and Quality Gates

## Owning Scope

This file defines required CI checks, quality gates, and release checks.

Testing conventions are defined in [`testing.md`](./testing.md). Security release rules are defined in [`security.md`](./security.md).

## Required CI Checks

CI should run:

```bash
flutter pub get
dart format --set-exit-if-changed .
flutter analyze
flutter test
dart run build_runner build --delete-conflicting-outputs
flutter test integration_test
```

Adjust commands per project and platform.

## Quality Gate Checklist

Before merging:

```txt
Formatting passes
Static analysis passes
Unit tests pass
Widget tests pass
Critical integration tests pass
No missing localization keys
No hard-coded user-facing text in new UI
No direct API calls from widgets
No secrets added to source code
No generated files out of date
```

## Release Checklist

Before release:

```txt
Production environment selected
Release build tested
Crash reporting enabled if required
Analytics enabled only if approved
Sensitive logging disabled
App version updated
Icons and splash configured
Platform signing configured
Offline flow tested if relevant
Auth expiry/logout tested
Responsive screens checked
Accessibility basics checked
```

## CI Rules

- CI should fail on formatting differences.
- CI should fail on analyzer errors.
- CI should fail when generated code is stale.
- CI should fail when required tests fail.
- CI should not use production credentials.
- CI should avoid printing secrets.

## Deployment Rule

Deployment scripts must be environment-specific and should make it obvious whether the target is development, staging, or production.


## Standard CI Commands

```bash
dart format --set-exit-if-changed .
flutter analyze
flutter test
flutter test integration_test
```

Only include integration tests in every CI run if the project has stable runners for all required platforms. Otherwise run smoke integration tests on every merge and full integration suites on release branches.
