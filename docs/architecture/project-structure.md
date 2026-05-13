# Project Structure

The template follows `app-rules/project_structure.md`.

```txt
.
|-- analysis_options.yaml
|-- pubspec.yaml
|-- README.md
|-- docs/
|   |-- architecture/
|   |-- decisions/
|   `-- setup/
|-- lib/
|   |-- main.dart
|   |-- bootstrap.dart
|   |-- app/
|   |-- core/
|   |-- features/
|   |-- l10n/
|   `-- shared/
|-- test/
|-- integration_test/
`-- tool/
```

Feature code is organized under `lib/features/<feature_name>/data`, `domain`,
and `presentation`. Cross-cutting infrastructure belongs in `lib/core`.
Reusable, feature-neutral UI belongs in `lib/shared`.
