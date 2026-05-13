import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/app/startup/app_startup_state.dart';
import 'package:flutter_template/core/security/session_readiness.dart';
import 'package:flutter_template/core/storage/storage_readiness.dart';

final appStartupStateProvider = Provider<AppStartupState>((ref) {
  return const AppStartupState.defaults();
});

final appThemeModeProvider = Provider<ThemeMode>((ref) {
  return ref.watch(appStartupStateProvider.select((state) => state.themeMode));
});

final appLocaleProvider = Provider<Locale?>((ref) {
  return ref.watch(appStartupStateProvider.select((state) => state.locale));
});

final storageReadinessProvider = Provider<StorageReadiness>((ref) {
  return ref.watch(
    appStartupStateProvider.select((state) => state.storageReadiness),
  );
});

final sessionReadinessProvider = Provider<SessionReadiness>((ref) {
  return ref.watch(
    appStartupStateProvider.select((state) => state.sessionReadiness),
  );
});
