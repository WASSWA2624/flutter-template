# Flutter Template

Reusable Flutter foundation for building multi-platform apps with a consistent
project structure, minimal starter UI, and backend-agnostic setup.

## Supported platforms

- Android
- iOS
- Web
- Linux desktop

iOS builds require macOS with Xcode. Linux desktop builds require a Linux host
with the Flutter desktop toolchain installed.

## Setup

```sh
flutter pub get
flutter test
flutter run -d chrome
```

Useful platform commands:

```sh
flutter run -d android
flutter run -d ios
flutter run -d linux
flutter build web
```

Run platform-specific commands only on hosts with the required SDKs installed.

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
