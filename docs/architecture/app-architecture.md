# App Architecture

This template follows feature-first clean architecture.

Rule sources:

- `app-rules/architecture.md`
- `app-rules/project_structure.md`
- `app-rules/state_management.md`
- `app-rules/data_modeling.md`

## Dependency Direction

Dependencies flow inward through feature layers:

```txt
presentation -> domain <- data
data -> core infrastructure
app -> features and shared UI
```

The presentation layer owns pages, widgets, controllers, and UI state. It may
depend on domain contracts and entities, but it must not call APIs, databases,
secure storage, or platform services directly.

The domain layer owns entities, value objects, repository contracts, services,
and use cases. Domain code must stay independent of Flutter widgets, generated
database tables, API DTOs, and platform clients.

The data layer owns repository implementations, DTOs, mappers, and data sources.
It may depend on domain contracts and `core` infrastructure, but it must not
show UI, navigate, or expose raw external models to widgets.

The `core` folder owns cross-cutting infrastructure used by multiple features.
It must not contain feature-specific business rules.

The `shared` folder owns reusable, feature-neutral UI components and layouts. It
must not contain domain decisions.

## Canonical Library Structure

```txt
lib/
|-- main.dart
|-- bootstrap.dart
|-- app/
|   |-- app.dart
|   |-- router/
|   |-- startup/
|   `-- theme/
|-- core/
|   |-- config/
|   |-- errors/
|   |-- logging/
|   |-- network/
|   |-- permissions/
|   |-- responsive/
|   |-- security/
|   |-- storage/
|   |-- sync/
|   `-- utils/
|-- features/
|   `-- home/
|       |-- data/
|       |   |-- datasources/
|       |   |-- dtos/
|       |   |-- mappers/
|       |   `-- repositories/
|       |-- domain/
|       |   |-- entities/
|       |   |-- repositories/
|       |   |-- services/
|       |   `-- usecases/
|       `-- presentation/
|           |-- controllers/
|           |-- pages/
|           |-- state/
|           `-- widgets/
|-- l10n/
`-- shared/
    |-- components/
    |-- forms/
    |-- layout/
    `-- widgets/
```

The `home` feature is the starter example feature. Its folders are intentionally
minimal and demonstrate where production code belongs when the feature grows.

## Provider Placement

Riverpod is the template's state management and dependency injection boundary.
Providers should live close to the layer they create:

| Provider type | Location |
|---|---|
| App configuration, startup, routing, theme | `lib/app/` or `lib/core/config/` |
| Shared infrastructure clients | `lib/core/network`, `lib/core/storage`, `lib/core/sync` |
| Feature repository implementations | `features/<feature>/data/repositories` |
| Feature controllers and UI state | `features/<feature>/presentation/controllers` and `presentation/state` |

Widgets should read controllers or UI state from providers. They should not
instantiate repositories, clients, databases, or storage services.

## Boundary Checklist

- Widgets do not call APIs, databases, secure storage, or platform services.
- Domain entities and use cases do not import Flutter UI packages.
- DTOs and database models are mapped before reaching domain or presentation.
- Repository implementations coordinate data sources and return domain models.
- `core` contains reusable infrastructure only.
- `shared` contains reusable UI only.
- Features expose intentional entry points and do not import implementation
  details from other features.
