# Flutter Template

Reusable Flutter foundation for building multi-platform apps with a consistent
project structure, minimal starter UI, and backend-agnostic setup.

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

```sh
flutter pub get
dart run build_runner build --delete-conflicting-outputs
dart format --set-exit-if-changed .
flutter analyze
flutter test
flutter run -d chrome \
  --dart-define=APP_ENV=development \
  --dart-define=API_BASE_URL=http://localhost:8080
```

Useful platform commands:

```sh
flutter run -d android
flutter run -d ios
flutter run -d windows
flutter run -d macos
flutter run -d linux
flutter build web
```

Run platform-specific commands only on hosts with the required SDKs installed.
Environment-specific public values are passed with `--dart-define`. See
`docs/setup/environment.md` for required keys and production constraints. See
`docs/setup/platform-behavior.md` for safe-area, keyboard, accessibility, and
platform limitation notes.

## Tooling

Run code generation before analysis, tests, and release builds:

```sh
dart run build_runner build --delete-conflicting-outputs
```

Run the local quality gate before opening a pull request:

```sh
flutter pub get
dart run build_runner build --delete-conflicting-outputs
dart format --set-exit-if-changed .
flutter analyze
flutter test
```

The analyzer uses Flutter lints plus `custom_lint` so Riverpod rules run with
the normal analysis workflow.

CI, platform release commands, versioning rules, and the release checklist are
documented in `docs/release/build-ci-release.md`.

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
  setup/
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
    <feature_name>/
      data/
      domain/
      presentation/
  l10n/
  shared/
    components/
    forms/
    layout/
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
  widgets that are not feature-owned.
- `lib/l10n/` is reserved for localization resources and generated
  localization accessors.
- `test/` mirrors the source structure where unit and widget coverage belongs.

## Architecture

The app uses feature-first clean architecture. Dependencies flow from
presentation into domain contracts, while data implementations satisfy those
contracts and use shared infrastructure from `core/`.

Detailed layer rules, provider placement, and the starter feature skeleton are
documented in `docs/architecture/app-architecture.md`.

## Current scope

This setup step creates a minimal runnable app and the canonical folders from
`app-rules/project_structure.md`. It intentionally does not add product-specific
backend behavior.
