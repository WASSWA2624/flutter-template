import 'package:flutter/material.dart';
import 'package:flutter_template/l10n/app_strings.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return SafeArea(
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 720),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(AppStrings.readyTitle, style: textTheme.headlineSmall),
                const SizedBox(height: 12),
                Text(AppStrings.readyBody, style: textTheme.bodyLarge),
                const SizedBox(height: 24),
                const _SupportedPlatformList(),
              ],
            ),
          ),
        ),
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
        const SizedBox(height: 12),
        for (final String platform in AppStrings.supportedPlatforms)
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(
                  Icons.check_circle_outline,
                  color: Theme.of(context).colorScheme.primary,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(platform, style: textTheme.bodyMedium),
              ],
            ),
          ),
      ],
    );
  }
}
