# 12 - State management and DI

## Goal
Wire Riverpod providers for app services, controllers, repositories, and test overrides.

## Applies app rules
- [`state_management.md`](../app-rules/state_management.md)
- [`architecture.md`](../app-rules/architecture.md)
- [`testing.md`](../app-rules/testing.md)
- [`startup_flow.md`](../app-rules/startup_flow.md)

## Implementation tasks
1. Create app-level providers for config, router, theme, locale, and startup state.
2. Create infrastructure providers for network/storage placeholders.
3. Create example feature controller providers.
4. Ensure providers can be overridden in tests.
5. Use `AsyncValue` or shared wrappers for async state.

## Expected output
- Provider structure.
- Controller example.
- Provider override examples in tests.

## Acceptance criteria
- No competing state management package is added.
- UI does not instantiate services directly.
- Async states are handled consistently.

## Coding-agent notes
- Do not skip rule references.
- Do not add product-specific behavior unless the step explicitly asks for it.
