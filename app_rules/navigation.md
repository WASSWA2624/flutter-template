# Navigation Strategy

## Owning Scope

This file defines route paths, route names, GoRouter usage, route protection, redirect logic, and navigation rules.

Authentication session state is defined in [`authentication_session.md`](./authentication_session.md). Permissions are defined in [`permissions.md`](./permissions.md).

## Recommended Tool

Use `go_router`.

It supports:

- Declarative routing.
- Named routes.
- URL-based navigation.
- Deep links.
- Redirects.
- Route guards.
- Nested navigation.
- Web browser history.
- Shell routes.

## Routing Folder

```txt
core/routing/
  app_router.dart
  route_paths.dart
  route_names.dart
  route_guards.dart
  route_error_page.dart
  route_transitions.dart
```

## Route Names and Paths

```dart
class RouteNames {
  const RouteNames._();

  static const login = 'login';
  static const dashboard = 'dashboard';
  static const settings = 'settings';
}
```

```dart
class RoutePaths {
  const RoutePaths._();

  static const login = '/login';
  static const dashboard = '/dashboard';
  static const settings = '/settings';
}
```

## Route Types

| Route Type | Example | Rule |
|---|---|---|
| Public | `/login` | Anyone can access |
| Guest-only | `/register` | Only unauthenticated users |
| Protected | `/dashboard` | Requires authentication |
| Permission-based | `/admin` | Requires permission or role |
| Unknown | `/invalid-path` | Show route error page |

## Auth Redirect Logic

```txt
Unknown session
↓
Show startup/loading route

Unauthenticated user on protected route
↓
Redirect to login

Authenticated user on login/register
↓
Redirect to dashboard

Authenticated user without permission
↓
Redirect to forbidden page
```

## Navigation Rules

- Do not use raw route strings inside pages.
- Use route names or typed routes.
- Keep route guard logic centralized.
- Support browser back/forward navigation on web.
- Support deep links where product needs them.
- Handle unknown routes gracefully.
- Do not store sensitive data in URLs.
- Do not put large objects in route parameters.

## URL Parameter Rules

Use URL parameters only for values safe to expose.

Good:

```txt
/users/123
/orders/987
```

Avoid:

```txt
/reset-password?token=long-secret-token
```

Sensitive values should be handled through secure backend flows, not visible routes.


## URL and Parameter Rules

- Use path parameters for stable identifiers.
- Use query parameters for filters, tabs, and lightweight state that can be bookmarked.
- Do not put tokens, passwords, private notes, or large serialized objects in URLs.
- Validate route parameters before loading protected data.
