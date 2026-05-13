# Navigation and Routing

## Scope
Defines routing, navigation guards, deep links, and route naming.

## Mandatory rules
- Use `go_router` as the single navigation package.
- Keep route definitions centralized under `lib/app/router`.
- Use named routes or typed route helpers; do not scatter raw route strings through pages.
- Protect routes through route guards based on session and permissions.
- Keep web URLs readable and stable.
- Support deep-link entry where the app needs it.
- Navigation decisions must not live inside repositories or data sources.
- Unknown routes must show a localized not-found page.

## Route structure standard
```txt
lib/app/router/
├── app_router.dart
├── app_routes.dart
├── route_guards.dart
└── route_refresh_listenable.dart
```

## Shell rules
- Use a shell route for apps with persistent navigation.
- Use responsive navigation patterns from `responsive_adaptive_design.md`.
- Do not duplicate pages for mobile and desktop routes unless interaction requirements differ.

## Acceptance checklist
- Auth redirect behavior is deterministic.
- Browser refresh on web restores the expected route state when possible.
- Protected routes cannot be entered without a valid session.
- Route names are documented and reused consistently.

## Related rules
- [`authentication_session.md`](./authentication_session.md)
- [`permissions.md`](./permissions.md)
- [`responsive_adaptive_design.md`](./responsive_adaptive_design.md)
- [`localization_i18n.md`](./localization_i18n.md)
