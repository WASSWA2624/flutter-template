# Feature Flag Strategy

## Owning Scope

This file defines feature flag naming, ownership, evaluation, and safety rules.

Permissions are defined in [`permissions.md`](./permissions.md). Environment configuration is defined in [`environment_configuration.md`](./environment_configuration.md).

## Feature Flag Purpose

Feature flags allow teams to control features without changing core architecture.

Use feature flags for:

- Gradual rollout.
- Environment-specific behavior.
- Beta features.
- Temporary experiments.
- Disabling risky features quickly.

## Feature Flag Model

```dart
class FeatureFlags {
  const FeatureFlags({
    required this.enableNewDashboard,
    required this.enableOfflineSync,
  });

  final bool enableNewDashboard;
  final bool enableOfflineSync;
}
```

## Naming Rules

Good:

```txt
enableOfflineSync
enableNewDashboard
enableBetaReports
```

Bad:

```txt
flag1
testMode
newThing
```

## Feature Flag Rules

- Keep flags typed.
- Keep defaults safe.
- Do not use flags as permission checks.
- Remove temporary flags after rollout.
- Document flags that affect major behavior.
- Do not scatter raw flag names across the app.
- Use environment config or a feature flag service as the source.

## Feature Flag Evaluation

Feature flags should be evaluated in controllers, route guards, or service layers depending on use case.

Avoid hiding major business rules only in UI widgets.


## Flag Lifecycle Rules

- Every feature flag should have an owner.
- Temporary rollout flags should have a removal plan.
- Do not use feature flags as a replacement for permission checks.
- Avoid deeply nested flag conditions in UI code.
