# 02 - Dependencies and tooling

## Goal

Install only the dependencies needed for a general reusable Flutter foundation and configure code generation, linting, and quality tooling.

## Applies app rules

- [`dependencies.md`](../app-rules/dependencies.md)
- [`code_generation.md`](../app-rules/code_generation.md)
- [`coding_conventions.md`](../app-rules/coding_conventions.md)
- [`ci_cd_quality_gates.md`](../app-rules/ci_cd_quality_gates.md)
- [`testing.md`](../app-rules/testing.md)

## Runtime dependencies

Add the core packages with commands rather than manually pinning versions:

```bash
flutter pub add flutter_riverpod riverpod_annotation go_router dio intl flutter_secure_storage drift drift_flutter sqlite3_flutter_libs shared_preferences connectivity_plus path_provider path freezed_annotation json_annotation package_info_plus url_launcher logging collection
```

Add SDK localization support in `pubspec.yaml`:

```yaml
dependencies:
  flutter:
    sdk: flutter
  flutter_localizations:
    sdk: flutter
```

## Development dependencies

```bash
flutter pub add --dev build_runner freezed json_serializable riverpod_generator riverpod_lint flutter_lints custom_lint mocktail golden_toolkit
```

Add SDK test packages in `pubspec.yaml`:

```yaml
dev_dependencies:
  flutter_test:
    sdk: flutter
  integration_test:
    sdk: flutter
```

Optional packages such as `permission_handler`, `flutter_svg`, `cached_network_image`, `window_manager`, `patrol`, `melos`, `flutter_launcher_icons`, and `flutter_native_splash` must only be added when the real product needs them.

## Tooling files

### `analysis_options.yaml`

Configure Flutter and Riverpod linting:

```yaml
include: package:flutter_lints/flutter.yaml

analyzer:
  plugins:
    - custom_lint
  exclude:
    - "**/*.g.dart"
    - "**/*.freezed.dart"

linter:
  rules:
    prefer_const_constructors: true
    prefer_const_literals_to_create_immutables: true
    avoid_print: true
    unnecessary_lambdas: true
```

### `build.yaml`

Add only if generator configuration is needed. Do not add complex generator config before there is a real need.

### Generated files

Generated files must never be edited manually:

```txt
*.g.dart
*.freezed.dart
*.mocks.dart
```

Use:

```bash
dart run build_runner build --delete-conflicting-outputs
```

During active development:

```bash
dart run build_runner watch --delete-conflicting-outputs
```

## Dependency governance

Before adding any dependency, answer:

| Question | Required answer |
|---|---|
| Does Flutter already provide this? | No, or package adds real value |
| Does it support Android, iOS, Web, and Linux/desktop? | Yes, unless intentionally platform-specific |
| Does it affect architecture? | If yes, wrap behind an interface |
| Does it access sensitive data? | Security-reviewed |
| Is it easy to replace? | Preferably yes |

## Acceptance criteria

- `pubspec.yaml` contains only foundation-level dependencies.
- Generated-code packages are present.
- Linting runs with Flutter and Riverpod rules.
- No product-specific SDK is installed.
- `flutter pub outdated` can be used for maintenance.
- `dart run build_runner build --delete-conflicting-outputs` completes successfully once generated-code files exist.
