# 03 - App architecture

## Goal
Implement the feature-first clean architecture foundation and dependency boundaries.

## Applies app rules
- [`architecture.md`](../app-rules/architecture.md)
- [`project_structure.md`](../app-rules/project_structure.md)
- [`state_management.md`](../app-rules/state_management.md)
- [`data_modeling.md`](../app-rules/data_modeling.md)

## Implementation tasks
1. Create `app`, `core`, `features`, `l10n`, and `shared` folders.
2. Add placeholder/example feature folders only where useful for structure demonstration.
3. Create domain, data, and presentation subfolders for example features.
4. Document dependency direction in architecture docs.
5. Ensure examples do not violate the boundaries.

## Expected output
- Canonical architecture folders.
- Architecture README or docs section.
- Example feature skeleton.

## Acceptance criteria
- Widgets do not call APIs or storage directly.
- Domain code does not depend on Flutter widgets.
- Feature boundaries are clear.

## Coding-agent notes
- Do not skip rule references.
- Do not add product-specific behavior unless the step explicitly asks for it.
