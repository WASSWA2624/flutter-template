# 04 - Folder structure

## Goal

Create the final root and `lib/` folder structure that supports shared infrastructure, reusable UI, features, tests, documentation, and tooling.

## Applies app rules

- [`project_structure.md`](../app-rules/project_structure.md)
- [`architecture.md`](../app-rules/architecture.md)
- [`coding_conventions.md`](../app-rules/coding_conventions.md)
- [`assets_branding.md`](../app-rules/assets_branding.md)
- [`documentation_standards.md`](../app-rules/documentation_standards.md)

## Root structure

Create or normalize:

```txt
project_root/
  android/
  ios/
  web/
  linux/
  windows/
  macos/

  assets/
    icons/
    images/
    illustrations/
    logos/

  docs/
    ARCHITECTURE.md
    AUTHENTICATION.md
    COMPONENTS.md
    LOCALIZATION.md
    OFFLINE_SYNC.md
    ROUTING.md
    SECURITY.md
    TESTING.md
    THEMING.md
    adr/

  integration_test/
  lib/
  test/
    core/
    features/
    helpers/
  tool/
    checks/
    scripts/

  analysis_options.yaml
  build.yaml
  l10n.yaml
  pubspec.yaml
  README.md
```

Keep platform folders only if Flutter generated them or the platform is supported by the development environment. Linux must be present for this template.

## `lib/` structure

Create:

```txt
lib/
  main.dart

  app/
    app.dart
    app_bootstrap.dart
    app_config.dart
    app_environment.dart
    app_providers.dart
    app_startup.dart

  core/
    accessibility/
    constants/
      app_constants.dart
      asset_paths.dart
      storage_keys.dart
    errors/
    extensions/
    localization/
    logging/
    network/
    platform/
    responsive/
    routing/
    security/
    storage/
      database/
      cache/
      preferences/
    sync/
    theme/
    utils/
    widgets/
      buttons/
      data_display/
      feedback/
      forms/
      layout/
      navigation/
      overlays/

  features/
    auth/
    home/
    settings/

  l10n/
    app_en.arb

  shared/
    models/
    mixins/
    types/
```

## Starter features

Create minimal starter features:

| Feature | Purpose |
|---|---|
| `home` | Default protected or public landing page placeholder |
| `settings` | Theme and locale settings placeholder |
| `auth` | Backend-agnostic auth contracts and session state only |

Do not implement real backend login in the starter.

## Barrel files

Use barrel files carefully:

```txt
core/widgets/widgets.dart
features/home/home.dart
features/settings/settings.dart
features/auth/auth.dart
```

Do not expose data-source implementations through feature barrel files.

## Naming rules

- Files use `lower_snake_case.dart`.
- Classes use `PascalCase`.
- Private members start with `_`.
- Use role suffixes: `Page`, `Controller`, `Repository`, `Service`, `State`, `Dto`, `Mapper`.
- Keep one main public type per file.

## Acceptance criteria

- The folder tree matches the foundation rules.
- Shared infrastructure is in `core/`.
- Bootstrap/root composition is in `app/`.
- Feature code is in `features/`.
- No feature-specific logic is placed in `core/`.
- Empty folders may use `.gitkeep` if required by version control.
