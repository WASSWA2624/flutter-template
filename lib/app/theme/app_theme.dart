import 'package:flutter/material.dart';
import 'package:flutter_template/app/theme/app_theme_extensions.dart';

abstract final class AppTheme {
  static ThemeData get light => _buildTheme(Brightness.light);

  static ThemeData get dark => _buildTheme(Brightness.dark);

  static ThemeData _buildTheme(Brightness brightness) {
    final ColorScheme colorScheme = ColorScheme.fromSeed(
      seedColor: const Color(0xFF0F766E),
      brightness: brightness,
    );
    const RoundedRectangleBorder rectangularShape = RoundedRectangleBorder();
    const AppSpacingTokens spacing = AppSpacingTokens.standard;
    const AppDesignTokens appTokens = AppDesignTokens.standard;
    final AppStatusColors statusColors = switch (brightness) {
      Brightness.light => AppStatusColors.light,
      Brightness.dark => AppStatusColors.dark,
    };
    final TextTheme baseTextTheme = switch (brightness) {
      Brightness.light => Typography.material2021(
        colorScheme: colorScheme,
      ).black,
      Brightness.dark => Typography.material2021(
        colorScheme: colorScheme,
      ).white,
    };

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: colorScheme.surfaceContainerLowest,
      canvasColor: colorScheme.surface,
      hoverColor: colorScheme.surfaceContainerHighest,
      splashColor: colorScheme.primary.withValues(alpha: 0.08),
      highlightColor: colorScheme.primary.withValues(alpha: 0.06),
      visualDensity: VisualDensity.standard,
      textTheme: baseTextTheme.apply(
        bodyColor: colorScheme.onSurface,
        displayColor: colorScheme.onSurface,
      ),
      extensions: <ThemeExtension<dynamic>>[
        spacing,
        AppRadiusTokens.standard,
        statusColors,
        appTokens,
      ],
      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        surfaceTintColor: Colors.transparent,
        centerTitle: false,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      cardTheme: const CardThemeData(
        shape: rectangularShape,
        clipBehavior: Clip.antiAlias,
      ),
      dividerTheme: DividerThemeData(
        color: colorScheme.outlineVariant,
        thickness: appTokens.dividerThickness,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          minimumSize: Size(
            appTokens.minInteractiveDimension,
            appTokens.minInteractiveDimension,
          ),
          shape: rectangularShape,
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: Size(
            appTokens.minInteractiveDimension,
            appTokens.minInteractiveDimension,
          ),
          shape: rectangularShape,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          minimumSize: Size(
            appTokens.minInteractiveDimension,
            appTokens.minInteractiveDimension,
          ),
          shape: rectangularShape,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          minimumSize: Size(
            appTokens.minInteractiveDimension,
            appTokens.minInteractiveDimension,
          ),
          shape: rectangularShape,
        ),
      ),
      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(
          minimumSize: const Size.square(40),
          padding: EdgeInsets.all(spacing.sm),
          shape: rectangularShape,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        contentPadding: EdgeInsets.symmetric(
          horizontal: spacing.lg,
          vertical: spacing.md,
        ),
        border: const OutlineInputBorder(borderRadius: BorderRadius.zero),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.zero,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.zero,
          borderSide: BorderSide(color: colorScheme.primary),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.zero,
          borderSide: BorderSide(color: statusColors.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.zero,
          borderSide: BorderSide(color: statusColors.error),
        ),
      ),
      navigationBarTheme: const NavigationBarThemeData(
        indicatorShape: rectangularShape,
      ),
      navigationRailTheme: const NavigationRailThemeData(
        indicatorShape: rectangularShape,
      ),
      drawerTheme: DrawerThemeData(
        backgroundColor: colorScheme.surface,
        shape: rectangularShape,
      ),
      listTileTheme: const ListTileThemeData(
        dense: true,
        shape: rectangularShape,
      ),
      snackBarTheme: const SnackBarThemeData(
        shape: rectangularShape,
        behavior: SnackBarBehavior.fixed,
      ),
      dialogTheme: const DialogThemeData(shape: rectangularShape),
    );
  }
}
