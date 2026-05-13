# 17 - Error handling and observability

## Goal
Create typed failures, safe logging, and consistent state views.

## Applies app rules
- [`error_handling.md`](../app-rules/error_handling.md)
- [`observability.md`](../app-rules/observability.md)
- [`network_api.md`](../app-rules/network_api.md)
- [`security.md`](../app-rules/security.md)
- [`localization_i18n.md`](../app-rules/localization_i18n.md)

## Implementation tasks
1. Create failure classes or sealed failures.
2. Create error-to-message mapping through localization.
3. Create safe logger abstraction.
4. Wire `AsyncStateScaffold` to typed errors.
5. Add tests for failure mapping.

## Expected output
- Typed failure model.
- Safe logger.
- Localized error views.

## Acceptance criteria
- Raw exceptions are not shown to users.
- Logs do not expose sensitive data.
- Recoverable errors have retry paths.

## Coding-agent notes
- Do not skip rule references.
- Do not add product-specific behavior unless the step explicitly asks for it.
