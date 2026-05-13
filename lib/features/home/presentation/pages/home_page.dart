import 'package:flutter/material.dart';
import 'package:flutter_template/app/theme/app_theme_extensions.dart';
import 'package:flutter_template/l10n/app_localizations_x.dart';
import 'package:flutter_template/shared/layout/responsive_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TextTheme textTheme = theme.textTheme;
    final AppSpacingTokens spacing = theme.spacing;
    final l10n = context.l10n;

    return ResponsivePage(
      maxWidth: PageMaxWidth.form,
      centerVertically: true,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(l10n.homeReadyTitle, style: textTheme.headlineSmall),
          SizedBox(height: spacing.sm),
          Text(l10n.homeReadyBody, style: textTheme.bodyLarge),
          SizedBox(height: spacing.lg),
          const _SupportedPlatformList(),
        ],
      ),
    );
  }
}

class _SupportedPlatformList extends StatelessWidget {
  const _SupportedPlatformList();

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TextTheme textTheme = theme.textTheme;
    final AppDesignTokens appTokens = theme.appTokens;
    final AppSpacingTokens spacing = theme.spacing;
    final l10n = context.l10n;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(l10n.homeSupportedPlatformsLabel, style: textTheme.titleMedium),
        SizedBox(height: spacing.sm),
        for (final String platform in l10n.supportedStarterPlatforms)
          Padding(
            padding: EdgeInsets.only(bottom: spacing.xs),
            child: Row(
              children: <Widget>[
                Icon(
                  Icons.check_circle_outline,
                  color: theme.statusColors.success,
                  size: appTokens.listIconSize,
                ),
                SizedBox(width: spacing.xs),
                Expanded(child: Text(platform, style: textTheme.bodyMedium)),
              ],
            ),
          ),
      ],
    );
  }
}
