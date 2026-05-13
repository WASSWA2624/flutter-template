# 15 - Auth, session, security, and permissions readiness

## Goal

Create backend-agnostic authentication/session contracts, security boundaries, and permission structures without embedding a specific auth provider.

## Applies app rules

- [`authentication_session.md`](../app-rules/authentication_session.md)
- [`security.md`](../app-rules/security.md)
- [`permissions.md`](../app-rules/permissions.md)
- [`navigation.md`](../app-rules/navigation.md)
- [`storage_strategy.md`](../app-rules/storage_strategy.md)
- [`environment_configuration.md`](../app-rules/environment_configuration.md)
- [`validation.md`](../app-rules/validation.md)

## Auth scope

Authentication belongs in `features/auth/`.

Create contracts and state, not provider-specific implementation:

```txt
features/auth/
  auth.dart
  presentation/
    pages/
      sign_in_page.dart
      auth_callback_page.dart
    controllers/
    state/
  application/
    use_cases/
      sign_in_use_case.dart
      sign_out_use_case.dart
      refresh_session_use_case.dart
      restore_session_use_case.dart
    services/
  domain/
    entities/
      app_user.dart
      auth_session.dart
    repositories/
      auth_repository.dart
      session_repository.dart
      current_user_repository.dart
    failures/
  data/
    datasources/
    dto/
    mappers/
    repositories/
```

## Session states

Define:

```txt
unknown
unauthenticated
authenticating
authenticated
refreshing
expired
```

Use session state for route guards.

## Auth contracts

Create:

```dart
abstract interface class AuthRepository {
  Future<AppResult<AuthSession>> signIn();
  Future<AppResult<void>> signOut();
  Future<AppResult<AuthSession>> refreshSession();
}

abstract interface class SessionRepository {
  Future<AppResult<AuthSession?>> restoreSession();
  Future<AppResult<void>> saveSession(AuthSession session);
  Future<AppResult<void>> clearSession();
}
```

Real implementations can later use OIDC, Firebase, Supabase, a BFF, or another backend-specific adapter.

## Token storage policy

- Prefer memory-only access tokens when possible.
- Use secure storage for refresh/session artifacts on native/desktop only when required by the backend.
- Do not store sensitive values in `shared_preferences`.
- For Web, prefer backend-mediated sessions with secure HTTP-only cookies when the product architecture allows it.
- Never ship client secrets inside the Flutter app.

## Logout rules

Logout must:

- clear in-memory tokens
- clear secure session values
- clear protected user cache where appropriate
- reset protected providers
- navigate to a public route
- avoid leaking old user data after logout

## Permissions

Create permission/role models without pretending frontend checks are authoritative:

```txt
Permission
Role
CurrentUserPermissions
PermissionService
```

Rules:

- UI can hide or disable actions.
- Backend remains authoritative.
- Feature flags are not permissions.
- Permission checks must be easy to test.

## Security baseline

Implement wrappers and policies for:

- secure storage
- input sanitization where needed
- safe logging
- no stack traces in UI
- HTTPS-only backend URLs for staging/production
- no hard-coded secrets
- dependency review

## Acceptance criteria

- Auth contracts exist without binding to a backend SDK.
- Session states are defined and used by routing.
- Secure storage wrapper exists.
- Logout cleanup is documented and implemented.
- Permission checks are modeled but not confused with backend authorization.
- No secrets or provider-specific auth setup are embedded in the foundation.
