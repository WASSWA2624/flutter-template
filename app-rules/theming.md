# Theme System

## Scope
Defines the visual system used by every screen and component.

## Mandatory rules
- Use Material 3 as the default design foundation.
- Light theme is the default app theme.
- Support dark theme and system theme mode.
- Do not hard-code colors in feature widgets.
- Do not hard-code repeated spacing, radius, elevation, or typography values in feature widgets.
- Store theme mode as a non-sensitive preference.
- Theme changes must update the app reactively.
- Shared components must read colors, typography, and shape from the active theme or app design tokens.

## Design tokens
| Token group | Required examples |
|---|---|
| Spacing | `xs=4`, `sm=8`, `md=12`, `lg=16`, `xl=24`, `xxl=32` |
| Radius | `sm=8`, `md=12`, `lg=16`, `xl=24` |
| Page padding | mobile `16`, tablet `24`, desktop `32` |
| Form gap | compact `12`, regular `16`, spacious `24` |
| Max widths | reuse values from `responsive_adaptive_design.md` |

## Typography rules
- Use theme text styles instead of raw `TextStyle` duplication.
- Keep headings consistent by screen purpose.
- Keep body text readable at scaled font sizes.
- Use locale-aware text direction where needed.

## Component styling
- App buttons, fields, cards, dialogs, lists, and shell navigation must have one shared visual language.
- State colors such as success, warning, error, and info must come from the theme extension or color scheme.
- Feature widgets may compose shared components but must not create a competing design system.

## Acceptance checklist
- Switching light, dark, and system modes works without restarting.
- Shared UI looks consistent on all supported platforms.
- New feature screens can be built without raw colors or repeated spacing constants.

## Related rules
- [`reusable_components.md`](./reusable_components.md)
- [`responsive_adaptive_design.md`](./responsive_adaptive_design.md)
- [`localization_i18n.md`](./localization_i18n.md)
- [`accessibility.md`](./accessibility.md)
