import 'package:flutter/material.dart';
import 'package:flutter_template/app/theme/app_theme.dart';
import 'package:flutter_template/app/theme/app_theme_extensions.dart';
import 'package:flutter_template/l10n/app_strings.dart';
import 'package:flutter_template/shared/layout/responsive_page.dart';

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
      themeMode: ThemeMode.light,
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
    final ThemeData theme = Theme.of(context);
    final AppSpacingTokens spacing = theme.spacing;

    return Scaffold(
      body: ResponsivePage(
        maxWidth: PageMaxWidth.authForm,
        centerVertically: true,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(title, style: theme.textTheme.headlineSmall),
            SizedBox(height: spacing.sm),
            Text(body, style: theme.textTheme.bodyLarge),
            SizedBox(height: spacing.lg),
            action,
          ],
        ),
      ),
    );
  }
}
