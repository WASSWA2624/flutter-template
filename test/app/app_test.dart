import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/app/app.dart';
import 'package:flutter_template/app/startup/app_startup_state.dart';
import 'package:flutter_template/app/startup/startup_providers.dart';
import 'package:flutter_template/core/security/session_readiness.dart';
import 'package:flutter_template/core/storage/storage_readiness.dart';
import 'package:flutter_template/l10n/app_strings.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('renders the minimal template shell', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const ProviderScope(child: TemplateApp()));

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

    final materialApp = tester.widget<MaterialApp>(find.byType(MaterialApp));

    expect(materialApp.themeMode, ThemeMode.dark);
    expect(materialApp.locale, AppStrings.defaultLocale);
  });
}
