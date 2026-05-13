import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_template/app/startup/app_preferences_restorer.dart';
import 'package:flutter_template/app/startup/app_startup_initializer.dart';
import 'package:flutter_template/app/startup/startup_providers.dart';
import 'package:flutter_template/core/config/app_config.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('AppStartupInitializer', () {
    setUp(() {
      SharedPreferences.setMockInitialValues(<String, Object>{});
      FlutterSecureStorage.setMockInitialValues(<String, String>{});
    });

    test('initializes dependencies and startup state', () async {
      SharedPreferences.setMockInitialValues(<String, Object>{
        AppPreferenceKeys.themeMode: 'dark',
        AppPreferenceKeys.locale: 'en',
      });

      final result = await const AppStartupInitializer().initialize(
        config: AppConfig.fromValues(
          environmentName: 'development',
          apiBaseUrl: 'http://localhost:8080',
        ),
      );

      expect(result.state.themeMode, ThemeMode.dark);
      expect(result.state.locale, const Locale('en'));
      expect(result.state.storageReadiness.isReady, isTrue);
      expect(result.state.sessionReadiness.isReady, isTrue);
      final container = result.createProviderContainer();
      addTearDown(container.dispose);

      expect(container.read(appStartupStateProvider), same(result.state));
    });
  });
}
