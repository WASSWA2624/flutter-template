# 08 - Responsive layout system

## Goal

Create a responsive and adaptive layout system that supports extra-small mobile screens through large desktop screens without separate app implementations.

## Applies app rules

- [`responsive_adaptive_design.md`](../app-rules/responsive_adaptive_design.md)
- [`reusable_components.md`](../app-rules/reusable_components.md)
- [`theming.md`](../app-rules/theming.md)
- [`accessibility.md`](../app-rules/accessibility.md)
- [`multi_platform_input.md`](../app-rules/multi_platform_input.md)
- Source blueprint: [`flutter-app-template.md`](../flutter-app-template.md)

## Files to create

```txt
lib/core/responsive/app_breakpoints.dart
lib/core/responsive/app_screen_size.dart
lib/core/responsive/adaptive_layout_policy.dart
lib/core/responsive/responsive_utils.dart
lib/core/widgets/layout/responsive_layout.dart
lib/core/widgets/layout/app_page.dart
lib/core/widgets/layout/app_scaffold.dart
lib/core/widgets/layout/app_split_view.dart
lib/core/widgets/layout/app_grid.dart
```

## Breakpoints

Use logical pixels:

```dart
abstract final class AppBreakpoints {
  static const double smallMobile = 360;
  static const double mediumMobile = 430;
  static const double tablet = 768;
  static const double smallDesktop = 1024;
  static const double largeDesktop = 1440;
  static const double extraLargeDesktop = 1920;
}
```

Screen categories:

| Width | Category | Default behavior |
|---:|---|---|
| `< 360` | Small mobile | Single column, compact spacing |
| `360 - 429` | Medium mobile | Single column, normal mobile spacing |
| `430 - 767` | Large mobile | Single column, larger controls where useful |
| `768 - 1023` | Tablet | Two-column where useful, navigation rail |
| `1024 - 1439` | Small desktop | Sidebar/rail, wider content |
| `1440 - 1919` | Large desktop | Sidebar, centered content, dashboards can expand |
| `1920+` | Extra-large desktop | Max-width content, avoid endless stretching |

## Responsive utilities

Create:

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
abstract final class ResponsiveUtils {
  static AppScreenSize screenSize(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;

    if (width < AppBreakpoints.smallMobile) return AppScreenSize.smallMobile;
    if (width < AppBreakpoints.mediumMobile) return AppScreenSize.mediumMobile;
    if (width < AppBreakpoints.tablet) return AppScreenSize.largeMobile;
    if (width < AppBreakpoints.smallDesktop) return AppScreenSize.tablet;
    if (width < AppBreakpoints.largeDesktop) return AppScreenSize.smallDesktop;
    if (width < AppBreakpoints.extraLargeDesktop) return AppScreenSize.largeDesktop;
    return AppScreenSize.extraLargeDesktop;
  }
}
```

## Shared layout widgets

### `ResponsiveLayout`

Use one standard component that chooses layout by available width, not by device name.

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

### `AppPage`

All pages should use `AppPage` for safe area, padding, max width, title, actions, scroll, loading, error, and empty states.

Recommended content widths:

| Content type | Width |
|---|---:|
| Login form | `360px - 440px` |
| General form | `420px - 560px` |
| Reading content | `720px - 960px` |
| Settings page | `720px - 1040px` |
| Dashboard | `1200px - 1600px` |
| Data table | Flexible with horizontal handling |

Responsive gutters:

| Screen type | Padding |
|---|---:|
| Small mobile | `12px` |
| Medium mobile | `16px` |
| Large mobile | `20px` |
| Tablet | `24px` |
| Desktop | `32px` |
| Large desktop | `40px` |
| Extra-large desktop | `48px` |

## Rules

- Do not branch primarily on device name.
- Do not assume mobile is portrait.
- Do not assume desktop windows are large.
- Avoid fixed heights on scrollable pages.
- Use `SafeArea` where needed.
- Use lazy lists/grids for large content.
- Keep reading content constrained on large displays.

## Acceptance criteria

- Breakpoints are centralized.
- `ResponsiveLayout` and `AppPage` exist.
- All starter pages use responsive wrappers.
- Layout works at `320`, `360`, `430`, `768`, `1024`, `1440`, and `1920` logical-pixel widths.
- Mobile, tablet, web, and desktop resizing are handled without layout overflow.
