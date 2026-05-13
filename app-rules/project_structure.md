# Project Structure

## Scope
Defines the canonical folder structure. Every generated app must use this structure unless an app-specific rule explicitly extends it.

## Root structure
```txt
.
├── analysis_options.yaml
├── pubspec.yaml
├── README.md
├── docs/
│   ├── architecture/
│   ├── decisions/
│   └── setup/
├── lib/
│   ├── main.dart
│   ├── bootstrap.dart
│   ├── app/
│   ├── core/
│   ├── features/
│   ├── l10n/
│   └── shared/
├── test/
├── integration_test/
└── tool/
```

## `lib` structure
```txt
lib/
├── app/
│   ├── app.dart
│   ├── router/
│   ├── startup/
│   └── theme/
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
└── shared/
    ├── components/
    ├── forms/
    ├── layout/
    └── widgets/
```

## Mandatory rules
- Use `features/<feature_name>` for product behavior and screens.
- Use `core` only for cross-cutting infrastructure used by multiple features.
- Use `shared` only for reusable UI and layout pieces that are not tied to one feature.
- Do not place feature-specific business logic in `core` or `shared`.
- Do not create a second folder for the same responsibility.
- Keep generated files beside their source files when Dart tooling expects it.
- Keep tests in folders that mirror the source structure.

## Acceptance checklist
- A new developer can locate routes, theme, localization, networking, storage, and each feature quickly.
- No feature imports implementation details from another feature.
- No widget calls an API client, database, secure storage, or sync service directly.
- `README.md` explains the structure at a high level.

## Related rules
- [`architecture.md`](./architecture.md)
- [`coding_conventions.md`](./coding_conventions.md)
- [`feature_workflow.md`](./feature_workflow.md)
- [`testing.md`](./testing.md)
