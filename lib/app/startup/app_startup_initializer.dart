import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_template/app/router/app_router.dart';
import 'package:flutter_template/app/startup/app_preferences_restorer.dart';
import 'package:flutter_template/app/startup/app_startup_state.dart';
import 'package:flutter_template/app/startup/startup_providers.dart';
import 'package:flutter_template/core/config/app_config.dart';
import 'package:flutter_template/core/config/app_config_provider.dart';
import 'package:flutter_template/core/logging/app_logger.dart';
import 'package:flutter_template/core/security/session_manager.dart';
import 'package:flutter_template/core/storage/storage_providers.dart';
import 'package:flutter_template/core/storage/storage_readiness.dart';
import 'package:shared_preferences/shared_preferences.dart';

final class AppStartupInitializer {
  const AppStartupInitializer({
    SessionManager sessionManager = const SessionManager(),
  }) : _sessionManager = sessionManager;

  final SessionManager _sessionManager;

  Future<AppStartupResult> initialize({AppConfig? config}) async {
    final appConfig = config ?? AppConfig.fromEnvironment();
    appConfig.validate();

    AppLogger.initialize(appConfig.logLevel);

    final preferences = await SharedPreferences.getInstance();
    const secureStorage = FlutterSecureStorage();
    const storageReadiness = StorageReadiness.ready();
    final sessionReadiness = await _sessionManager.restore();
    final startupState = AppStartupState(
      themeMode: AppPreferencesRestorer.restoreThemeMode(preferences),
      locale: AppPreferencesRestorer.restoreLocale(preferences),
      storageReadiness: storageReadiness,
      sessionReadiness: sessionReadiness,
    );

    return AppStartupResult(
      config: appConfig,
      preferences: preferences,
      secureStorage: secureStorage,
      state: startupState,
    );
  }
}

final class AppStartupResult {
  const AppStartupResult({
    required this.config,
    required this.preferences,
    required this.secureStorage,
    required this.state,
  });

  final AppConfig config;
  final SharedPreferences preferences;
  final FlutterSecureStorage secureStorage;
  final AppStartupState state;

  ProviderScope buildProviderScope({
    required Widget child,
    String? initialLocation,
  }) {
    return ProviderScope(
      overrides: [
        appConfigProvider.overrideWithValue(config),
        sharedPreferencesProvider.overrideWithValue(preferences),
        secureStorageProvider.overrideWithValue(secureStorage),
        appStartupStateProvider.overrideWithValue(state),
        if (initialLocation != null)
          appInitialLocationProvider.overrideWithValue(initialLocation),
      ],
      child: child,
    );
  }

  ProviderContainer createProviderContainer({String? initialLocation}) {
    return ProviderContainer(
      overrides: [
        appConfigProvider.overrideWithValue(config),
        sharedPreferencesProvider.overrideWithValue(preferences),
        secureStorageProvider.overrideWithValue(secureStorage),
        appStartupStateProvider.overrideWithValue(state),
        if (initialLocation != null)
          appInitialLocationProvider.overrideWithValue(initialLocation),
      ],
    );
  }
}
