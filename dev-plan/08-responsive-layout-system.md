# 08 - Responsive layout system

## Goal
Create centralized breakpoints, layout helpers, page constraints, and adaptive shell rules.

## Applies app rules
- [`responsive_adaptive_design.md`](../app-rules/responsive_adaptive_design.md)
- [`platform_guidelines.md`](../app-rules/platform_guidelines.md)
- [`multi_platform_input.md`](../app-rules/multi_platform_input.md)
- [`performance.md`](../app-rules/performance.md)

## Implementation tasks
1. Implement breakpoint utilities.
2. Create reusable page constraint widgets.
3. Create responsive spacing helpers based on design tokens.
4. Update shell layout for mobile, tablet, and desktop.
5. Add tests for breakpoint decisions.

## Expected output
- Responsive utility classes/widgets.
- Page max-width wrappers.
- Breakpoint tests.

## Acceptance criteria
- Core screens work at `320px` width.
- Large desktop layouts remain readable.
- No separate duplicate screen implementations are created.

## Coding-agent notes
- Do not skip rule references.
- Do not add product-specific behavior unless the step explicitly asks for it.
