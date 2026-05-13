import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/app/theme/app_theme_extensions.dart';
import 'package:flutter_template/features/home/domain/entities/home_readiness_snapshot.dart';
import 'package:flutter_template/features/home/presentation/controllers/home_controller.dart';
import 'package:flutter_template/l10n/app_localizations_x.dart';
import 'package:flutter_template/shared/components/components.dart';
import 'package:flutter_template/shared/layout/responsive_page.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final readiness = ref.watch(homeControllerProvider);
    final l10n = context.l10n;

    return AsyncStateScaffold<HomeReadinessSnapshot>(
      value: readiness,
      loadingTitle: l10n.homeLoadingTitle,
      loadingBody: l10n.homeLoadingBody,
      maxWidth: PageMaxWidth.form,
      onRetry: () {
        ref.read(homeControllerProvider.notifier).refresh();
      },
      dataBuilder: (context, snapshot) {
        if (!snapshot.isReady) {
          return const _HomeLoadingView();
        }

        return const _HomeReadyContent();
      },
    );
  }
}

class _HomeReadyContent extends StatelessWidget {
  const _HomeReadyContent();

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

class _HomeLoadingView extends StatelessWidget {
  const _HomeLoadingView();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return ResponsivePage(
      maxWidth: PageMaxWidth.form,
      centerVertically: true,
      child: AppStateView(
        variant: AppStateViewVariant.loading,
        title: l10n.homeLoadingTitle,
        body: l10n.homeLoadingBody,
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
