import 'package:flutter/material.dart';
import 'package:flutter_template/core/security/session_readiness.dart';
import 'package:flutter_template/core/storage/storage_readiness.dart';

final class AppStartupState {
  const AppStartupState({
    required this.themeMode,
    required this.locale,
    required this.storageReadiness,
    required this.sessionReadiness,
  });

  const AppStartupState.defaults()
    : themeMode = ThemeMode.light,
      locale = null,
      storageReadiness = const StorageReadiness.notReady(),
      sessionReadiness = const SessionReadiness.notReady();

  final ThemeMode themeMode;
  final Locale? locale;
  final StorageReadiness storageReadiness;
  final SessionReadiness sessionReadiness;

  bool get isReady => storageReadiness.isReady && sessionReadiness.isReady;
}
