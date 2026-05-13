# Responsive and Adaptive Design Strategy

## Owning Scope

This file defines breakpoints, screen categories, responsive layout utilities, content widths, gutters, orientation rules, and adaptive navigation.

Component styling is defined in [`reusable_components.md`](./reusable_components.md). Theme tokens are defined in [`theming.md`](./theming.md).

## Main Rule

Do not design for only mobile.

Design for available space, input method, and platform behavior.

Responsive design answers:

```txt
How should the UI fit this screen size?
```

Adaptive design answers:

```txt
What interaction pattern works best for this device?
```

A strong Flutter starter should support both.

## Source of Truth

Responsive definitions live in `core/responsive/`. The canonical files are `app_breakpoints.dart`, `app_screen_size.dart`, `adaptive_layout_policy.dart`, and `responsive_utils.dart`.

## Breakpoints

Use logical pixels.

```dart
class AppBreakpoints {
  static const double smallMobile = 360;
  static const double mediumMobile = 430;
  static const double tablet = 768;
  static const double smallDesktop = 1024;
  static const double largeDesktop = 1440;
  static const double extraLargeDesktop = 1920;
}
```

## Device Categories

| Width | Category | Example Layout Behavior |
|---:|---|---|
| `< 360` | Small mobile | Single column, compact spacing |
| `360 - 429` | Medium mobile | Single column, standard mobile spacing |
| `430 - 767` | Large mobile | Single column, larger controls where useful |
| `768 - 1023` | Tablet | Two-column layouts where useful, navigation rail |
| `1024 - 1439` | Small desktop | Sidebar navigation, wider content |
| `1440 - 1919` | Large desktop | Sidebar, centered content, dashboards can expand |
| `1920+` | Extremely large desktop | Max-width content, avoid endless stretching |

## Responsive Utility

```dart
enum AppScreenSize {
  smallMobile,
  mediumMobile,
  largeMobile,
  tablet,
  smallDesktop,
  largeDesktop,
  extraLargeDesktop,
}
```

```dart
class ResponsiveUtils {
  const ResponsiveUtils._();

  static AppScreenSize screenSize(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;

    if (width < AppBreakpoints.smallMobile) {
      return AppScreenSize.smallMobile;
    }
    if (width < AppBreakpoints.mediumMobile) {
      return AppScreenSize.mediumMobile;
    }
    if (width < AppBreakpoints.tablet) {
      return AppScreenSize.largeMobile;
    }
    if (width < AppBreakpoints.smallDesktop) {
      return AppScreenSize.tablet;
    }
    if (width < AppBreakpoints.largeDesktop) {
      return AppScreenSize.smallDesktop;
    }
    if (width < AppBreakpoints.extraLargeDesktop) {
      return AppScreenSize.largeDesktop;
    }
    return AppScreenSize.extraLargeDesktop;
  }
}
```

## Responsive Layout Component

Create one standard `ResponsiveLayout` component.

```dart
class ResponsiveLayout extends StatelessWidget {
  const ResponsiveLayout({
    super.key,
    required this.mobile,
    this.tablet,
    this.desktop,
    this.largeDesktop,
  });

  final Widget mobile;
  final Widget? tablet;
  final Widget? desktop;
  final Widget? largeDesktop;

  @override
  Widget build(BuildContext context) {
    final size = ResponsiveUtils.screenSize(context);

    return switch (size) {
      AppScreenSize.smallMobile ||
      AppScreenSize.mediumMobile ||
      AppScreenSize.largeMobile => mobile,
      AppScreenSize.tablet => tablet ?? mobile,
      AppScreenSize.smallDesktop => desktop ?? tablet ?? mobile,
      AppScreenSize.largeDesktop ||
      AppScreenSize.extraLargeDesktop => largeDesktop ?? desktop ?? tablet ?? mobile,
    };
  }
}
```

## Adaptive Navigation

| Screen Type | Navigation Pattern |
|---|---|
| Small mobile | Bottom navigation or drawer |
| Medium mobile | Bottom navigation |
| Large mobile | Bottom navigation or drawer |
| Tablet | Navigation rail |
| Small desktop | Sidebar navigation |
| Large desktop | Sidebar navigation with wider content |
| Extremely large desktop | Sidebar with max-width content zones |

Create one `AdaptiveNavigation` component. The rest of the app should not manually decide navigation style on every page.

## Page Layout Standard

All pages should be wrapped with `AppPage`.

`AppPage` should handle:

- Safe areas.
- Page padding.
- Max content width.
- Scroll behavior.
- Loading state.
- Error state.
- Empty state.
- Page title.
- Optional actions.
- Responsive gutters.

Example:

```dart
AppPage(
  title: l10n.settings,
  maxWidth: AppContentWidth.form,
  child: SettingsForm(),
)
```

## Recommended Content Widths

| Content Type | Recommended Width |
|---|---:|
| Login form | `360px - 440px` |
| General form | `420px - 560px` |
| Reading content | `720px - 960px` |
| Settings page | `720px - 1040px` |
| Dashboard | `1200px - 1600px` |
| Data table | Flexible, with horizontal handling |
| Extremely large desktop content | Usually max `1600px` unless dashboard needs more |

## Responsive Gutters

| Screen Type | Horizontal Padding |
|---|---:|
| Small mobile | `12px` |
| Medium mobile | `16px` |
| Large mobile | `20px` |
| Tablet | `24px` |
| Desktop | `32px` |
| Large desktop | `40px` |
| Extremely large desktop | `48px` |

## Orientation Rules

The app must handle:

- Portrait phone.
- Landscape phone.
- Portrait tablet.
- Landscape tablet.
- Desktop resizing.
- Browser resizing.

Rules:

- Do not assume mobile is always portrait.
- Do not assume desktop windows are always large.
- Do not use fixed heights for scrollable pages.
- Use `SafeArea` where needed.
- Use adaptive layouts instead of only scaling widgets.
- Test key screens at every breakpoint.

## Desktop and Web Interaction Rules

Desktop and web users expect:

- Keyboard navigation.
- Hover states.
- Focus states.
- Larger content areas.
- Scrollbars when appropriate.
- Deep links on web.
- Browser back/forward behavior.
- Resizable layouts.
- Mouse-friendly menus.

Mobile users expect:

- Large tap targets.
- Bottom sheets.
- Touch-friendly spacing.
- Mobile keyboard support.
- Safe area handling.


## Required Responsive Test Matrix

Every important page should be checked at these widths before release:

| Width | Purpose |
|---:|---|
| `320` | Very small mobile safety check |
| `360` | Small mobile |
| `430` | Large mobile |
| `768` | Tablet entry point |
| `1024` | Small desktop and landscape tablet |
| `1440` | Large desktop |
| `1920` | Extremely large desktop |

Also test portrait and landscape where the platform supports orientation changes.
