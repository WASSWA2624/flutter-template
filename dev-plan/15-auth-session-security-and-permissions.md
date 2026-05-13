# 15 - Auth, session, security, and permissions

## Goal
Implement auth/session readiness and protected route behavior without forcing product-specific backend logic.

## Applies app rules
- [`authentication_session.md`](../app-rules/authentication_session.md)
- [`security.md`](../app-rules/security.md)
- [`permissions.md`](../app-rules/permissions.md)
- [`navigation.md`](../app-rules/navigation.md)
- [`storage_strategy.md`](../app-rules/storage_strategy.md)

## Implementation tasks
1. Create session state model.
2. Create auth repository contract.
3. Create secure session storage abstraction.
4. Wire route guards to session state.
5. Add permission types and helpers.
6. Add logout behavior that clears sensitive session data.

## Expected output
- Auth/session contracts.
- Session provider.
- Permission helpers.
- Guarded route example.

## Acceptance criteria
- Protected routes are blocked without session.
- Token values are never logged.
- Permission checks are centralized.

## Coding-agent notes
- Do not skip rule references.
- Do not add product-specific behavior unless the step explicitly asks for it.
