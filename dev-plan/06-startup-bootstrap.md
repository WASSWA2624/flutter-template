# 06 - Startup bootstrap

## Goal
Implement app startup, service initialization, and root app wiring.

## Applies app rules
- [`startup_flow.md`](../app-rules/startup_flow.md)
- [`app_structure_example.md`](../app-rules/app_structure_example.md)
- [`state_management.md`](../app-rules/state_management.md)
- [`error_handling.md`](../app-rules/error_handling.md)

## Implementation tasks
1. Keep `main.dart` small.
2. Create `bootstrap.dart` for startup initialization.
3. Initialize config, logging, storage readiness, theme/locale restoration, and session readiness.
4. Create root `ProviderScope` overrides where needed.
5. Add startup loading and startup error behavior.

## Expected output
- Small `main.dart`.
- `bootstrap.dart` startup flow.
- Root app wiring.

## Acceptance criteria
- Cold start is predictable.
- Startup errors are handled safely.
- No service initialization happens inside `App.build`.

## Coding-agent notes
- Do not skip rule references.
- Do not add product-specific behavior unless the step explicitly asks for it.
