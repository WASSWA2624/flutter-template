# 11 - Reusable components

## Goal
Build the minimal shared UI component library.

## Applies app rules
- [`reusable_components.md`](../app-rules/reusable_components.md)
- [`forms.md`](../app-rules/forms.md)
- [`theming.md`](../app-rules/theming.md)
- [`accessibility.md`](../app-rules/accessibility.md)
- [`responsive_adaptive_design.md`](../app-rules/responsive_adaptive_design.md)

## Implementation tasks
1. Create shared button, text field, select, radio, checkbox, switch, date field, dialog, and state view wrappers.
2. Base components on Flutter built-in widgets.
3. Support loading, disabled, error, and accessibility states where relevant.
4. Add examples or a component showcase screen only if useful for template validation.
5. Add widget tests for important components.

## Expected output
- Shared component files.
- Component tests.
- Optional component showcase.

## Acceptance criteria
- No duplicate component solves the same responsibility.
- Components are localized and theme-aware.
- Components work with touch, mouse, keyboard, and screen readers.

## Coding-agent notes
- Do not skip rule references.
- Do not add product-specific behavior unless the step explicitly asks for it.
