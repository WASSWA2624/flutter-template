import 'dart:developer' as developer;

import 'package:flutter/foundation.dart';
import 'package:flutter_template/core/config/app_config.dart';

abstract final class AppLogger {
  static AppLogLevel _minimumLevel = AppLogLevel.info;

  static void initialize(AppLogLevel minimumLevel) {
    _minimumLevel = minimumLevel;
  }

  static void debug(String message) {
    _log(AppLogLevel.debug, message);
  }

  static void info(String message) {
    _log(AppLogLevel.info, message);
  }

  static void warning(String message) {
    _log(AppLogLevel.warn, message);
  }

  static void error(String message, Object error, StackTrace stackTrace) {
    if (!_shouldLog(AppLogLevel.error)) {
      return;
    }

    developer.log(
      message,
      level: 1000,
      error: error,
      stackTrace: stackTrace,
      name: 'flutter_template',
    );

    FlutterError.reportError(
      FlutterErrorDetails(
        exception: error,
        stack: stackTrace,
        library: 'startup',
        context: ErrorDescription(message),
      ),
    );
  }

  static void _log(AppLogLevel level, String message) {
    if (!_shouldLog(level)) {
      return;
    }

    developer.log(
      message,
      level: _developerLevel(level),
      name: 'flutter_template',
    );
  }

  static bool _shouldLog(AppLogLevel level) {
    return _priority(level) >= _priority(_minimumLevel);
  }

  static int _priority(AppLogLevel level) {
    return switch (level) {
      AppLogLevel.debug => 0,
      AppLogLevel.info => 1,
      AppLogLevel.warn => 2,
      AppLogLevel.error => 3,
    };
  }

  static int _developerLevel(AppLogLevel level) {
    return switch (level) {
      AppLogLevel.debug => 500,
      AppLogLevel.info => 800,
      AppLogLevel.warn => 900,
      AppLogLevel.error => 1000,
    };
  }
}
