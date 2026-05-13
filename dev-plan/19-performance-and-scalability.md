# 19 - Performance and scalability

## Goal

Apply performance rules and scalability boundaries so the foundation stays lightweight now and can grow later.

## Applies app rules

- [`performance.md`](../app-rules/performance.md)
- [`scalability.md`](../app-rules/scalability.md)
- [`architecture.md`](../app-rules/architecture.md)
- [`state_management.md`](../app-rules/state_management.md)
- [`database_strategy.md`](../app-rules/database_strategy.md)
- [`assets_branding.md`](../app-rules/assets_branding.md)
- [`dependencies.md`](../app-rules/dependencies.md)

## Performance rules

Implement these as coding standards:

- Use `const` constructors whenever possible.
- Prefer small widgets over large build methods.
- Use builder/lazy constructors for long lists.
- Use `select` for Riverpod state slices.
- Avoid unnecessary global provider rebuilds.
- Keep heavy database/file work off the UI isolate where practical.
- Avoid expensive visual effects unless justified.
- Compress assets before adding them.
- Avoid huge image files.
- Profile in profile mode, not debug mode.

## Files and docs to create

```txt
docs/PERFORMANCE.md
lib/core/utils/debounce.dart
lib/core/utils/throttle.dart optional
```

## Image and asset performance

Rules:

- Use appropriately sized images.
- Prefer vector assets only when needed and supported.
- Do not ship large unused assets.
- Keep logos in `assets/logos/`.
- Use cache policies for remote images only when a product needs image-heavy behavior.

## Web performance

- Keep dependencies minimal.
- Avoid large UI kits.
- Avoid loading desktop-only or backend-specific packages unnecessarily.
- Test initial page load and route transitions.
- Avoid excessive synchronous work during startup.

## Desktop performance

- Test resizable windows.
- Avoid expensive rebuilds during resizing.
- Use constrained/max-width layouts instead of stretching everything.
- Ensure data tables and dashboards virtualize or paginate large data.

## Scalability rules

Start simple but keep boundaries clean:

- Add domain/use-case layers only when business complexity requires them.
- Keep repositories abstract.
- Keep DTOs separate from entities for non-trivial integrations.
- Extract repo-local packages only after reuse is proven.
- Split large generated database code as the schema grows.
- Keep features independently testable.

## Avoid these problems

- One global state object.
- One massive `core` folder with feature business logic.
- Raw API calls from widgets.
- Ad hoc component styling in every feature.
- Over-extracting packages before reuse is proven.
- Adding dependencies for simple Flutter SDK behavior.

## Acceptance criteria

- `docs/PERFORMANCE.md` exists.
- Performance rules are reflected in code patterns.
- Layout and state management avoid unnecessary rebuilds.
- The foundation remains lightweight.
- Scaling rules are documented for future product teams.
