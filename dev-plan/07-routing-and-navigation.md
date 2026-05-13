# 07 - Routing and navigation

## Goal
Configure declarative routing, route guards, and responsive shell navigation.

## Applies app rules
- [`navigation.md`](../app-rules/navigation.md)
- [`authentication_session.md`](../app-rules/authentication_session.md)
- [`permissions.md`](../app-rules/permissions.md)
- [`responsive_adaptive_design.md`](../app-rules/responsive_adaptive_design.md)

## Implementation tasks
1. Create route constants or typed helpers.
2. Configure `go_router`.
3. Add unknown-route handling.
4. Add auth/session guard readiness.
5. Create a responsive shell navigation pattern.
6. Avoid raw route strings in pages.

## Expected output
- Router configuration.
- Route guard utilities.
- Responsive shell scaffold.

## Acceptance criteria
- Protected route behavior is deterministic.
- Web URLs are readable.
- Unknown routes show localized not-found UI.

## Coding-agent notes
- Do not skip rule references.
- Do not add product-specific behavior unless the step explicitly asks for it.
