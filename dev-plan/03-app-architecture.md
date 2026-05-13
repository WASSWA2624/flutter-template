# 03 - App architecture

## Goal

Implement the architecture model that every future app and feature must follow.

Use feature-first clean architecture with Riverpod for state/dependency injection, GoRouter for navigation, and Material 3 for UI.

## Applies app rules

- [`architecture.md`](../app-rules/architecture.md)
- [`project_structure.md`](../app-rules/project_structure.md)
- [`state_management.md`](../app-rules/state_management.md)
- [`repository_pattern_example.md`](../app-rules/repository_pattern_example.md)
- [`scalability.md`](../app-rules/scalability.md)
- [`coding_conventions.md`](../app-rules/coding_conventions.md)
- Source blueprint: [`flutter-app-template.md`](../flutter-app-template.md)

## Architecture model

Use this dependency direction:

```txt
presentation
    ↓
application
    ↓
domain
    ↑
data
```

Layer responsibilities:

| Layer | Owns | Must not own |
|---|---|---|
| `presentation` | Pages, widgets, controllers, UI state | Raw API/database calls |
| `application` | Use cases, orchestration, services | Flutter widgets, raw API clients |
| `domain` | Entities, value objects, repository contracts, business rules | Flutter, Dio, Drift, storage |
| `data` | DTOs, mappers, data sources, repository implementations | UI widgets or navigation |
| `core` | Shared app-wide infrastructure | Feature-specific business rules |
| `app` | Bootstrap, root app, environment, global composition | Feature logic |

## Implementation steps

### 1. Add architecture documentation

Create:

```txt
docs/ARCHITECTURE.md
```

Document:

- feature-first structure
- layer boundaries
- dependency direction
- allowed imports
- example flow from page to repository
- when to add a domain/use-case layer

### 2. Add public feature boundary convention

Every feature should expose a small public barrel file:

```txt
features/auth/auth.dart
features/home/home.dart
features/settings/settings.dart
```

Allowed exports:

```dart
export 'presentation/pages/login_page.dart';
export 'domain/entities/app_user.dart';
```

Avoid exporting:

```dart
export 'data/datasources/remote/auth_remote_data_source.dart';
export 'data/repositories/auth_repository_impl.dart';
```

### 3. Define feature template

Every feature follows:

```txt
features/example/
  example.dart
  presentation/
    pages/
    widgets/
    controllers/
    state/
  application/
    use_cases/
    services/
  domain/
    entities/
    value_objects/
    repositories/
    failures/
  data/
    datasources/
      remote/
      local/
    dto/
    mappers/
    repositories/
```

For very small features, keep empty layers out until needed, but preserve the same import direction once the layer exists.

### 4. Enforce boundary rules

Coding agents must follow these rules:

- Widgets do not call APIs directly.
- Widgets do not write to databases directly.
- Repositories do not show dialogs, snackbars, or navigate.
- Domain code does not import Flutter.
- `core` does not contain one feature's business rules.
- One feature must not import another feature's private internals.

## Acceptance criteria

- `docs/ARCHITECTURE.md` exists.
- Feature-first structure is documented and applied.
- Import direction is clear.
- At least one example feature structure exists.
- The project remains small-app friendly and large-app scalable.
