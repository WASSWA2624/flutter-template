# Permission Strategy

## Owning Scope

This file defines permission and role conventions.

Auth sessions are defined in [`authentication_session.md`](./authentication_session.md). Route protection is defined in [`navigation.md`](./navigation.md).

## Permission Purpose

Permissions define what an authenticated user can do.

Examples:

```txt
viewDashboard
manageUsers
editProfile
exportReports
```

## Role and Permission Model

A role is a bundle of permissions.

A permission is a specific allowed action.

```dart
class AppUserPermissions {
  const AppUserPermissions({
    required this.values,
  });

  final Set<String> values;

  bool has(String permission) => values.contains(permission);
}
```

## Permission Rules

- The backend must enforce permissions.
- Frontend permissions improve UX but are not enough for real security.
- Use route guards for permission-based pages.
- Hide or disable UI actions the user cannot use.
- Show a localized forbidden page or message when access is denied.
- Keep permission names stable.
- Keep permission checks centralized when possible.

## Permission Location

Use permission checks in:

```txt
route guards
controllers
menu builders
action button visibility
action button enabled state
```

Avoid deep permission logic inside many small widgets unless the widget is explicitly a permission-aware component.

## Permission vs Feature Flag

| Concept | Meaning |
|---|---|
| Feature flag | Is this feature enabled for the app/environment/user group? |
| Permission | Is this user allowed to perform this action? |

Feature flags are defined in [`feature_flags.md`](./feature_flags.md).


## Permission Enforcement Rule

The frontend may hide or disable UI, but backend authorization must enforce access to protected resources. Client-side checks improve UX; they are not the security boundary.
