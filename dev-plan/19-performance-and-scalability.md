# 19 - Performance and scalability

## Goal
Optimize rebuilds, list rendering, startup cost, and future feature growth.

## Applies app rules
- [`performance.md`](../app-rules/performance.md)
- [`scalability.md`](../app-rules/scalability.md)
- [`responsive_adaptive_design.md`](../app-rules/responsive_adaptive_design.md)
- [`pagination_data_tables.md`](../app-rules/pagination_data_tables.md)

## Implementation tasks
1. Review provider watches for unnecessary rebuilds.
2. Ensure lists are lazy or paginated.
3. Avoid heavy startup network work.
4. Keep shared components generic.
5. Document performance checks for release readiness.

## Expected output
- Performance notes.
- Lazy/paginated list patterns.
- Scalability review checklist.

## Acceptance criteria
- Large lists remain performant.
- Startup remains minimal.
- Adding features does not require unrelated rewrites.

## Coding-agent notes
- Do not skip rule references.
- Do not add product-specific behavior unless the step explicitly asks for it.
