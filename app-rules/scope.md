# Project Scope

## Scope
Defines what this Flutter template must include and what it must deliberately leave to app-specific projects.

## Mandatory rules
- Build a reusable Flutter foundation, not a finished product-specific app.
- Support Android, iOS, Web, Linux desktop, and other desktop targets where the Flutter project enables them.
- Support extra-small mobile screens through large desktop screens, excluding smartwatch-sized layouts.
- Keep the template backend-agnostic. Include API contracts and integration readiness, but do not hard-code a product backend.
- Provide a minimal complete startup app: bootstrapping, routing, theming, localization readiness, state management, networking readiness, storage readiness, reusable components, tests, and documentation.
- Prefer Flutter built-in widgets and official platform patterns before creating custom abstractions.
- Avoid unnecessary dependencies, duplicate components, duplicate folders, and duplicate rules.

## Implementation standard
- Every feature added to the template must be generally useful for most apps.
- Every product-specific feature must live outside the starter or be added only by a later app-specific plan.
- The template must have a single look-and-feel system based on theme tokens and shared components.
- The dev plan must be executable chronologically from `01` to the final validation step.

## Acceptance checklist
- The template can run after setup without requiring a real backend.
- No rule contradicts another rule in `app-rules/`.
- The dev plan references the exact rule files that govern each step.
- A coding agent can follow the plan and produce the same architecture, behavior, and UI conventions.

## Related rules
- [`project_structure.md`](./project_structure.md)
- [`architecture.md`](./architecture.md)
- [`dependencies.md`](./dependencies.md)
- [`responsive_adaptive_design.md`](./responsive_adaptive_design.md)
- [`reusable_components.md`](./reusable_components.md)
- [`checklists.md`](./checklists.md)
