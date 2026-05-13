import 'package:flutter/widgets.dart';
import 'package:flutter_template/shared/layout/app_breakpoints.dart';

abstract final class AppSpacing {
  static const double none = 0;
  static const double xxs = 4;
  static const double xs = 8;
  static const double sm = 12;
  static const double md = 16;
  static const double lg = 24;
  static const double xl = 32;
  static const double xxl = 40;
  static const double xxxl = 48;
}

abstract final class ResponsiveSpacing {
  static EdgeInsets pagePaddingFor(AppBreakpoint breakpoint) {
    return EdgeInsets.symmetric(
      horizontal: pageHorizontalPaddingFor(breakpoint),
      vertical: pageVerticalPaddingFor(breakpoint),
    );
  }

  static double pageHorizontalPaddingFor(AppBreakpoint breakpoint) {
    return switch (breakpoint) {
      AppBreakpoint.xs => AppSpacing.md,
      AppBreakpoint.sm => AppSpacing.lg,
      AppBreakpoint.md => AppSpacing.lg,
      AppBreakpoint.lg => AppSpacing.xl,
      AppBreakpoint.xl => AppSpacing.xxl,
      AppBreakpoint.xxl => AppSpacing.xxxl,
    };
  }

  static double pageVerticalPaddingFor(AppBreakpoint breakpoint) {
    return switch (breakpoint) {
      AppBreakpoint.xs || AppBreakpoint.sm => AppSpacing.lg,
      AppBreakpoint.md || AppBreakpoint.lg => AppSpacing.xl,
      AppBreakpoint.xl || AppBreakpoint.xxl => AppSpacing.xxl,
    };
  }

  static double sectionGapFor(AppBreakpoint breakpoint) {
    return switch (breakpoint) {
      AppBreakpoint.xs || AppBreakpoint.sm => AppSpacing.lg,
      AppBreakpoint.md || AppBreakpoint.lg => AppSpacing.xl,
      AppBreakpoint.xl || AppBreakpoint.xxl => AppSpacing.xxl,
    };
  }

  static double contentGapFor(AppBreakpoint breakpoint) {
    return switch (breakpoint) {
      AppBreakpoint.xs => AppSpacing.sm,
      AppBreakpoint.sm || AppBreakpoint.md => AppSpacing.md,
      AppBreakpoint.lg ||
      AppBreakpoint.xl ||
      AppBreakpoint.xxl => AppSpacing.lg,
    };
  }
}
