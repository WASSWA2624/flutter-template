# Environment Configuration

Rule sources:

- `app-rules/environment_configuration.md`
- `app-rules/security.md`
- `app-rules/network_api.md`
- `app-rules/feature_flags.md`

The app reads public, non-secret configuration from Flutter compile-time
defines. Store environment-specific values in Flutter define files under
`env/` and pass them with `--dart-define-from-file`. Do not commit secrets,
tokens, passwords, private certificates, or API keys in source code, docs,
assets, or local environment files.

## Files

| File | Purpose |
|---|---|
| `env/development.json` | Local development values. |
| `env/staging.json` | Staging placeholder values. |
| `env/production.json` | Production-safe placeholder values for release smoke builds. |

Use `env/*.local.json` for machine-specific overrides. These files are ignored
by Git.

## Values

| Key | Required | Values | Default |
|---|---:|---|---|
| `APP_ENV` | Yes | `development`, `staging`, `production` | none |
| `API_BASE_URL` | Yes | Absolute `http` or `https` URL | none |
| `API_TIMEOUT_SECONDS` | No | Positive integer seconds | `30` |
| `LOG_LEVEL` | No | `debug`, `info`, `warn`, `error` | `info` |
| `FEATURE_DEVELOPER_TOOLS_ENABLED` | No | `true`, `false` | `false` |

Production `API_BASE_URL` values must use `https`. URLs must not include
usernames, passwords, tokens, or other credentials.

## Examples

Development can use a local HTTP endpoint:

```sh
flutter run -d chrome --dart-define-from-file=env/development.json
```

Staging and production should use public HTTPS endpoints:

```sh
flutter run -d chrome --dart-define-from-file=env/staging.json
```

```sh
flutter build web --release --dart-define-from-file=env/production.json
```

Command-line `--dart-define=KEY=value` entries can still be used for CI or
temporary overrides; Flutter gives them precedence over matching keys from
define files.

## Tests

Tests should override `appConfigProvider` with a purpose-built `AppConfig`
instead of relying on process-level compile-time values. This keeps tests
isolated and prevents accidental dependency on local machine settings.
