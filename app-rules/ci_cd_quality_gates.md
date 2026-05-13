# CI/CD and Quality Gates

## Scope
Defines automated checks and release readiness gates.

## Mandatory rules
- CI must fail on formatting differences.
- CI must fail on analyzer errors.
- CI must fail when required tests fail.
- CI must fail when generated code is stale if generated files are committed.
- CI must not use production credentials.
- CI must avoid printing secrets.
- Release builds must use production-safe configuration.
- Deployment scripts must be POSIX-friendly when intended for Linux/macOS CI or servers.

## Standard local commands
```bash
flutter pub get
dart run build_runner build --delete-conflicting-outputs
dart format --set-exit-if-changed .
flutter analyze
flutter test
flutter build web
flutter build apk
```

## Release checklist
- Version is set correctly.
- Formatting passes.
- Analyzer passes.
- Tests pass.
- Generated code is current.
- No secrets are committed.
- Production API URL and logging level are correct.
- Supported platform builds complete.

## Acceptance checklist
- CI reproduces the local quality gate commands.
- Builds are deterministic enough for release packaging.
- Release artifacts are documented.

## Related rules
- [`testing.md`](./testing.md)
- [`dependencies.md`](./dependencies.md)
- [`security.md`](./security.md)
- [`platform_guidelines.md`](./platform_guidelines.md)
