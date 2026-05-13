import 'package:flutter/material.dart';
import 'package:flutter_template/app/theme/app_theme_extensions.dart';
import 'package:flutter_template/shared/layout/responsive_page.dart';

enum AppStateViewVariant { loading, empty, error, success, info }

class AppStateView extends StatelessWidget {
  const AppStateView({
    required this.title,
    required this.body,
    this.variant = AppStateViewVariant.info,
    this.icon,
    this.detail,
    this.action,
    this.semanticLabel,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.textAlign = TextAlign.start,
    super.key,
  });

  final String title;
  final String body;
  final AppStateViewVariant variant;
  final IconData? icon;
  final String? detail;
  final Widget? action;
  final String? semanticLabel;
  final CrossAxisAlignment crossAxisAlignment;
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TextTheme textTheme = theme.textTheme;
    final AppSpacingTokens spacing = theme.spacing;

    return Semantics(
      container: true,
      liveRegion:
          variant == AppStateViewVariant.loading ||
          variant == AppStateViewVariant.error,
      label: semanticLabel ?? title,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: crossAxisAlignment,
        children: <Widget>[
          _StateVisual(variant: variant, icon: icon),
          SizedBox(height: spacing.md),
          Text(title, style: textTheme.headlineSmall, textAlign: textAlign),
          SizedBox(height: spacing.sm),
          Text(body, style: textTheme.bodyLarge, textAlign: textAlign),
          if (detail != null && detail!.isNotEmpty) ...<Widget>[
            SizedBox(height: spacing.sm),
            Text(detail!, style: textTheme.bodyMedium, textAlign: textAlign),
          ],
          if (action != null) ...<Widget>[
            SizedBox(height: spacing.lg),
            action!,
          ],
        ],
      ),
    );
  }
}

class AppStateScaffold extends StatelessWidget {
  const AppStateScaffold({
    required this.title,
    required this.body,
    this.appBarTitle,
    this.variant = AppStateViewVariant.info,
    this.icon,
    this.detail,
    this.action,
    this.semanticLabel,
    this.maxWidth = PageMaxWidth.authForm,
    this.centerVertically = true,
    this.scrollable = true,
    this.safeArea = true,
    super.key,
  });

  final String? appBarTitle;
  final String title;
  final String body;
  final AppStateViewVariant variant;
  final IconData? icon;
  final String? detail;
  final Widget? action;
  final String? semanticLabel;
  final PageMaxWidth maxWidth;
  final bool centerVertically;
  final bool scrollable;
  final bool safeArea;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarTitle == null ? null : AppBar(title: Text(appBarTitle!)),
      body: ResponsivePage(
        maxWidth: maxWidth,
        centerVertically: centerVertically,
        scrollable: scrollable,
        safeArea: safeArea,
        child: AppStateView(
          variant: variant,
          icon: icon,
          title: title,
          body: body,
          detail: detail,
          action: action,
          semanticLabel: semanticLabel,
        ),
      ),
    );
  }
}

class _StateVisual extends StatelessWidget {
  const _StateVisual({required this.variant, required this.icon});

  final AppStateViewVariant variant;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final AppDesignTokens appTokens = theme.appTokens;

    if (variant == AppStateViewVariant.loading) {
      return SizedBox.square(
        dimension: appTokens.statusIconSize,
        child: const CircularProgressIndicator(strokeWidth: 3),
      );
    }

    return Icon(
      icon ?? _defaultIcon(),
      size: appTokens.statusIconSize,
      color: _color(theme),
    );
  }

  IconData _defaultIcon() {
    return switch (variant) {
      AppStateViewVariant.loading => Icons.hourglass_empty_outlined,
      AppStateViewVariant.empty => Icons.inbox_outlined,
      AppStateViewVariant.error => Icons.error_outline,
      AppStateViewVariant.success => Icons.check_circle_outline,
      AppStateViewVariant.info => Icons.info_outline,
    };
  }

  Color _color(ThemeData theme) {
    return switch (variant) {
      AppStateViewVariant.loading => theme.colorScheme.primary,
      AppStateViewVariant.empty => theme.colorScheme.onSurfaceVariant,
      AppStateViewVariant.error => theme.statusColors.error,
      AppStateViewVariant.success => theme.statusColors.success,
      AppStateViewVariant.info => theme.statusColors.info,
    };
  }
}
