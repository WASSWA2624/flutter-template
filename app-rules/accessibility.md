# Accessibility Strategy

## Owning Scope

This file defines accessibility requirements, minimum rules, example patterns, and accessibility testing.

Reusable component capabilities are defined in [`reusable_components.md`](./reusable_components.md).

## Accessibility Requirements

The app should be usable with:

- Touch.
- Mouse.
- Keyboard.
- Screen readers.
- High contrast themes where possible.
- Scaled text.
- Different device sizes.

## Minimum Rules

- Use semantic labels for icon-only buttons.
- Keep tap targets at least `48px` where practical.
- Support keyboard navigation on web and desktop.
- Keep visible focus states.
- Do not rely only on color to communicate meaning.
- Keep text readable when font scaling is enabled.
- Use localized accessibility labels.
- Test important flows with keyboard only.

Component size tokens are defined in [`theming.md`](./theming.md).

## Example

Bad:

```dart
IconButton(
  icon: const Icon(Icons.close),
  onPressed: close,
)
```

Good:

```dart
IconButton(
  icon: const Icon(Icons.close),
  tooltip: context.l10n.close,
  onPressed: close,
)
```

## Accessibility Testing

Test:

- Screen reader labels on key actions.
- Keyboard tab order.
- Form error discoverability.
- Color contrast.
- Text scaling.
- Focus visibility.
- Dialog focus trapping.
- Navigation drawer/sidebar keyboard access.

## Accessibility Ownership

Accessibility is not only a QA task. Each shared component must support accessibility by default so feature teams do not rebuild accessibility rules manually.


## Additional Accessibility Rules

- Respect text scaling where layouts allow it.
- Provide visible focus states for keyboard users.
- Avoid color-only meaning; pair colors with text or icons.
- Avoid excessive motion and provide simpler transitions where possible.
- Ensure error messages are associated with their fields.
