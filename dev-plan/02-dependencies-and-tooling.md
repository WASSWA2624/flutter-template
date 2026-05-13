# 02 - Dependencies and tooling

## Goal
Add the approved dependency stack and configure linting, generation, and test tooling.

## Applies app rules
- [`dependencies.md`](../app-rules/dependencies.md)
- [`code_generation.md`](../app-rules/code_generation.md)
- [`coding_conventions.md`](../app-rules/coding_conventions.md)
- [`ci_cd_quality_gates.md`](../app-rules/ci_cd_quality_gates.md)

## Implementation tasks
1. Update `pubspec.yaml` with only the approved runtime and dev dependencies.
2. Configure `analysis_options.yaml` with Flutter, Riverpod, and custom lint readiness.
3. Add build runner scripts or documented commands.
4. Run dependency resolution and resolve conflicts without replacing the approved stack.
5. Document dependency purposes in README when needed.

## Expected output
- Updated `pubspec.yaml`.
- Strict analyzer configuration.
- Documented generation and quality commands.

## Acceptance criteria
- No duplicate package responsibilities exist.
- Analyzer/lint configuration is present.
- Dependency choices match `dependencies.md`.

## Coding-agent notes
- Do not skip rule references.
- Do not add product-specific behavior unless the step explicitly asks for it.
