# App Startup Flow

## Owning Scope

This file defines the startup and bootstrap sequence.

Environment values are defined in [`environment_configuration.md`](./environment_configuration.md). Session restoration is defined in [`authentication_session.md`](./authentication_session.md).

## Startup Sequence

```txt
main.dart
↓
app_bootstrap.dart
↓
Ensure Flutter binding
↓
Load environment/config
↓
Initialize logging
↓
Initialize preferences
↓
Initialize secure storage
↓
Initialize database
↓
Restore theme and locale
↓
Restore auth session
↓
Configure router
↓
Run app inside ProviderScope
```

## `main.dart`

```dart
import 'app/app_bootstrap.dart';
import 'app/app_environment.dart';

Future<void> main() async {
  await bootstrap(AppEnvironment.development);
}
```

## `app_bootstrap.dart`

```dart
Future<void> bootstrap(AppEnvironment environment) async {
  WidgetsFlutterBinding.ensureInitialized();

  final config = AppConfigFactory.create(environment);
  final bootstrapResult = await AppStartup.initialize(config);

  runApp(
    ProviderScope(
      overrides: bootstrapResult.providerOverrides,
      child: App(config: config),
    ),
  );
}
```

## Startup Result

Use a simple startup result object to pass initialized services into Riverpod overrides.

```dart
class AppStartupResult {
  const AppStartupResult({
    required this.providerOverrides,
  });

  final List<Override> providerOverrides;
}
```

## Startup Page

Use a startup or splash route while session restoration runs.

The app should not briefly show the login page before discovering the user is already authenticated.

## Startup Failure Rules

- Keep startup logic out of widgets.
- Keep initialization order explicit.
- Log startup failures safely.
- Do not expose internal error details to users.
- Show a localized startup error page if critical initialization fails.
- Keep startup services injectable for tests.
- Avoid long synchronous work on the UI thread.


## Startup Failure Handling

Startup failures should be handled through a dedicated startup error screen.

Rules:

- Log sanitized technical details internally.
- Show localized user-safe messages.
- Allow retry when the failure may be temporary.
- Do not continue into the app with partially initialized security, storage, or routing services.
