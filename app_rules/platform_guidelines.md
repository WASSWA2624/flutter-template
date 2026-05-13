# Platform-Specific Guidelines

## Owning Scope

This file defines platform expectations for Android, iOS, web, and Windows.

Responsive behavior is owned by [`responsive_adaptive_design.md`](./responsive_adaptive_design.md). Multi-platform input behavior is owned by [`multi_platform_input.md`](./multi_platform_input.md).

## Android

Android apps should support:

- Back button behavior.
- Safe areas and system bars.
- Runtime permissions only when needed.
- Correct keyboard behavior.
- Adaptive icons.
- Release signing.
- Android-specific deep link setup when required.

## iOS

iOS apps should support:

- Safe area handling.
- Cupertino expectations where appropriate.
- App privacy descriptions for permissions.
- Correct keyboard avoidance.
- iOS deep links when required.
- Release signing and provisioning.
- App Store metadata requirements.

## Web

Web apps should support:

- Browser back and forward buttons.
- Deep links.
- Refresh-safe routes.
- Responsive browser resizing.
- Keyboard and mouse interactions.
- Sensible loading state for first load.
- Avoiding long-lived tokens in browser local storage when possible.
- Hosting configuration for route fallback.

## Windows

Windows apps should support:

- Resizable windows.
- Minimum window size where appropriate.
- Keyboard shortcuts where useful.
- Mouse hover states.
- Scrollbars where helpful.
- Desktop-friendly navigation.
- Local file paths through platform-safe APIs.

## Platform Rule

Never assume that a platform means one screen size.

Examples:

- A web app can run on a small phone browser.
- A desktop app can be resized to a narrow window.
- A tablet can be portrait or landscape.
- A phone can be used in landscape.


## Cross-Platform Rule

A platform-specific implementation must be hidden behind an app interface when the rest of the app needs to call it. Feature code should not branch on platform unless the behavior is directly part of that feature's user experience.
