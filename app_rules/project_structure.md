# Project Structure Conventions

## Owning Scope

This file defines the folder and file organization for the starter project.

Architecture meaning is defined in [`architecture.md`](./architecture.md). Naming conventions are defined in [`coding_conventions.md`](./coding_conventions.md).

## Root Structure

```txt
project_root/
  android/
  ios/
  web/
  windows/

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

  integration_test/
    app_startup_test.dart
    auth_flow_test.dart

  lib/
    main.dart
    app/
    core/
    features/
    l10n/
    shared/

  test/
    core/
    features/
    helpers/

  tool/
    checks/
    scripts/

  analysis_options.yaml
  l10n.yaml
  pubspec.yaml
  README.md
```

## Recommended `lib/` Structure

```txt
lib/
  main.dart

  app/
    app.dart
    app_bootstrap.dart
    app_environment.dart
    app_config.dart
    app_providers.dart
    app_startup.dart

  core/
    accessibility/
      accessibility_utils.dart

    constants/
      app_constants.dart
      asset_paths.dart
      storage_keys.dart

    errors/
      app_exception.dart
      app_failure.dart
      app_result.dart
      error_mapper.dart
      error_reporter.dart

    extensions/
      context_extensions.dart
      date_time_extensions.dart
      string_extensions.dart

    localization/
      l10n_extensions.dart
      locale_controller.dart
      locale_provider.dart

    logging/
      app_logger.dart
      log_level.dart
      log_sanitizer.dart

    network/
      api_client.dart
      api_interceptors.dart
      api_headers.dart
      api_error_mapper.dart
      network_info.dart
      pagination.dart

    platform/
      app_platform.dart
      platform_info.dart
      platform_service.dart

    responsive/
      app_breakpoints.dart
      app_screen_size.dart
      adaptive_layout_policy.dart
      responsive_utils.dart

    routing/
      app_router.dart
      route_paths.dart
      route_names.dart
      route_guards.dart
      route_error_page.dart
      route_transitions.dart

    security/
      secure_storage_service.dart
      token_manager.dart
      session_manager.dart
      permission_service.dart
      input_sanitizer.dart

    storage/
      database/
        app_database.dart
        database_connection.dart
        database_migrations.dart
        tables/
      cache/
        cache_policy.dart
        cache_service.dart
        cache_entry.dart
      preferences/
        preferences_service.dart

    sync/
      sync_queue.dart
      sync_task.dart
      sync_status.dart
      sync_service.dart
      conflict_strategy.dart

    theme/
      app_theme.dart
      app_theme_controller.dart
      app_theme_mode.dart
      app_color_schemes.dart
      app_spacing.dart
      app_radius.dart
      app_typography.dart
      app_shadows.dart
      app_component_sizes.dart
      app_theme_extensions.dart

    utils/
      date_formatter.dart
      debounce.dart
      input_formatters.dart
      validators.dart

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
      auth.dart
      presentation/
      application/
      domain/
      data/

    home/
      home.dart
      presentation/
      application/
      domain/
      data/

  l10n/
    app_en.arb

  shared/
    models/
    mixins/
    types/
```

Breakpoints and layout classification live in `core/responsive/` and are defined by [`responsive_adaptive_design.md`](./responsive_adaptive_design.md). Theme tokens stay in `core/theme/`.

## Example Feature Structure

```txt
features/auth/
  auth.dart

  presentation/
    pages/
      login_page.dart
      register_page.dart
      forgot_password_page.dart
    widgets/
      login_form.dart
      password_field.dart
      auth_page_shell.dart
    controllers/
      login_controller.dart
      register_controller.dart
      auth_session_controller.dart
    state/
      login_state.dart
      register_state.dart

  application/
    use_cases/
      sign_in_use_case.dart
      sign_out_use_case.dart
      refresh_session_use_case.dart
      restore_session_use_case.dart
    services/
      auth_policy_service.dart

  domain/
    entities/
      app_user.dart
      auth_session.dart
    value_objects/
      email_address.dart
      password.dart
    repositories/
      auth_repository.dart
    failures/
      auth_failure.dart

  data/
    datasources/
      remote/
        auth_remote_data_source.dart
      local/
        auth_local_data_source.dart
    dto/
      login_request_dto.dart
      auth_response_dto.dart
      user_dto.dart
    mappers/
      auth_mapper.dart
      user_mapper.dart
    repositories/
      auth_repository_impl.dart
```

## Barrel Files

Use barrel files carefully.

Allowed:

```txt
features/auth/auth.dart
core/widgets/widgets.dart
```

Avoid exporting implementation details.

Good:

```dart
export 'presentation/pages/login_page.dart';
export 'domain/entities/app_user.dart';
```

Bad:

```dart
export 'data/datasources/remote/auth_remote_data_source.dart';
```

Data implementation details should not be exposed to the whole app.

## Structure Rules

- Every feature should follow the same folder shape.
- Every cross-feature reusable widget belongs in `core/widgets`.
- Every feature-specific widget belongs inside that feature.
- App startup and app configuration belong in `app/`.
- Domain contracts belong in the feature `domain/` folder.
- Concrete API/database implementations belong in the feature `data/` folder.
- Shared low-level services belong in `core/`.


## Folder Ownership Rules

| Folder | Owns | Must Not Own |
|---|---|---|
| `app/` | App bootstrap, environment, root composition | Feature business rules |
| `core/` | Shared infrastructure and reusable app-wide tools | Feature-specific logic |
| `core/responsive/` | Breakpoints, screen-size classification, responsive helpers | Colors, typography, business logic |
| `core/theme/` | Material theme, design tokens, theme mode | Breakpoint ownership |
| `features/` | Feature UI, state, use cases, domain contracts, data adapters | Global infrastructure |
| `shared/` | Simple cross-feature models or types that do not fit `core` | App services or feature implementations |

When a new file is added, place it in the narrowest folder that owns its responsibility.
