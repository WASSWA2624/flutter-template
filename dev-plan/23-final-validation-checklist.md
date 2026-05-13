# 23 - Final validation checklist

## Goal
Validate the whole template against all rules and the root blueprint.

## Applies app rules
- [`checklists.md`](../app-rules/checklists.md)
- [`validation_report.md`](../app-rules/validation_report.md)
- [`scope.md`](../app-rules/scope.md)
- [`ci_cd_quality_gates.md`](../app-rules/ci_cd_quality_gates.md)

## Implementation tasks
1. Read every rule file and confirm there are no contradictions.
2. Confirm every dev-plan file references relevant rules.
3. Run final format, analyze, generation, and test commands.
4. Validate supported screen-size behavior.
5. Confirm the starter remains backend-agnostic and reusable.

## Expected output
- Updated validation report.
- Final checklist results.
- Ready-to-use template.

## Acceptance criteria
- A developer can follow `01` through `23` in order.
- The result is a working reusable Flutter foundation.
- Architecture, UI behavior, and conventions are deterministic.

## Coding-agent notes
- Do not skip rule references.
- Do not add product-specific behavior unless the step explicitly asks for it.
