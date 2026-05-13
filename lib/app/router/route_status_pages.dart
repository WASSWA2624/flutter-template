import 'package:flutter/material.dart';
import 'package:flutter_template/app/router/app_routes.dart';
import 'package:flutter_template/app/theme/app_theme_extensions.dart';
import 'package:flutter_template/l10n/app_strings.dart';
import 'package:flutter_template/shared/layout/responsive_page.dart';
import 'package:go_router/go_router.dart';

class SessionRestoringPage extends StatelessWidget {
  const SessionRestoringPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const _RouteStatusPage(
      icon: Icons.lock_clock_outlined,
      title: AppStrings.sessionRestoringTitle,
      body: AppStrings.sessionRestoringBody,
      actionLabel: AppStrings.goHomeActionLabel,
    );
  }
}

class AuthRequiredPage extends StatelessWidget {
  const AuthRequiredPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const _RouteStatusPage(
      icon: Icons.lock_outline,
      title: AppStrings.authRequiredTitle,
      body: AppStrings.authRequiredBody,
      actionLabel: AppStrings.goHomeActionLabel,
    );
  }
}

class ForbiddenPage extends StatelessWidget {
  const ForbiddenPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const _RouteStatusPage(
      icon: Icons.block_outlined,
      title: AppStrings.forbiddenTitle,
      body: AppStrings.forbiddenBody,
      actionLabel: AppStrings.goHomeActionLabel,
    );
  }
}

class NotFoundPage extends StatelessWidget {
  const NotFoundPage({this.location, super.key});

  final String? location;

  @override
  Widget build(BuildContext context) {
    return _RouteStatusPage(
      icon: Icons.travel_explore_outlined,
      title: AppStrings.notFoundTitle,
      body: AppStrings.notFoundBody,
      detail: location,
      actionLabel: AppStrings.goHomeActionLabel,
    );
  }
}

class _RouteStatusPage extends StatelessWidget {
  const _RouteStatusPage({
    required this.icon,
    required this.title,
    required this.body,
    required this.actionLabel,
    this.detail,
  });

  final IconData icon;
  final String title;
  final String body;
  final String actionLabel;
  final String? detail;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TextTheme textTheme = theme.textTheme;
    final AppDesignTokens appTokens = theme.appTokens;
    final AppSpacingTokens spacing = theme.spacing;

    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.appTitle)),
      body: ResponsivePage(
        maxWidth: PageMaxWidth.authForm,
        centerVertically: true,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Icon(
              icon,
              size: appTokens.statusIconSize,
              color: theme.statusColors.info,
            ),
            SizedBox(height: spacing.md),
            Text(title, style: textTheme.headlineSmall),
            SizedBox(height: spacing.sm),
            Text(body, style: textTheme.bodyLarge),
            if (detail != null && detail!.isNotEmpty) ...<Widget>[
              SizedBox(height: spacing.sm),
              Text(detail!, style: textTheme.bodyMedium),
            ],
            SizedBox(height: spacing.lg),
            FilledButton(
              onPressed: () {
                context.go(AppRoutes.home.location());
              },
              child: Text(actionLabel),
            ),
          ],
        ),
      ),
    );
  }
}
