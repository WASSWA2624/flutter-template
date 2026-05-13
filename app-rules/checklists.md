# Checklists and Final Standard

## Owning Scope

This file collects starter, app creation, and final standard checklists. It references owning files instead of redefining their full rules.

## Recommended Starter Checklist

Before using this foundation for a real app, verify:

```txt
Clean architecture in place
Feature-first folder structure in place
Environment config in place
Startup flow in place
Theme system in place
Responsive layout system in place
Reusable component system in place
Localization setup in place
Auth module in place
Secure storage wrapper in place
Route guards in place
API client wrapper in place
Local database setup in place
Offline/cache strategy in place
Error handling system in place
State management providers in place
Testing structure in place
Documentation structure in place
Lint rules in place
CI checks in place
```

## App Creation Checklist

When creating a new app from this foundation:

```txt
Set app name
Set app ID/package name
Configure platforms
Configure environments
Configure launcher icons
Configure splash screen
Set API base URLs
Set theme colors
Set supported locales
Add auth provider details
Add app-specific feature modules
Add test setup
Run analyzer
Run tests
Build all target platforms
```

## Final Standard

The reusable Flutter foundation should follow this standard:

```txt
Feature-first architecture
Clean separation of concerns
Riverpod for state management and dependency injection
GoRouter for navigation
Material 3 theme system
ARB localization
No hard-coded user-facing text
Reusable app components
Responsive layout utilities
Secure authentication layer
Offline-capable repositories
Local database support
Consistent naming conventions
Strong testing structure
Minimal and reliable dependencies
```

## Fast Review Links

| Need | File |
|---|---|
| Architecture review | [`architecture.md`](./architecture.md) |
| Folder review | [`project_structure.md`](./project_structure.md) |
| UI consistency review | [`theming.md`](./theming.md), [`reusable_components.md`](./reusable_components.md) |
| Responsive review | [`responsive_adaptive_design.md`](./responsive_adaptive_design.md) |
| Security review | [`authentication_session.md`](./authentication_session.md), [`security.md`](./security.md) |
| Offline review | [`offline_sync.md`](./offline_sync.md), [`database_strategy.md`](./database_strategy.md) |
| Quality review | [`testing.md`](./testing.md), [`ci_cd_quality_gates.md`](./ci_cd_quality_gates.md) |

## Final Rule

When a convention is already defined in another file, link to that file instead of copying the same definition again.


## Maintenance Checklist

Review this rules package periodically:

```txt
Check Flutter stable changes
Check major dependency changes
Run link validation
Check for duplicated conventions
Check for stale platform assumptions
Update CI commands if tooling changes
Confirm security and storage guidance still matches the product risk level
```
