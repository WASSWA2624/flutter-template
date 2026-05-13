# 05 - Environment configuration

## Goal
Add environment configuration for development, staging, and production readiness.

## Applies app rules
- [`environment_configuration.md`](../app-rules/environment_configuration.md)
- [`security.md`](../app-rules/security.md)
- [`network_api.md`](../app-rules/network_api.md)
- [`feature_flags.md`](../app-rules/feature_flags.md)

## Implementation tasks
1. Create typed environment configuration models.
2. Define supported environment names.
3. Add startup validation for required public config values.
4. Keep secrets out of source code.
5. Wire config providers for tests and app startup.

## Expected output
- Typed app config.
- Environment provider.
- Documented config values.

## Acceptance criteria
- Missing required config fails clearly.
- Tests can override config.
- No secrets are committed.

## Coding-agent notes
- Do not skip rule references.
- Do not add product-specific behavior unless the step explicitly asks for it.
