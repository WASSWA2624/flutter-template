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
flutter run -d chrome
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
lib/
  main.dart
  bootstrap.dart
  app/
  core/
  features/
  l10n/
  shared/
docs/
  architecture/
  decisions/
  setup/
test/
integration_test/
tool/
android/
ios/
web/
windows/
macos/
linux/
```

- `app/` contains the application shell, startup wiring, routing, and theme.
- `core/` contains cross-cutting infrastructure shared by multiple features.
- `features/` contains feature-first code grouped by data, domain, and
  presentation layers.
- `shared/` contains reusable UI and layout pieces that are not feature-owned.
- `l10n/` is reserved for localization resources and generated localization
  accessors.

## Current scope

This setup step creates a minimal runnable app and the canonical folders from
`app-rules/project_structure.md`. It intentionally does not add product-specific
backend behavior.
