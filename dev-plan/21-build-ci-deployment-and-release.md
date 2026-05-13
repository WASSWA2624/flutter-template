# 21 - Build, CI, deployment, and release readiness

## Goal

Define repeatable quality gates and build commands for supported platforms without tying the template to one hosting provider or app store process.

## Applies app rules

- [`ci_cd_quality_gates.md`](../app-rules/ci_cd_quality_gates.md)
- [`platform_guidelines.md`](../app-rules/platform_guidelines.md)
- [`security.md`](../app-rules/security.md)
- [`dependencies.md`](../app-rules/dependencies.md)
- [`testing.md`](../app-rules/testing.md)
- [`environment_configuration.md`](../app-rules/environment_configuration.md)

## CI quality gates

CI should run:

```bash
flutter pub get
dart format --set-exit-if-changed .
flutter analyze
dart run build_runner build --delete-conflicting-outputs
flutter test
flutter test integration_test
```

If integration tests require device/emulator setup, keep them in a dedicated CI job.

## Platform build commands

Use environment defines for public config only.

### Android

```bash
flutter build apk --release --dart-define=APP_ENV=production
flutter build appbundle --release --dart-define=APP_ENV=production
```

### iOS

```bash
flutter build ios --release --dart-define=APP_ENV=production
```

### Web

```bash
flutter build web --release --dart-define=APP_ENV=production
```

### Linux

```bash
flutter build linux --release --dart-define=APP_ENV=production
```

### Windows/macOS where applicable

```bash
flutter build windows --release --dart-define=APP_ENV=production
flutter build macos --release --dart-define=APP_ENV=production
```

## Release checklist

Before release:

- formatting passes
- analyzer passes
- tests pass
- generated code is current
- no secrets in source, assets, logs, or config
- production API URL uses HTTPS
- debug tools disabled
- verbose logging disabled
- app version set correctly
- platform-specific icons/splash configured if the product needs them
- accessibility smoke test complete
- responsive smoke test complete
- supported platform builds complete

## Deployment boundaries

The template should not include one fixed deployment system. Product apps may add:

- GitHub Actions
- GitLab CI
- Codemagic
- Bitrise
- Fastlane
- Firebase Hosting
- static web hosting
- app store deployment scripts

Keep deployment integration documented and isolated in `tool/` or CI configuration.

## Acceptance criteria

- CI commands are documented.
- Build commands exist for Android, iOS, Web, and Linux.
- Desktop builds are documented where applicable.
- Release checklist exists.
- Secret handling is explicit.
- The foundation remains provider-agnostic.
