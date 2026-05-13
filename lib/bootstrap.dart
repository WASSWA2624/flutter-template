import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_template/app/app.dart';
import 'package:flutter_template/app/startup/app_startup_initializer.dart';
import 'package:flutter_template/app/startup/startup_shell.dart';
import 'package:flutter_template/core/config/app_config.dart';
import 'package:flutter_template/core/logging/app_logger.dart';

Future<void> bootstrap({
  AppConfig? config,
  AppStartupInitializer startupInitializer = const AppStartupInitializer(),
}) async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const StartupLoadingApp());

  try {
    final startupResult = await startupInitializer.initialize(config: config);

    runApp(startupResult.buildProviderScope(child: const TemplateApp()));
  } catch (error, stackTrace) {
    AppLogger.error('Startup failed.', error, stackTrace);

    runApp(
      StartupErrorApp(
        onRetry: () {
          unawaited(
            bootstrap(config: config, startupInitializer: startupInitializer),
          );
        },
      ),
    );
  }
}
