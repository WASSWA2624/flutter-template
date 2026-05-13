import 'package:flutter/material.dart';
import 'package:flutter_template/app/theme/app_theme.dart';
import 'package:flutter_template/app/theme/app_theme_extensions.dart';
import 'package:flutter_template/l10n/app_localizations.dart';
import 'package:flutter_template/l10n/app_localizations_x.dart';
import 'package:flutter_template/shared/layout/responsive_page.dart';

typedef _StartupContentBuilder =
    Widget Function(BuildContext context, AppLocalizations l10n);

class StartupLoadingApp extends StatelessWidget {
  const StartupLoadingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return _StartupShell(
      builder: (BuildContext context, AppLocalizations l10n) {
        return _StartupScaffold(
          title: l10n.startupLoadingTitle,
          body: l10n.startupLoadingBody,
          action: const CircularProgressIndicator(),
        );
      },
    );
  }
}

class StartupErrorApp extends StatelessWidget {
  const StartupErrorApp({required this.onRetry, super.key});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return _StartupShell(
      builder: (BuildContext context, AppLocalizations l10n) {
        return _StartupScaffold(
          title: l10n.startupErrorTitle,
          body: l10n.startupErrorBody,
          action: FilledButton(
            onPressed: onRetry,
            child: Text(l10n.commonRetryActionLabel),
          ),
        );
      },
    );
  }
}

class _StartupShell extends StatelessWidget {
  const _StartupShell({required this.builder});

  final _StartupContentBuilder builder;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateTitle: (BuildContext context) => context.l10n.appTitle,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.light,
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute<void>(
          settings: settings,
          builder: (BuildContext context) {
            return builder(context, context.l10n);
          },
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
