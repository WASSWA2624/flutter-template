# Feature Development Workflow

## Owning Scope

This file defines how to add a new feature using this foundation.

Feature layer meanings are defined in [`architecture.md`](./architecture.md). Feature folder shape is defined in [`project_structure.md`](./project_structure.md).

## New Feature Steps

1. Create the feature folder.
2. Define domain entities and repository contracts.
3. Define use cases.
4. Define DTOs and mappers.
5. Define remote and local data sources.
6. Implement repository.
7. Create Riverpod providers.
8. Build presentation pages and widgets.
9. Add routes.
10. Add localization keys.
11. Add tests.
12. Update documentation if the feature adds a new convention.

## Feature Template

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

## Feature Rules

- Do not put feature-specific logic in `core`.
- Do not let pages call APIs directly.
- Do not expose DTOs as domain entities.
- Do not add route strings directly inside pages.
- Do not hard-code user-facing text.
- Add tests for meaningful logic and states.
- Keep feature exports intentional.

## Feature Acceptance Checklist

A feature is ready when:

```txt
Folder structure matches the standard
Domain model is clear
Repository contract exists
Repository implementation is tested
Controller state is tested
UI handles loading, empty, error, and success states
Localization keys are added
Routes are registered
Permissions are checked if needed
Offline behavior is defined if needed
```


## Feature README Rule

A complex feature should include a small README explaining:

- Purpose.
- Main routes.
- Offline strategy.
- Permissions.
- Main repositories and use cases.
- Known product constraints.
