# 09 - Theme system

## Goal
Implement light, dark, and system theme mode using one design token system.

## Applies app rules
- [`theming.md`](../app-rules/theming.md)
- [`assets_branding.md`](../app-rules/assets_branding.md)
- [`accessibility.md`](../app-rules/accessibility.md)
- [`localization_i18n.md`](../app-rules/localization_i18n.md)

## Implementation tasks
1. Create `AppTheme.light` and `AppTheme.dark`.
2. Add theme extensions for spacing, radius, status colors, and app-specific tokens.
3. Implement theme mode controller and persistence.
4. Remove raw colors and repeated spacing from examples.
5. Add a small theme test or smoke test.

## Expected output
- Light and dark themes.
- Theme token extensions.
- Theme mode controller.

## Acceptance criteria
- Light theme is default.
- System/dark mode works.
- Shared components read from theme tokens.

## Coding-agent notes
- Do not skip rule references.
- Do not add product-specific behavior unless the step explicitly asks for it.
