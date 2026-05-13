import 'package:flutter/material.dart';
import 'package:flutter_template/l10n/app_strings.dart';
import 'package:flutter_template/shared/layout/responsive_page.dart';
import 'package:flutter_template/shared/layout/responsive_spacing.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return ResponsivePage(
      maxWidth: PageMaxWidth.form,
      centerVertically: true,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(AppStrings.readyTitle, style: textTheme.headlineSmall),
          const SizedBox(height: AppSpacing.sm),
          Text(AppStrings.readyBody, style: textTheme.bodyLarge),
          const SizedBox(height: AppSpacing.lg),
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
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(AppStrings.supportedPlatformsLabel, style: textTheme.titleMedium),
        const SizedBox(height: AppSpacing.sm),
        for (final String platform in AppStrings.supportedPlatforms)
          Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.xs),
            child: Row(
              children: <Widget>[
                Icon(
                  Icons.check_circle_outline,
                  color: Theme.of(context).colorScheme.primary,
                  size: 20,
                ),
                const SizedBox(width: AppSpacing.xs),
                Expanded(child: Text(platform, style: textTheme.bodyMedium)),
              ],
            ),
          ),
      ],
    );
  }
}
