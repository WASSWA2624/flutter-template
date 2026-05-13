# Flutter Template

Reusable Flutter foundation for building multi-platform apps with a consistent
project structure, minimal starter UI, and backend-agnostic setup.

## Purpose

This repository is a starter template for Flutter applications that need a
professional baseline before product-specific behavior is added. It provides:

- Feature-first clean architecture with `data`, `domain`, and `presentation`
  boundaries.
- Riverpod-based state management and dependency injection.
- GoRouter routing with guard-ready route metadata.
- Centralized configuration, networking, storage, security, sync, permissions,
  localization, theming, responsive layout, and shared UI components.
- Unit, widget, and integration test scaffolding that avoids production
  services and secrets.

## Supported platforms

- Android
- iOS
- Web
- Windows desktop
- macOS desktop
- Linux desktop

iOS and macOS builds require macOS with Xcode. Linux desktop builds require a
Linux host with the Flutter desktop toolchain installed. Windows desktop builds
require a Windows host with the Visual Studio C++ desktop workload.

## Setup

Install Flutter 3.41 or newer on the stable channel, then fetch dependencies:

```sh
flutter pub get
```

Run code generation before analysis, tests, or release builds:

```sh
dart run build_runner build --delete-conflicting-outputs
```

See `docs/setup/development.md` for local prerequisite notes and
`docs/setup/environment.md` for supported public `--dart-define` values.

## Run

Run the starter app on Chrome:

```sh
flutter run -d chrome \
  --dart-define=APP_ENV=development \
  --dart-define=API_BASE_URL=http://localhost:8080
```

Useful platform run commands:

```sh
flutter run -d android
flutter run -d ios
flutter run -d windows
flutter run -d macos
flutter run -d linux
```

Run platform-specific commands only on hosts with the required SDKs installed.
Environment-specific public values are passed with `--dart-define`. See
`docs/setup/environment.md` for required keys and production constraints. See
`docs/setup/platform-behavior.md` for safe-area, keyboard, accessibility, and
platform limitation notes.

## Test

Run the local quality gate before opening a pull request:

```sh
flutter pub get
dart run build_runner build --delete-conflicting-outputs
dart format --set-exit-if-changed .
flutter analyze
flutter test
flutter test integration_test
```

Use focused test commands while developing:

```sh
flutter test test/features/home
flutter test test/shared/components
flutter test integration_test -d <deviceId>
flutter test --coverage
```

## Build

Build Web locally:

```sh
flutter build web --release \
  --dart-define=APP_ENV=production \
  --dart-define=API_BASE_URL=https://api.example.com \
  --dart-define=LOG_LEVEL=warn
```

Platform release commands for Android, iOS, Linux, and CI are documented in
`docs/release/build-ci-release.md`. Do not commit signing files, credentials,
API keys, tokens, or private certificates.

## Tooling

Run formatting and analysis separately when needed:

```sh
dart format --set-exit-if-changed .
flutter analyze
```

The analyzer uses Flutter lints plus `custom_lint` so Riverpod rules run with
the normal analysis workflow.

## Dependency stack

The starter dependency set follows `app-rules/dependencies.md`.

| Purpose | Packages |
|---|---|
| State and DI | `flutter_riverpod`, `riverpod_annotation` |
| Navigation | `go_router` |
| Networking | `dio` |
| Models and JSON | `freezed_annotation`, `json_annotation` |
| Local data | `drift`, `drift_flutter` |
| Device storage | `shared_preferences`, `flutter_secure_storage` |
| Platform services | `connectivity_plus`, `path_provider`, `url_launcher`, `app_links` |
| Localization | `flutter_localizations`, `intl` |
| Generation | `build_runner`, `riverpod_generator`, `freezed`, `json_serializable`, `drift_dev` |
| Linting and tests | `flutter_lints`, `riverpod_lint`, `custom_lint`, `flutter_test`, `integration_test`, `mocktail` |

## Project structure

```txt
docs/
  architecture/
  decisions/
  release/
  setup/
  workflows/
lib/
  main.dart
  bootstrap.dart
  app/
    app.dart
    router/
    startup/
    theme/
  core/
    config/
    errors/
    logging/
    network/
    permissions/
    responsive/
    security/
    storage/
    sync/
    utils/
  features/
    auth/
    example/
    home/
    <new_feature>/
      data/
      domain/
      presentation/
  l10n/
  shared/
    components/
    data/
    forms/
    layout/
    search/
    widgets/
test/
  app/
  core/
  features/
  l10n/
  shared/
integration_test/
tool/
android/
ios/
web/
windows/
macos/
linux/
```

- `lib/app/` contains the application shell, startup wiring, routing, and theme.
- `lib/core/` contains cross-cutting infrastructure shared by multiple
  features, including configuration, errors, logging, networking, responsive
  helpers, security, storage, sync, permissions, and utilities.
- `lib/features/` contains feature-first code grouped by data, domain, and
  presentation layers.
- `lib/shared/` contains reusable components, forms, layout primitives, and
  widgets that are not feature-owned. Shared pagination and search helpers live
  in `lib/shared/data/` and `lib/shared/search/`.
- `lib/l10n/` is reserved for localization resources and generated
  localization accessors.
- `test/` mirrors the source structure where unit and widget coverage belongs.
- `docs/workflows/` documents repeatable implementation processes for humans
  and coding agents.

## Architecture

The app uses feature-first clean architecture. Dependencies flow from
presentation into domain contracts, while data implementations satisfy those
contracts and use shared infrastructure from `core/`.

Detailed layer rules, provider placement, routing, localization, testing, code
generation, and the starter feature skeleton are documented in
`docs/architecture/app-architecture.md`.

## Feature workflow

New features must follow `docs/workflows/feature-workflow.md` and the rule
sources in `app-rules/feature_workflow.md`, `app-rules/checklists.md`, and
`app-rules/coding_conventions.md`. Start by identifying route, state, data,
validation, localization, responsive behavior, and tests. Use shared components
before adding feature-specific widgets.

## Documentation map

- `docs/README.md` indexes setup, architecture, decisions, release, and
  workflow docs.
- `docs/architecture/app-architecture.md` explains dependency direction,
  provider placement, routing, localization, testing, and code generation.
- `docs/architecture/project-structure.md` documents the canonical repository
  layout.
- `docs/decisions/0000-template.md` is the ADR template for major dependency
  and architecture decisions.
- `docs/workflows/feature-workflow.md` is the repeatable feature delivery
  workflow.

## Current scope

This setup step creates a minimal runnable app and the canonical folders from
`app-rules/project_structure.md`. It intentionally does not add product-specific
backend behavior.
