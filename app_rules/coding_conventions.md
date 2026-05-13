# Coding Conventions

## Owning Scope

This file defines naming, imports, file focus, code style, and linting expectations.

Architecture boundaries are defined in [`architecture.md`](./architecture.md). Project folders are defined in [`project_structure.md`](./project_structure.md).

## File Naming

Use snake case.

```txt
login_page.dart
auth_controller.dart
app_button.dart
secure_storage_service.dart
```

## Class Naming

Use PascalCase.

```dart
class LoginPage {}
class AuthController {}
class AppButton {}
```

## Variable and Method Naming

Use camelCase.

```dart
final userName = '';
void submitForm() {}
```

## Private Members

Use underscore prefix.

```dart
final String _token;
void _validateInput() {}
```

## Naming by Type

| Type | Suffix |
|---|---|
| Page or screen | `Page` |
| Reusable UI element | Descriptive name, often prefixed with `App` |
| Controller | `Controller` |
| State object | `State` |
| Service | `Service` |
| Repository contract | `Repository` |
| Repository implementation | `RepositoryImpl` |
| DTO | `Dto` |
| Use case | `UseCase` |

Example:

```txt
login_page.dart
login_form.dart
login_controller.dart
login_state.dart
sign_in_use_case.dart
auth_repository.dart
auth_repository_impl.dart
```

## Import Rules

- Prefer package imports for cross-folder imports.
- Use relative imports only inside the same small folder tree.
- Avoid circular imports.
- Avoid importing data implementation details into presentation code.
- Keep feature public exports intentional.

## Code Style Rules

- Use `const` constructors where possible.
- Avoid large widgets.
- Avoid business logic inside widgets.
- Use typed models.
- Use clear names.
- Keep files focused.
- Prefer composition over inheritance.
- Do not use raw route strings in pages; see [`navigation.md`](./navigation.md).
- Do not hard-code user-facing text; see [`localization_i18n.md`](./localization_i18n.md).
- Do not hard-code colors and repeated spacing; see [`theming.md`](./theming.md).

## Linting

Use `analysis_options.yaml`.

Minimum:

```yaml
include: package:flutter_lints/flutter.yaml
```

Recommended additions:

```yaml
analyzer:
  exclude:
    - "**/*.g.dart"
    - "**/*.freezed.dart"

linter:
  rules:
    prefer_const_constructors: true
    prefer_const_literals_to_create_immutables: true
    avoid_print: true
```

## File Focus Rule

A file should have one clear reason to change.

Examples:

- `login_page.dart` changes when login screen layout changes.
- `login_controller.dart` changes when login UI state logic changes.
- `sign_in_use_case.dart` changes when sign-in business flow changes.
- `auth_repository_impl.dart` changes when auth data coordination changes.


## Import Order

Use a consistent import order:

```txt
Dart SDK imports
Flutter/package imports
Project imports
Relative imports only when appropriate inside the same feature
```

Prefer package imports for cross-feature and core references.


## Linting Rules

- Keep `analysis_options.yaml` strict enough to catch architecture and style issues early.
- Treat analyzer warnings seriously.
- Prefer small focused exceptions over disabling rules globally.
- Run formatting and analysis before every merge.
