import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw StateError('sharedPreferencesProvider must be overridden at startup.');
});

final secureStorageProvider = Provider<FlutterSecureStorage>((ref) {
  throw StateError('secureStorageProvider must be overridden at startup.');
});
