# Architecture Conventions

## Owning Scope

This file defines the architecture model, layer responsibilities, and dependency direction rules.

Project folders are defined in [`project_structure.md`](./project_structure.md). State management is defined in [`state_management.md`](./state_management.md).

## Recommended Architecture

Use a feature-first clean architecture.

```txt
Feature-first architecture
+
Clean architecture
+
Riverpod providers
+
GoRouter navigation
+
Material 3 design system
```

This structure works for small apps and large apps because every feature owns its own UI, state, business rules, and data access.

## Why Feature-First

A large application should not be organized as unrelated global folders such as:

```txt
pages/
controllers/
repositories/
models/
widgets/
```

That structure scatters one feature across the app.

Preferred shape:

```txt
features/
  auth/
    presentation/
    application/
    domain/
    data/

  profile/
    presentation/
    application/
    domain/
    data/
```

Feature-first organization makes it easier to add, remove, test, and reuse features.

## Architecture Layers

| Layer | Main Responsibility | Can Depend On | Must Not Depend On |
|---|---|---|---|
| `presentation` | Pages, widgets, form UI, UI state | `application`, `domain`, `core` | Remote APIs, database code directly |
| `application` | Use cases, controllers, state orchestration | `domain`, `core` | Flutter widgets, raw API clients |
| `domain` | Entities, value objects, repository contracts, business rules | Pure Dart only | Flutter, Dio, database, local storage |
| `data` | Repository implementations, DTOs, API and database access | `domain`, `core/network`, `core/storage` | UI widgets |
| `core` | App-wide utilities, theme, routing, localization, storage, security | Shared low-level dependencies | Feature-specific business logic |

## Dependency Direction

Dependencies should point inward.

```txt
presentation
    ↓
application
    ↓
domain
    ↑
data
```

The `domain` layer should be the most stable layer.

The UI can change. The API can change. The database can change. The domain model should remain stable.

## Feature Layer Template

```txt
features/example/
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

## Layer Placement Rules

| Need | Where It Belongs |
|---|---|
| Display a screen | `presentation/pages` |
| Reusable UI inside one feature | `presentation/widgets` |
| Reusable UI across many features | `core/widgets` |
| Screen state and actions | `presentation/controllers` |
| Business action | `application/use_cases` |
| Business object | `domain/entities` |
| Business validation value | `domain/value_objects` |
| API response model | `data/dto` |
| DTO/entity conversion | `data/mappers` |
| HTTP call | `data/datasources/remote` |
| Local database call | `data/datasources/local` |
| Abstract data contract | `domain/repositories` |
| Repository implementation | `data/repositories` |

## Boundary Rules

- Widgets must not call APIs directly.
- Widgets must not write to the database directly.
- Repositories must not show dialogs, snackbars, or navigation.
- Data sources must not contain UI state.
- The domain layer must not import Flutter.
- `core` must not contain business rules for one specific feature.
- Feature modules should expose only their public entry points.

## Practical Example

When the user submits a login form:

```txt
LoginPage
↓
LoginController
↓
SignInUseCase
↓
AuthRepository
↓
AuthRemoteDataSource + AuthLocalDataSource
```

The page displays the result. The controller orchestrates state. The use case represents the business action. The repository decides how data is accessed. The data sources perform actual API/storage work.
