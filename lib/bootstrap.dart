import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/app/app.dart';
import 'package:flutter_template/core/config/app_config.dart';
import 'package:flutter_template/core/config/app_config_provider.dart';

void bootstrap({AppConfig? config}) {
  WidgetsFlutterBinding.ensureInitialized();

  final appConfig = config ?? AppConfig.fromEnvironment();
  appConfig.validate();

  runApp(
    ProviderScope(
      overrides: [appConfigProvider.overrideWithValue(appConfig)],
      child: const TemplateApp(),
    ),
  );
}
