# 07 - Routing and navigation

## Goal

Implement declarative navigation using GoRouter with public routes, protected shell routes, adaptive app navigation, deep-link readiness, and route guards.

## Applies app rules

- [`navigation.md`](../app-rules/navigation.md)
- [`authentication_session.md`](../app-rules/authentication_session.md)
- [`permissions.md`](../app-rules/permissions.md)
- [`responsive_adaptive_design.md`](../app-rules/responsive_adaptive_design.md)
- [`multi_platform_input.md`](../app-rules/multi_platform_input.md)
- [`platform_guidelines.md`](../app-rules/platform_guidelines.md)

## Files to create

```txt
lib/core/routing/app_router.dart
lib/core/routing/route_names.dart
lib/core/routing/route_paths.dart
lib/core/routing/route_guards.dart
lib/core/routing/route_error_page.dart
lib/core/routing/route_transitions.dart
lib/core/widgets/navigation/adaptive_navigation.dart
lib/core/widgets/navigation/app_bottom_navigation.dart
lib/core/widgets/navigation/app_navigation_rail.dart
lib/core/widgets/navigation/app_sidebar.dart
```

## Route groups

Create these route categories:

| Route group | Examples | Access |
|---|---|---|
| Startup | `/startup`, `/splash` | Public |
| Public | `/sign-in`, `/forgot-password`, `/legal` | Public |
| Auth callback | `/auth/callback` | Public callback handler |
| Protected shell | `/home`, `/settings`, `/profile` | Requires valid session |
| Fullscreen protected | `/flow/...`, `/details/...` | Requires valid session |
| Error | `/error`, not found page | Public or contextual |

## Route constants

Use typed route names and paths:

```dart
abstract final class RouteNames {
  static const startup = 'startup';
  static const signIn = 'signIn';
  static const home = 'home';
  static const settings = 'settings';
}

abstract final class RoutePaths {
  static const startup = '/startup';
  static const signIn = '/sign-in';
  static const home = '/home';
  static const settings = '/settings';
}
```

Do not scatter raw route strings across pages.

## Router provider

Create a Riverpod provider:

```dart
final appRouterProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authSessionProvider);

  return GoRouter(
    initialLocation: RoutePaths.home,
    refreshListenable: GoRouterRefreshStream(authState.stream),
    redirect: (context, state) {
      return AppRouteGuards.redirect(
        authState: authState.value,
        location: state.uri.toString(),
      );
    },
    routes: appRoutes,
    errorBuilder: (context, state) => RouteErrorPage(error: state.error),
  );
});
```

Use the actual Riverpod/GoRouter refresh implementation that matches the final provider shape.

## Guard rules

- Redirect unauthenticated users away from protected routes.
- Do not redirect endlessly.
- Keep guard logic pure and based on auth/session state.
- Do not perform API calls inside route redirects.
- Permission checks may hide UI actions, but backend must remain authoritative.

## Adaptive navigation

Use one shared adaptive navigation component:

| Screen size | Navigation pattern |
|---|---|
| Small/medium/large mobile | Bottom navigation or drawer |
| Tablet | Navigation rail |
| Small desktop | Sidebar or rail |
| Large desktop | Sidebar with wider content |
| Extra-large desktop | Sidebar plus max-width content zones |

Feature pages should not individually decide the global navigation type.

## Web and desktop expectations

- Web URLs must be meaningful and bookmarkable.
- Browser back/forward should work.
- Desktop keyboard navigation must work.
- Route parameters must be encoded and parsed safely.
- Unknown routes show a safe not-found page.

## Acceptance criteria

- GoRouter is the only navigation system.
- Routes are named and centralized.
- Public and protected routes are clearly separated.
- Adaptive navigation works at all target breakpoints.
- Guards are pure and testable.
- Deep-link/callback route is reserved without binding to a specific backend.
