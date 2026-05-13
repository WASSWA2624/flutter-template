# ADR 0003: Auth Session Security and Permissions

## Status

Accepted

## Context

The template needs protected route behavior, secure session persistence, and
centralized permission checks without requiring a product-specific identity
provider or backend contract.

Rule sources:

- `app-rules/authentication_session.md`
- `app-rules/security.md`
- `app-rules/permissions.md`
- `app-rules/navigation.md`
- `app-rules/storage_strategy.md`

## Decision

Represent runtime auth state with `SessionState`, backed by an optional
`AuthSession` and redacted `SessionTokens`. Store sensitive token artifacts only
through `SecureSessionStorage`, which wraps the existing secure storage boundary
and clears access, refresh, and token expiry values on logout or unauthorized
responses.

Expose `SessionController` as the mutable session provider seeded by startup
restoration. Route guards read session state and `AppPermissionGrant` rather
than raw token values. Permission checks remain typed and centralized through
`AppPermission` and `AppPermissionGrant`.

The auth repository contract is intentionally backend-agnostic. Product features
can implement sign-in, refresh, user profile loading, and registration behavior
behind that contract.

## Consequences

- Protected route checks can run before product auth screens exist.
- Logout and unauthorized responses clear sensitive session data.
- Token values are not included in diagnostics strings.
- Backend authorization remains the source of truth for protected resources.
