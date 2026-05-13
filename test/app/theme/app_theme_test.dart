import 'package:flutter/material.dart';
import 'package:flutter_template/app/theme/app_theme.dart';
import 'package:flutter_template/app/theme/app_theme_extensions.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AppTheme', () {
    test('builds light theme with app design token extensions', () {
      final ThemeData theme = AppTheme.light;

      expect(theme.useMaterial3, isTrue);
      expect(theme.colorScheme.brightness, Brightness.light);
      expect(theme.spacing.xs, 4);
      expect(theme.spacing.sm, 5);
      expect(theme.spacing.md, 8);
      expect(theme.spacing.lg, 12);
      expect(theme.spacing.xl, 18);
      expect(theme.spacing.xxl, 24);
      expect(theme.radius.sm, 0);
      expect(theme.radius.md, 0);
      expect(theme.radius.lg, 0);
      expect(theme.radius.xl, 0);
      expect(theme.appTokens.pagePaddingMobile, 10);
      expect(theme.appTokens.pagePaddingTablet, 14);
      expect(theme.appTokens.pagePaddingDesktop, 20);
      expect(theme.statusColors.success, AppStatusColors.light.success);
    });

    test('builds dark theme with dark status colors', () {
      final ThemeData theme = AppTheme.dark;

      expect(theme.colorScheme.brightness, Brightness.dark);
      expect(theme.statusColors.success, AppStatusColors.dark.success);
      expect(theme.statusColors.info, AppStatusColors.dark.info);
      expect(theme.appTokens.minInteractiveDimension, 38);
    });
  });
}
