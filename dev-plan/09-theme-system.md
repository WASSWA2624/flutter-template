# 09 - Theme system

## Goal

Implement a Material 3 theme system with light, dark, and system modes, centralized design tokens, and consistent component styling.

Light mode must be the first-run default.

## Applies app rules

- [`theming.md`](../app-rules/theming.md)
- [`reusable_components.md`](../app-rules/reusable_components.md)
- [`responsive_adaptive_design.md`](../app-rules/responsive_adaptive_design.md)
- [`storage_strategy.md`](../app-rules/storage_strategy.md)
- [`accessibility.md`](../app-rules/accessibility.md)

## Files to create

```txt
lib/core/theme/app_theme.dart
lib/core/theme/app_theme_controller.dart
lib/core/theme/app_theme_mode.dart
lib/core/theme/app_color_schemes.dart
lib/core/theme/app_spacing.dart
lib/core/theme/app_radius.dart
lib/core/theme/app_typography.dart
lib/core/theme/app_shadows.dart
lib/core/theme/app_component_sizes.dart
lib/core/theme/app_theme_extensions.dart
```

## Theme goals

Support:

- Material 3
- light theme
- dark theme
- system theme mode
- central color tokens
- typography tokens
- spacing tokens
- radius tokens
- component size tokens
- consistent forms, dialogs, navigation, cards, snackbars, and buttons

## Theme entry point

Create:

```dart
abstract final class AppTheme {
  static ThemeData light() {
    return ThemeData(
      useMaterial3: true,
      colorScheme: AppColorSchemes.light,
      extensions: const [
        AppSpacingTheme.regular,
        AppRadiusTheme.regular,
        AppStatusColorTheme.light,
      ],
    );
  }

  static ThemeData dark() {
    return ThemeData(
      useMaterial3: true,
      colorScheme: AppColorSchemes.dark,
      extensions: const [
        AppSpacingTheme.regular,
        AppRadiusTheme.regular,
        AppStatusColorTheme.dark,
      ],
    );
  }
}
```

Use the final code shape required by Flutter's `ThemeExtension` API.

## Theme mode controller

Persist user preference in preferences storage:

```dart
enum AppThemeMode {
  light,
  dark,
  system,
}
```

Rules:

- First run uses light mode.
- User may choose light, dark, or system.
- Theme mode is app state and should be exposed through Riverpod.
- Never store theme mode in secure storage.

## Component theme configuration

Configure Material component themes centrally:

- buttons
- input decoration
- cards
- dialogs
- snackbars
- chips
- navigation bar
- navigation rail
- drawer/sidebar styles
- data tables
- focus/hover states

## Token usage rules

- Do not use raw brand colors in pages.
- Do not define random spacing values inside features.
- Shared components must read tokens from theme/extensions.
- Product-specific themes may override tokens later.

## Accessibility considerations

- Ensure sufficient contrast.
- Support text scaling.
- Keep visible focus states.
- Avoid using color as the only status indicator.

## Acceptance criteria

- Light, dark, and system modes work.
- Light is default on first launch.
- Theme mode persists across restarts.
- Shared components consume theme tokens.
- No feature page contains ad hoc brand colors or arbitrary radius/spacing constants.
