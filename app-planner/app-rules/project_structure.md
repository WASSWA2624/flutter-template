# Project Structure

## Scope
Defines the canonical Flutter project structure. Every generated app must use this structure unless an app-specific rule intentionally extends it.

## Root structure
```txt
.
├── app-planner/
│   ├── app-rules/
│   └── dev-plan/
├── analysis_options.yaml
├── l10n.yaml
├── pubspec.yaml
├── README.md
├── assets/
│   ├── icons/
│   ├── images/
│   ├── illustrations/
│   └── logos/
├── docs/
│   ├── architecture/
│   ├── decisions/
│   └── setup/
├── env/
│   ├── development.json.example
│   ├── staging.json.example
│   └── production.json.example
├── lib/
├── test/
├── integration_test/
└── tool/
```

`app-planner/` is documentation and must not be imported by application source code.

## `lib` structure
```txt
lib/
├── main.dart
├── bootstrap.dart
├── app/
│   ├── app.dart
│   ├── router/
│   │   ├── app_router.dart
│   │   ├── app_routes.dart
│   │   ├── route_guards.dart
│   │   └── route_refresh_listenable.dart
│   ├── startup/
│   │   └── startup_controller.dart
│   └── theme/
│       ├── app_theme.dart
│       ├── app_theme_tokens.dart
│       └── theme_mode_controller.dart
├── core/
│   ├── config/
│   ├── errors/
│   ├── logging/
│   ├── network/
│   ├── permissions/
│   ├── responsive/
│   ├── security/
│   ├── storage/
│   ├── sync/
│   └── utils/
├── features/
│   └── <feature_name>/
│       ├── data/
│       │   ├── datasources/
│       │   ├── dtos/
│       │   ├── mappers/
│       │   └── repositories/
│       ├── domain/
│       │   ├── entities/
│       │   ├── repositories/
│       │   ├── services/
│       │   └── usecases/
│       └── presentation/
│           ├── controllers/
│           ├── pages/
│           ├── state/
│           └── widgets/
├── l10n/
│   └── app_en.arb
└── shared/
    ├── components/
    ├── forms/
    ├── layout/
    │   ├── app_menu_bar.dart
    │   ├── responsive_app_shell.dart
    │   ├── responsive_page.dart
    │   └── side_navigation.dart
    ├── state/
    └── widgets/
```

## Required starter files
| File | Responsibility |
|---|---|
| `lib/main.dart` | Small entry point only. |
| `lib/bootstrap.dart` | Flutter binding initialization and root app launch. |
| `lib/app/app.dart` | `MaterialApp.router`, theme, localization, and app-level providers. |
| `lib/app/router/app_router.dart` | Central `go_router` configuration. |
| `lib/app/router/app_routes.dart` | Route names and paths. |
| `lib/app/theme/app_theme.dart` | Light and dark Material themes. |
| `lib/app/theme/app_theme_tokens.dart` | Shared spacing, radius, sizing, and status tokens. |
| `lib/core/responsive/app_breakpoints.dart` | Canonical breakpoints and layout helpers. |
| `lib/shared/layout/responsive_app_shell.dart` | Mobile/tablet/desktop shell composition. |
| `lib/shared/layout/app_menu_bar.dart` | Desktop/web menu bar. |
| `lib/shared/layout/side_navigation.dart` | Collapsible desktop side navigation. |
| `lib/shared/layout/responsive_page.dart` | Page padding and max-width constraints. |

## Mandatory rules
- Use `features/<feature_name>` for product behavior and screens.
- Use `core` only for cross-cutting infrastructure used by multiple features.
- Use `shared` only for reusable UI, state views, layout pieces, and form patterns that are not tied to one feature.
- Do not place feature-specific business logic in `core` or `shared`.
- Do not create a second folder for the same responsibility.
- Keep generated files beside their source files when Dart tooling expects it.
- Keep tests in folders that mirror the source structure.
- Keep root configuration files at the root: `pubspec.yaml`, `analysis_options.yaml`, and `l10n.yaml`.

## Acceptance checklist
- A new developer can locate startup, routes, theme, localization, responsive layout, networking, storage, and features quickly.
- No feature imports implementation details from another feature.
- No widget calls an API client, database, secure storage, or sync service directly.
- `README.md` explains the structure at a high level.

## Related rules
- [`architecture.md`](./architecture.md)
- [`coding_conventions.md`](./coding_conventions.md)
- [`feature_workflow.md`](./feature_workflow.md)
- [`testing.md`](./testing.md)
