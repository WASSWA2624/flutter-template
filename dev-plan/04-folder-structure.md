# 04 - Folder structure

## Goal
Finalize the concrete source, test, docs, and tooling folders.

## Applies app rules
- [`project_structure.md`](../app-rules/project_structure.md)
- [`coding_conventions.md`](../app-rules/coding_conventions.md)
- [`testing.md`](../app-rules/testing.md)
- [`documentation_standards.md`](../app-rules/documentation_standards.md)

## Implementation tasks
1. Create the exact folder structure from `project_structure.md`.
2. Mirror source folders in `test/` where useful.
3. Add `.gitkeep` files only where empty folders must be retained.
4. Avoid duplicate directories for the same responsibility.
5. Update README with a folder structure summary.

## Expected output
- Stable folder tree.
- Matching test folders.
- Updated documentation.

## Acceptance criteria
- A developer can find routing, theme, networking, storage, and features quickly.
- No duplicate responsibility folders exist.

## Coding-agent notes
- Do not skip rule references.
- Do not add product-specific behavior unless the step explicitly asks for it.
