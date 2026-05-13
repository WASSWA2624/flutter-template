# 18 - Platform, accessibility, and input

## Goal
Finalize platform compatibility, input methods, accessibility, and permission handling.

## Applies app rules
- [`platform_guidelines.md`](../app-rules/platform_guidelines.md)
- [`multi_platform_input.md`](../app-rules/multi_platform_input.md)
- [`accessibility.md`](../app-rules/accessibility.md)
- [`permissions.md`](../app-rules/permissions.md)

## Implementation tasks
1. Check mobile safe areas and keyboard insets.
2. Check desktop/web keyboard and pointer behavior.
3. Add semantic labels to icon-only actions.
4. Add focus behavior for menus/dialogs.
5. Document platform-specific limitations.

## Expected output
- Platform behavior notes.
- Accessibility improvements.
- Input interaction tests where practical.

## Acceptance criteria
- Core flows work with keyboard only.
- Touch targets are practical.
- No important action is hover-only.

## Coding-agent notes
- Do not skip rule references.
- Do not add product-specific behavior unless the step explicitly asks for it.
