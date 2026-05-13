# Theming Strategy

## Owning Scope

This file defines light theme, dark theme, system theme mode, design tokens, and theme usage rules.

Responsive breakpoints are owned by [`responsive_adaptive_design.md`](./responsive_adaptive_design.md). Component behavior is owned by [`reusable_components.md`](./reusable_components.md).

## Theme Goals

The theme system must support:

- Light theme.
- Dark theme.
- System default theme mode.
- Consistent colors.
- Consistent typography.
- Consistent spacing.
- Consistent radius.
- Consistent component sizes.
- Consistent form styling.
- Consistent navigation styling.
- Consistent dialogs and overlays.

Default theme mode:

```txt
Light
```

The user should be able to choose:

```txt
Light
Dark
System
```

## Theme Files

```txt
core/theme/
  app_theme.dart
  app_theme_controller.dart
  app_theme_mode.dart
  app_color_schemes.dart
  app_spacing.dart
  app_radius.dart
  app_typography.dart
  app_shadows.dart
  app_component_sizes.dart
  app_theme_extensions.dart
```

## Material 3

Use Material 3 as the base design system.

```dart
ThemeData(
  useMaterial3: true,
  colorScheme: AppColorSchemes.light,
)
```

## Theme Data Structure

```dart
class AppTheme {
  const AppTheme._();

  static ThemeData light() {
    return ThemeData(
      useMaterial3: true,
      colorScheme: AppColorSchemes.light,
      typography: Typography.material2021(),
      inputDecorationTheme: AppInputThemes.light,
      elevatedButtonTheme: AppButtonThemes.elevatedLight,
      outlinedButtonTheme: AppButtonThemes.outlinedLight,
      textButtonTheme: AppButtonThemes.textLight,
    );
  }

  static ThemeData dark() {
    return ThemeData(
      useMaterial3: true,
      colorScheme: AppColorSchemes.dark,
      typography: Typography.material2021(),
      inputDecorationTheme: AppInputThemes.dark,
      elevatedButtonTheme: AppButtonThemes.elevatedDark,
      outlinedButtonTheme: AppButtonThemes.outlinedDark,
      textButtonTheme: AppButtonThemes.textDark,
    );
  }
}
```

## Design Tokens

Use app-level tokens for values that must stay consistent.

### Spacing

```dart
class AppSpacing {
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 16;
  static const double lg = 24;
  static const double xl = 32;
  static const double xxl = 48;
}
```

### Radius

```dart
class AppRadius {
  static const double sm = 6;
  static const double md = 10;
  static const double lg = 16;
  static const double xl = 24;
}
```

### Component Sizes

```dart
class AppComponentSizes {
  static const double minTapTarget = 48;
  static const double buttonHeight = 48;
  static const double inputHeight = 48;
  static const double desktopInputHeight = 44;
}
```

## Theme Extensions

Use `ThemeExtension` for custom tokens that should respond to light and dark themes.

```dart
@immutable
class AppSurfaceTheme extends ThemeExtension<AppSurfaceTheme> {
  const AppSurfaceTheme({
    required this.success,
    required this.warning,
    required this.info,
  });

  final Color success;
  final Color warning;
  final Color info;

  @override
  AppSurfaceTheme copyWith({
    Color? success,
    Color? warning,
    Color? info,
  }) {
    return AppSurfaceTheme(
      success: success ?? this.success,
      warning: warning ?? this.warning,
      info: info ?? this.info,
    );
  }

  @override
  AppSurfaceTheme lerp(ThemeExtension<AppSurfaceTheme>? other, double t) {
    if (other is! AppSurfaceTheme) return this;
    return AppSurfaceTheme(
      success: Color.lerp(success, other.success, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      info: Color.lerp(info, other.info, t)!,
    );
  }
}
```

## Theme Usage Rules

Bad:

```dart
Container(
  padding: const EdgeInsets.all(12),
  color: Colors.blue,
)
```

Good:

```dart
Container(
  padding: const EdgeInsets.all(AppSpacing.md),
  color: Theme.of(context).colorScheme.primary,
)
```

Rules:

- Do not hard-code app colors inside pages.
- Do not hard-code repeated spacing values.
- Do not create one-off button styles in screens.
- Use `Theme.of(context)` for colors, typography, and component styles.
- Use app tokens for spacing, radius, and layout sizes.
- Store theme mode in preferences.
- Keep theme changes reactive through Riverpod.

## Theme Mode Controller

```dart
enum AppThemeMode {
  light,
  dark,
  system,
}
```

Store the selected theme value in preferences because it is not sensitive.

Sensitive data storage rules are defined in [`storage_strategy.md`](./storage_strategy.md).


## Theme Ownership Boundary

The theme system owns visual design tokens. It does not own responsive breakpoints or route-level layout decisions.

Use [`responsive_adaptive_design.md`](./responsive_adaptive_design.md) for screen-size rules and [`reusable_components.md`](./reusable_components.md) for component behavior.
