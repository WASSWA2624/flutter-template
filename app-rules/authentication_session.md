# Authentication and Session Strategy

## Owning Scope

This file defines the auth feature, session lifecycle, token storage expectations, token refresh behavior, logout, and frontend authorization behavior.

Generic security rules are defined in [`security.md`](./security.md). Protected route behavior is defined in [`navigation.md`](./navigation.md).

## Auth Scope

Authentication belongs in the `auth` feature.

The auth feature handles:

- Sign in.
- Sign out.
- Register.
- Forgot password.
- Session restoration.
- Token refresh.
- Secure token storage.
- User profile restoration.
- Protected route state.
- Permission and role checks.

## Session States

```dart
enum AuthStatus {
  unknown,
  unauthenticated,
  authenticated,
  expired,
}
```

Use `unknown` during app startup while stored session data is being checked.

## Session Flow

```txt
App starts
↓
Secure storage is initialized
↓
Stored session is read
↓
Session expiry is checked
↓
Refresh token is used if needed
↓
User is loaded if session is valid
↓
Router opens correct route
```

## Token Storage

Sensitive values:

```txt
access token
refresh token
session id
private auth metadata
```

Store sensitive values using secure storage.

Non-sensitive values:

```txt
theme mode
locale
last opened tab
non-sensitive feature flags
```

Store non-sensitive values using preferences.

Storage boundaries are defined in [`storage_strategy.md`](./storage_strategy.md).

## Web Auth Recommendation

For web applications, prefer secure server-managed HTTP-only cookies where possible.

Avoid storing long-lived tokens in browser local storage.

If token storage in the browser is unavoidable, keep tokens short-lived and protect the app with strong backend security controls.

## Token Refresh Rules

- Refresh tokens before they expire.
- Do not refresh on every request.
- Use a refresh lock to prevent multiple simultaneous refresh calls.
- If refresh fails, clear session and redirect to login.
- Do not expose token values in logs.
- Do not store tokens in plain files.

## Logout Rules

On logout:

```txt
Cancel pending authenticated requests
Clear secure storage
Clear auth providers
Clear sensitive cached user data
Reset route state
Redirect to login
```

## Authorization Rules

Frontend authorization is only a user experience layer.

The backend must enforce real authorization.

Frontend rules:

- Hide UI actions the user cannot access.
- Protect routes with role/permission checks.
- Show a localized forbidden page when needed.
- Never rely only on hidden UI for security.

Permission modeling is owned by [`permissions.md`](./permissions.md).


## Session Ownership Boundary

The auth feature owns authentication state and token lifecycle. It should not own generic storage package decisions, logging policy, or backend authorization rules. Those are referenced from [`storage_strategy.md`](./storage_strategy.md), [`security.md`](./security.md), and [`permissions.md`](./permissions.md).
