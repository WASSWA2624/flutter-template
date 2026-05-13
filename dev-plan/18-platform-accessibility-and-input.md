# 18 - Platform support, accessibility, and input

## Goal

Ensure the foundation works across Android, iOS, Web, Linux desktop, and other desktop platforms where applicable, with touch, mouse, keyboard, screen reader, and text scaling support.

## Applies app rules

- [`platform_guidelines.md`](../app-rules/platform_guidelines.md)
- [`accessibility.md`](../app-rules/accessibility.md)
- [`multi_platform_input.md`](../app-rules/multi_platform_input.md)
- [`responsive_adaptive_design.md`](../app-rules/responsive_adaptive_design.md)
- [`permissions.md`](../app-rules/permissions.md)
- [`assets_branding.md`](../app-rules/assets_branding.md)

## Platform targets

| Platform | Template requirement |
|---|---|
| Android | Required |
| iOS | Required |
| Web | Required |
| Linux desktop | Required |
| Windows desktop | Recommended where applicable |
| macOS desktop | Recommended where applicable |

## Platform files and services

Create:

```txt
lib/core/platform/app_platform.dart
lib/core/platform/platform_info.dart
lib/core/platform/platform_service.dart
```

Use these helpers sparingly. Prefer responsive layout by available width instead of platform branching.

## Platform expectations

### Android

- Respect safe areas and system UI.
- Handle soft keyboard correctly.
- Keep tap targets usable.
- Use platform permissions only when a feature needs them.

### iOS

- Respect safe areas.
- Avoid Android-only interaction assumptions.
- Use external browser flows for auth where applicable.
- Keep platform permissions user-friendly.

### Web

- Support browser back/forward through GoRouter.
- Use meaningful URLs.
- Avoid browser-visible long-lived secrets.
- Support keyboard and pointer interaction.
- Test resized browser windows.

### Linux/desktop

- Support mouse, keyboard, focus traversal, and scrollbars.
- Do not assume fixed window sizes.
- Ensure dialogs and menus work with keyboard.
- Keep layouts usable at small desktop windows.

## Accessibility baseline

Implement:

- semantic labels for icon-only buttons
- tap targets around `48px` where practical
- keyboard traversal for forms and navigation
- visible focus states
- screen-reader-friendly labels and error text
- text scaling support
- high contrast awareness where possible
- no color-only status indicators

## Input rules

Create common shortcut/action scaffolding for:

- submit form
- cancel/escape dialog
- navigate back
- search focus where relevant
- refresh where relevant

Use Flutter primitives such as `Shortcuts`, `Actions`, `FocusTraversalGroup`, and `FocusableActionDetector` for custom interactive widgets.

## Permission handling

Do not add runtime permission plugins until a feature requires them. When required:

- request permission only at the moment of need
- explain why it is needed
- handle denied/restricted states
- never request broad permissions preemptively

## Acceptance criteria

- The template builds for Android, iOS, Web, and Linux.
- Desktop support is not treated as an afterthought.
- Shared components have semantic labels and keyboard support.
- Responsive layouts do not rely on device-name checks.
- Permission handling remains opt-in and feature-specific.
