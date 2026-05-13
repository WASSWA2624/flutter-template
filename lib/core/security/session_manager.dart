import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/core/security/session_readiness.dart';
import 'package:flutter_template/core/storage/secure/app_secure_storage.dart';
import 'package:flutter_template/core/storage/storage_providers.dart';

final sessionManagerProvider = Provider<SessionManager>((ref) {
  return SessionManager(secureStorage: ref.watch(appSecureStorageProvider));
});

final class SessionManager {
  const SessionManager({required AppSecureStorage secureStorage})
    : _secureStorage = secureStorage;

  final AppSecureStorage _secureStorage;

  Future<SessionReadiness> restore() async {
    final accessToken = await readAccessToken();
    if (accessToken == null) {
      return const SessionReadiness.unauthenticated();
    }

    return const SessionReadiness.authenticated();
  }

  Future<String?> readAccessToken() async {
    final token = await _secureStorage.read(SecureStorageKeys.accessToken);
    final normalizedToken = token?.trim();

    if (normalizedToken == null || normalizedToken.isEmpty) {
      return null;
    }

    return normalizedToken;
  }

  Future<void> persistAccessToken(String accessToken) async {
    final normalizedToken = accessToken.trim();
    if (normalizedToken.isEmpty) {
      throw ArgumentError.value(
        accessToken,
        'accessToken',
        'Access token is required.',
      );
    }

    await _secureStorage.write(
      key: SecureStorageKeys.accessToken,
      value: normalizedToken,
    );
  }

  Future<void> clearSession() async {
    await _secureStorage.delete(SecureStorageKeys.accessToken);
    await _secureStorage.delete(SecureStorageKeys.refreshToken);
  }

  Future<void> handleUnauthorizedResponse() {
    return clearSession();
  }
}
