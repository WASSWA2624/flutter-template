# Environment Configuration

Rule sources:

- `app-rules/environment_configuration.md`
- `app-rules/security.md`
- `app-rules/network_api.md`
- `app-rules/feature_flags.md`

The app reads public, non-secret configuration from Flutter compile-time
defines. Do not commit secrets, tokens, passwords, private certificates, or API
keys in source code, docs, assets, or local environment files.

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
flutter run -d chrome \
  --dart-define=APP_ENV=development \
  --dart-define=API_BASE_URL=http://localhost:8080
```

Staging and production should use public HTTPS endpoints:

```sh
flutter run -d chrome \
  --dart-define=APP_ENV=staging \
  --dart-define=API_BASE_URL=https://staging-api.example.com
```

```sh
flutter build web \
  --dart-define=APP_ENV=production \
  --dart-define=API_BASE_URL=https://api.example.com \
  --dart-define=LOG_LEVEL=warn
```

## Tests

Tests should override `appConfigProvider` with a purpose-built `AppConfig`
instead of relying on process-level compile-time values. This keeps tests
isolated and prevents accidental dependency on local machine settings.
