# 06 - Startup bootstrap

## Goal

Create a safe app startup sequence that initializes framework binding, configuration, logging, preferences, secure storage, database readiness, session restoration, and error handling.

## Applies app rules

- [`startup_flow.md`](../app-rules/startup_flow.md)
- [`app_structure_example.md`](../app-rules/app_structure_example.md)
- [`environment_configuration.md`](../app-rules/environment_configuration.md)
- [`error_handling.md`](../app-rules/error_handling.md)
- [`observability.md`](../app-rules/observability.md)
- [`authentication_session.md`](../app-rules/authentication_session.md)
- [`storage_strategy.md`](../app-rules/storage_strategy.md)

## Startup sequence

Implement this order:

```txt
main.dart
↓
runZonedGuarded
↓
WidgetsFlutterBinding.ensureInitialized()
↓
load AppConfig
↓
initialize logging
↓
initialize preferences service
↓
initialize secure storage wrapper
↓
initialize database connection if enabled
↓
restore theme and locale preferences
↓
restore session state if auth is enabled
↓
runApp(ProviderScope(overrides: ...))
```

## Files to create

```txt
lib/main.dart
lib/app/app_bootstrap.dart
lib/app/app_startup.dart
lib/app/app.dart
lib/app/app_providers.dart
lib/core/logging/app_logger.dart
lib/core/errors/error_reporter.dart
lib/core/storage/preferences/preferences_service.dart
lib/core/security/secure_storage_service.dart
```

## `main.dart`

Keep `main.dart` thin:

```dart
Future<void> main() async {
  await bootstrapApp(
    environment: AppEnvironment.development,
  );
}
```

If separate entrypoints are required, add:

```txt
lib/main_development.dart
lib/main_staging.dart
lib/main_production.dart
```

## Bootstrap behavior

`bootstrapApp` should:

- set up guarded error handling
- build `AppConfig`
- initialize services
- create provider overrides
- run the root `App`
- report startup failures safely

Example shape:

```dart
Future<void> bootstrapApp({required AppEnvironment environment}) async {
  await runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();

    final config = AppConfigFactory.fromEnvironment(environment);
    final logger = AppLogger(config);
    final preferences = await PreferencesService.create();
    final secureStorage = SecureStorageService();

    runApp(
      ProviderScope(
        overrides: [
          appConfigProvider.overrideWithValue(config),
          loggerProvider.overrideWithValue(logger),
          preferencesServiceProvider.overrideWithValue(preferences),
          secureStorageServiceProvider.overrideWithValue(secureStorage),
        ],
        child: const App(),
      ),
    );
  }, (error, stackTrace) {
    AppErrorReporter.report(error, stackTrace);
  });
}
```

## Startup UI states

Create a startup screen or startup state handler for:

- loading
- recoverable failure
- unrecoverable failure
- session restoring

Do not show stack traces to users.

## Root `App`

The root `App` should compose:

- router
- light/dark themes
- theme mode
- localization delegates
- supported locales
- debug banner flag

## Acceptance criteria

- The app starts from a thin `main.dart`.
- All global services are injected, not created randomly in widgets.
- Startup errors are captured and mapped to safe user-facing UI.
- Theme, locale, and session restoration hooks are ready.
- The root app composes router, theme, localization, and config.
