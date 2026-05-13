# 13 - API and repository readiness

## Goal
Create backend-agnostic API client, repository pattern, DTO mapping, and failure mapping.

## Applies app rules
- [`network_api.md`](../app-rules/network_api.md)
- [`repository_pattern_example.md`](../app-rules/repository_pattern_example.md)
- [`data_modeling.md`](../app-rules/data_modeling.md)
- [`error_handling.md`](../app-rules/error_handling.md)
- [`security.md`](../app-rules/security.md)

## Implementation tasks
1. Create a configurable Dio client.
2. Add safe interceptors for auth and diagnostics readiness.
3. Define API result/failure types.
4. Create an example repository contract and implementation.
5. Add DTO/entity mapping examples.
6. Ensure no product backend endpoint is required to run the starter.

## Expected output
- API client foundation.
- Failure mapper.
- Repository example.

## Acceptance criteria
- UI receives typed failures, not raw exceptions.
- Backend integration is ready but not product-specific.
- Sensitive values are not logged.

## Coding-agent notes
- Do not skip rule references.
- Do not add product-specific behavior unless the step explicitly asks for it.
