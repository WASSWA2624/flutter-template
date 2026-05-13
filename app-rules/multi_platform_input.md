# Multi-Platform Input Strategy

## Owning Scope

This file defines input method expectations for touch, keyboard, mouse, pointer, and text input.

Platform-specific behavior is defined in [`platform_guidelines.md`](./platform_guidelines.md). Accessibility rules are defined in [`accessibility.md`](./accessibility.md).

## Input Types

The app should support:

- Touch input.
- Mouse input.
- Keyboard input.
- Trackpad input.
- Text input.
- Screen reader interaction.

## Keyboard Rules

- Support tab navigation on desktop and web.
- Keep focus order logical.
- Use `TextInputAction` for form fields.
- Support Enter submit where appropriate.
- Support Escape close for dialogs where appropriate.
- Avoid trapping focus accidentally.

## Pointer Rules

- Show hover states for interactive desktop/web elements.
- Use pointer-friendly menus on desktop.
- Keep tap targets large enough for touch.
- Do not require hover for critical actions.
- Support scroll wheel behavior on desktop.

## Text Input Rules

- Use correct keyboard types.
- Use autofill hints where useful.
- Avoid blocking text scaling.
- Handle mobile keyboard overlap.
- Validate and normalize input carefully.

Validation rules are owned by [`validation.md`](./validation.md).


## Shortcut Rules

Desktop and web screens may support keyboard shortcuts for common actions. Shortcuts must be discoverable, should not conflict with browser/system shortcuts, and must not be the only way to complete an action.
