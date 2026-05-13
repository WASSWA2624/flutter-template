# Scope and Foundation Goals

## Purpose

This foundation defines a reusable Flutter starter architecture for building scalable, responsive, secure, maintainable, offline-capable, multi-platform applications.

This file is the single source of truth for supported platforms, supported screen categories, and the foundation-level goals.

## Supported Platforms

| Platform | Required Support |
|---|---:|
| Android | Yes |
| iOS | Yes |
| Web | Yes |
| Windows | Yes |

The structure should remain easy to extend later to macOS and Linux when a project requires them.

## Supported Window and Device Types

| Device / Window Type | Required Support |
|---|---:|
| Small mobile screens | Yes |
| Medium mobile screens | Yes |
| Large mobile screens | Yes |
| Tablets | Yes |
| Small desktops | Yes |
| Large desktops | Yes |
| Extremely large desktops | Yes |
| Portrait orientation | Yes |
| Landscape orientation | Yes |
| Browser resizing | Yes |
| Desktop window resizing | Yes |

Breakpoint values are owned by [`responsive_adaptive_design.md`](./responsive_adaptive_design.md).

## Foundation Outcomes

The starter codebase should enforce:

- Clean architecture.
- Consistent file organization.
- Responsive and adaptive layouts.
- Uniform reusable components.
- Strong localization rules.
- Secure authentication.
- Protected navigation.
- Offline-capable data handling.
- Reliable state management.
- Scalable dependency injection.
- Testable business logic.
- Maintainable coding standards.
- Good performance across platforms.
- Clear documentation.

## Non-Negotiable Rules

| Rule | Owning File |
|---|---|
| No hard-coded user-facing text | [`localization_i18n.md`](./localization_i18n.md) |
| No hard-coded route strings in screens | [`navigation.md`](./navigation.md) |
| No feature-specific logic in `core` | [`architecture.md`](./architecture.md) |
| No direct API/database calls from widgets | [`architecture.md`](./architecture.md) |
| No sensitive values in plain preferences | [`security.md`](./security.md) |
| No repeated UI styling inside feature pages | [`theming.md`](./theming.md) |
| No duplicate definitions across docs | Root `README.md` |

## Reusable Foundation Standard

A project using this foundation should feel consistent even when different developers build different features.

That means:

- Same naming style.
- Same folder shape.
- Same UI component behavior.
- Same error behavior.
- Same localization behavior.
- Same state management approach.
- Same security boundaries.
- Same testing expectations.


## Package-Level Rule

This app rules package is a convention source of truth. Each rule should have one owning file. When another file needs the same idea, it should link to the owning file instead of duplicating the full definition.
