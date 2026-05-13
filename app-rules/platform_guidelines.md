# Platform Guidelines

## Scope
Defines platform behavior for Android, iOS, Web, Linux desktop, and other desktop targets when enabled.

## Mandatory rules
- Keep the starter compatible with Android, iOS, Web, and Linux desktop.
- Avoid packages or APIs that break supported platforms unless guarded and documented.
- Use platform checks only at infrastructure boundaries, not throughout feature UI.
- Keep web URLs and browser refresh behavior in mind when defining routes.
- Keep desktop pointer, keyboard, window size, and hover behavior in mind.
- Keep mobile touch, safe areas, keyboard overlays, and orientation behavior in mind.
- Avoid smartwatch-specific requirements.

## Platform notes
| Platform | Required consideration |
|---|---|
| Android | back behavior, permissions, adaptive icons, small screens |
| iOS | safe areas, app lifecycle, permissions, platform review expectations |
| Web | URLs, refresh, storage limitations, keyboard/pointer interaction |
| Linux desktop | resizable windows, keyboard navigation, pointer/hover states |
| Windows/macOS | supported when enabled; follow same desktop rules |

## Acceptance checklist
- App builds for enabled platforms.
- Platform-specific behavior is isolated and documented.
- UI remains usable with touch, mouse, and keyboard.

## Related rules
- [`responsive_adaptive_design.md`](./responsive_adaptive_design.md)
- [`multi_platform_input.md`](./multi_platform_input.md)
- [`permissions.md`](./permissions.md)
- [`ci_cd_quality_gates.md`](./ci_cd_quality_gates.md)
