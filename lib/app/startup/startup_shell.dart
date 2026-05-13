import 'package:flutter/material.dart';
import 'package:flutter_template/app/theme/app_theme.dart';
import 'package:flutter_template/l10n/app_strings.dart';
import 'package:flutter_template/shared/layout/responsive_page.dart';
import 'package:flutter_template/shared/layout/responsive_spacing.dart';

class StartupLoadingApp extends StatelessWidget {
  const StartupLoadingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const _StartupShell(
      title: AppStrings.startupLoadingTitle,
      body: AppStrings.startupLoadingBody,
      action: CircularProgressIndicator(),
    );
  }
}

class StartupErrorApp extends StatelessWidget {
  const StartupErrorApp({required this.onRetry, super.key});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return _StartupShell(
      title: AppStrings.startupErrorTitle,
      body: AppStrings.startupErrorBody,
      action: FilledButton(
        onPressed: onRetry,
        child: const Text(AppStrings.retryActionLabel),
      ),
    );
  }
}

class _StartupShell extends StatelessWidget {
  const _StartupShell({
    required this.title,
    required this.body,
    required this.action,
  });

  final String title;
  final String body;
  final Widget action;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppStrings.appTitle,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute<void>(
          settings: settings,
          builder: (_) =>
              _StartupScaffold(title: title, body: body, action: action),
        );
      },
    );
  }
}

class _StartupScaffold extends StatelessWidget {
  const _StartupScaffold({
    required this.title,
    required this.body,
    required this.action,
  });

  final String title;
  final String body;
  final Widget action;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsivePage(
        maxWidth: PageMaxWidth.authForm,
        centerVertically: true,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(title, style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: AppSpacing.sm),
            Text(body, style: Theme.of(context).textTheme.bodyLarge),
            const SizedBox(height: AppSpacing.lg),
            action,
          ],
        ),
      ),
    );
  }
}
