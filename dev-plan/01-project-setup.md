# 01 - Project setup

## Goal

Create or normalize the Flutter project so it can become a reusable multi-platform app foundation.

This step establishes the baseline only. Do not add product-specific features, backend-specific SDKs, or domain logic here.

## Applies app rules

- [`scope.md`](../app-rules/scope.md)
- [`project_structure.md`](../app-rules/project_structure.md)
- [`dependencies.md`](../app-rules/dependencies.md)
- [`coding_conventions.md`](../app-rules/coding_conventions.md)
- [`assets_branding.md`](../app-rules/assets_branding.md)
- [`checklists.md`](../app-rules/checklists.md)
- [`validation_report.md`](../app-rules/validation_report.md)
- Source blueprint: [`flutter-app-template.md`](../flutter-app-template.md)

## Implementation steps

### 1. Confirm project state

If a Flutter project already exists, keep the existing native folders and normalize only missing structure.

If the repository contains only template documentation, create the app shell:

```bash
flutter create . --platforms=android,ios,web,linux,windows,macos
```

Required platform support for this foundation:

| Platform | Required action |
|---|---|
| Android | Keep `android/` enabled |
| iOS | Keep `ios/` enabled |
| Web | Keep `web/` enabled |
| Linux desktop | Add/keep `linux/` enabled |
| Windows desktop | Keep when present; recommended for desktop coverage |
| macOS desktop | Keep when present; recommended where host OS supports it |

Linux is required for this implementation plan because the target template must support Linux desktop. Windows and macOS remain useful desktop targets where applicable.

### 2. Normalize app identity placeholders

Use neutral starter values that can be replaced per product:

```txt
App name: Flutter App Template
Dart package name: flutter_app_template
Android applicationId: com.example.flutter_app_template
iOS bundle identifier: com.example.flutterAppTemplate
```

Do not hard-code real client names, API secrets, brand assets, or backend-specific identifiers.

### 3. Create baseline asset folders

Create:

```txt
assets/
  icons/
  images/
  illustrations/
  logos/
```

Register the root asset folders in `pubspec.yaml`:

```yaml
flutter:
  assets:
    - assets/icons/
    - assets/images/
    - assets/illustrations/
    - assets/logos/
```

Asset names must use lowercase snake case.

### 4. Add baseline project files

Create or update:

```txt
analysis_options.yaml
l10n.yaml
build.yaml
README.md
docs/
tool/scripts/
tool/checks/
test/
integration_test/
```

The detailed contents are implemented in later steps.

### 5. Run baseline health checks

```bash
flutter pub get
flutter analyze
flutter test
```

At this early stage, tests may be minimal, but the project must compile.

## Acceptance criteria

- The project opens as a valid Flutter project.
- Android, iOS, Web, and Linux are supported.
- Windows/macOS folders are kept or generated when applicable.
- Asset folders exist and are registered.
- No backend-specific SDK is added.
- No secrets are committed.
- `flutter analyze` passes or has only documented temporary TODOs for later steps.
