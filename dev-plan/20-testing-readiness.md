# 20 - Testing readiness

## Goal
Add unit, widget, and integration test foundations.

## Applies app rules
- [`testing.md`](../app-rules/testing.md)
- [`ci_cd_quality_gates.md`](../app-rules/ci_cd_quality_gates.md)
- [`state_management.md`](../app-rules/state_management.md)
- [`responsive_adaptive_design.md`](../app-rules/responsive_adaptive_design.md)

## Implementation tasks
1. Create test helper utilities.
2. Add provider override examples.
3. Add tests for validators, mappers, responsive utilities, and shared components.
4. Add integration startup/navigation smoke test.
5. Document test commands.

## Expected output
- Test helpers.
- Baseline unit/widget/integration tests.
- Documented test commands.

## Acceptance criteria
- `flutter test` passes.
- Tests do not require production services.
- Important shared UI has tests.

## Coding-agent notes
- Do not skip rule references.
- Do not add product-specific behavior unless the step explicitly asks for it.
