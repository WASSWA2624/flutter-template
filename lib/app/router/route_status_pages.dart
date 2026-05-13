import 'package:flutter/material.dart';
import 'package:flutter_template/app/router/app_routes.dart';
import 'package:flutter_template/l10n/app_strings.dart';
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
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.appTitle)),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 560),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Icon(
                    icon,
                    size: 40,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(height: 20),
                  Text(title, style: textTheme.headlineSmall),
                  const SizedBox(height: 12),
                  Text(body, style: textTheme.bodyLarge),
                  if (detail != null && detail!.isNotEmpty) ...<Widget>[
                    const SizedBox(height: 12),
                    Text(detail!, style: textTheme.bodyMedium),
                  ],
                  const SizedBox(height: 24),
                  FilledButton(
                    onPressed: () {
                      context.go(AppRoutes.home.location());
                    },
                    child: Text(actionLabel),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
