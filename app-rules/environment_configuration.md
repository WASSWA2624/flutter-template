# Environment Configuration

## Owning Scope

This file defines environment names, environment values, `AppConfig`, flavor usage, and environment rules.

Startup order is defined in [`startup_flow.md`](./startup_flow.md).

## Environments

Support at least three environments:

```txt
development
staging
production
```

## Environment Values

Each environment should define:

- App name or suffix.
- API base URL.
- Web base URL.
- Logging level.
- Feature flags.
- Crash reporting setting.
- Analytics setting.
- Token refresh settings.
- Offline sync settings.

Never store secrets in frontend environment files. Frontend apps cannot safely keep private API secrets.

## Environment Model

```dart
enum AppEnvironment {
  development,
  staging,
  production,
}
```

```dart
class AppConfig {
  const AppConfig({
    required this.environment,
    required this.apiBaseUrl,
    required this.enableLogging,
    required this.enableCrashReporting,
  });

  final AppEnvironment environment;
  final Uri apiBaseUrl;
  final bool enableLogging;
  final bool enableCrashReporting;
}
```

## Using Flavors

Use platform flavors when the app needs separate builds.

```bash
flutter run --flavor development
flutter run --flavor staging
flutter run --flavor production
```

For simple projects, `--dart-define` may be enough.

```bash
flutter run --dart-define=APP_ENV=development
flutter build web --dart-define=APP_ENV=production
```

## Configuration Factory

Use one factory to parse environment values.

```dart
class AppConfigFactory {
  const AppConfigFactory._();

  static AppConfig create(AppEnvironment environment) {
    return switch (environment) {
      AppEnvironment.development => AppConfig(
          environment: environment,
          apiBaseUrl: Uri.parse('https://dev-api.example.com'),
          enableLogging: true,
          enableCrashReporting: false,
        ),
      AppEnvironment.staging => AppConfig(
          environment: environment,
          apiBaseUrl: Uri.parse('https://staging-api.example.com'),
          enableLogging: true,
          enableCrashReporting: true,
        ),
      AppEnvironment.production => AppConfig(
          environment: environment,
          apiBaseUrl: Uri.parse('https://api.example.com'),
          enableLogging: false,
          enableCrashReporting: true,
        ),
    };
  }
}
```

## Environment Rules

- Do not hard-code API URLs inside widgets.
- Do not hard-code production settings inside repositories.
- Do not store private secrets in Dart code.
- Keep environment parsing in one place.
- Fail fast if required configuration is missing.
- Make environment values available through dependency injection.
- Do not let feature code directly read raw environment variables.


## Compile-Time Configuration Rules

Use compile-time values for non-secret environment selection only.

```dart
const appEnv = String.fromEnvironment(
  'APP_ENV',
  defaultValue: 'development',
);
```

Rules:

- Treat all frontend config as public.
- Use backend-issued short-lived tokens for private access.
- Keep environment parsing in one factory.
- Fail fast when a required public config value is missing.
