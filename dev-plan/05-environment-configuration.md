# 05 - Environment configuration

## Goal

Add environment configuration for development, staging, and production without adding secrets or backend-specific logic.

## Applies app rules

- [`environment_configuration.md`](../app-rules/environment_configuration.md)
- [`startup_flow.md`](../app-rules/startup_flow.md)
- [`feature_flags.md`](../app-rules/feature_flags.md)
- [`security.md`](../app-rules/security.md)
- [`dependencies.md`](../app-rules/dependencies.md)

## Required environments

Support:

```txt
development
staging
production
```

Each environment should provide:

- app display name or suffix
- public API base URL placeholder
- web base URL placeholder
- logging level
- feature flag defaults
- whether debug tools are enabled

## Files to create

```txt
lib/app/app_environment.dart
lib/app/app_config.dart
lib/app/app_providers.dart
lib/core/constants/app_constants.dart
lib/core/constants/storage_keys.dart
lib/core/security/secret_policy.md optional documentation
```

## Environment model

Create a small model:

```dart
enum AppEnvironment {
  development,
  staging,
  production,
}

class AppConfig {
  const AppConfig({
    required this.environment,
    required this.appName,
    required this.apiBaseUrl,
    required this.webBaseUrl,
    required this.enableDebugTools,
  });

  final AppEnvironment environment;
  final String appName;
  final Uri apiBaseUrl;
  final Uri webBaseUrl;
  final bool enableDebugTools;

  bool get isProduction => environment == AppEnvironment.production;
}
```

Use `--dart-define` for public, non-secret configuration only:

```bash
flutter run --dart-define=APP_ENV=development --dart-define=API_BASE_URL=https://api.example.test
```

Never place API secrets, OAuth client secrets, private keys, database passwords, or signing secrets in `dart-define`.

## App config provider

Expose config through Riverpod:

```dart
final appConfigProvider = Provider<AppConfig>((ref) {
  throw UnimplementedError('Override AppConfig during bootstrap.');
});
```

Override it inside `ProviderScope` during bootstrap.

## Feature flags

Create a minimal feature flag model:

```dart
class AppFeatureFlags {
  const AppFeatureFlags({
    this.enableOfflineSync = true,
    this.enableDebugBanner = false,
  });

  final bool enableOfflineSync;
  final bool enableDebugBanner;
}
```

Rules:

- Keep flags typed.
- Do not use stringly typed flags throughout the app.
- Delete flags after rollout when they are no longer needed.
- Do not use feature flags as security permission checks.

## Acceptance criteria

- Development, staging, and production environments are supported.
- Config is injectable and testable.
- No secrets are committed or embedded.
- Feature flags are typed and centralized.
- Later backend integrations can plug in through config without changing the architecture.
