# 21 - Build, CI, deployment, and release readiness

## Goal
Prepare quality gates and build commands for supported platforms.

## Applies app rules
- [`ci_cd_quality_gates.md`](../app-rules/ci_cd_quality_gates.md)
- [`platform_guidelines.md`](../app-rules/platform_guidelines.md)
- [`security.md`](../app-rules/security.md)
- [`dependencies.md`](../app-rules/dependencies.md)
- [`testing.md`](../app-rules/testing.md)

## Implementation tasks
1. Document local quality gate commands.
2. Create CI workflow guidance or config if required.
3. Document platform build commands for Android, iOS, Web, and Linux.
4. Check release config and versioning rules.
5. Ensure production builds do not contain debug-only behavior.

## Expected output
- Build documentation.
- CI quality gate plan/config.
- Release checklist.

## Acceptance criteria
- Format, analyze, tests, and generation commands are documented.
- Supported build commands are clear.
- No production secrets are included.

## Coding-agent notes
- Do not skip rule references.
- Do not add product-specific behavior unless the step explicitly asks for it.
