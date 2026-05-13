import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/app/app.dart';
import 'package:flutter_template/app/router/app_router.dart';
import 'package:flutter_template/app/startup/app_startup_state.dart';
import 'package:flutter_template/app/startup/startup_providers.dart';
import 'package:flutter_template/core/security/session_readiness.dart';
import 'package:flutter_template/core/storage/storage_readiness.dart';
import 'package:flutter_template/features/home/presentation/pages/home_page.dart';
import 'package:flutter_template/l10n/app_strings.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

void main() {
  testWidgets('renders the minimal template shell', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const ProviderScope(child: TemplateApp()));
    await tester.pumpAndSettle();

    expect(find.text(AppStrings.appTitle), findsOneWidget);
    expect(find.text(AppStrings.readyTitle), findsOneWidget);

    for (final String platform in AppStrings.supportedPlatforms) {
      expect(find.text(platform), findsOneWidget);
    }
  });

  testWidgets('uses startup theme and locale providers', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          appStartupStateProvider.overrideWithValue(
            const AppStartupState(
              themeMode: ThemeMode.dark,
              locale: AppStrings.defaultLocale,
              storageReadiness: StorageReadiness.ready(),
              sessionReadiness: SessionReadiness.ready(),
            ),
          ),
        ],
        child: const TemplateApp(),
      ),
    );
    await tester.pumpAndSettle();

    final materialApp = tester.widget<MaterialApp>(find.byType(MaterialApp));

    expect(materialApp.themeMode, ThemeMode.dark);
    expect(materialApp.locale, AppStrings.defaultLocale);
  });

  testWidgets('shows localized not-found UI for unknown routes', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const ProviderScope(child: TemplateApp()));
    await tester.pumpAndSettle();

    GoRouter.of(tester.element(find.byType(HomePage))).go('/missing-route');
    await tester.pumpAndSettle();

    expect(find.text(AppStrings.notFoundTitle), findsOneWidget);
    expect(find.text(AppStrings.notFoundBody), findsOneWidget);
    expect(find.text('/missing-route'), findsOneWidget);
  });

  testWidgets('restores unknown initial locations to not-found UI', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          appInitialLocationProvider.overrideWithValue('/missing-route'),
        ],
        child: const TemplateApp(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text(AppStrings.notFoundTitle), findsOneWidget);
    expect(find.text('/missing-route'), findsOneWidget);
  });
}
