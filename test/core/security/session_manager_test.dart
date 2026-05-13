import 'package:flutter_template/core/security/session_manager.dart';
import 'package:flutter_template/core/security/session_readiness.dart';
import 'package:flutter_template/core/storage/secure/app_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('SessionManager', () {
    test('restores authenticated sessions when a token exists', () async {
      final storage = _MemorySecureStorage()
        ..values[SecureStorageKeys.accessToken] = ' access-token ';
      final manager = SessionManager(secureStorage: storage);

      final readiness = await manager.restore();

      expect(readiness.status, SessionStatus.authenticated);
      expect(await manager.readAccessToken(), 'access-token');
    });

    test(
      'clears sensitive session artifacts on unauthorized responses',
      () async {
        final storage = _MemorySecureStorage()
          ..values[SecureStorageKeys.accessToken] = 'access-token'
          ..values[SecureStorageKeys.refreshToken] = 'refresh-token';
        final manager = SessionManager(secureStorage: storage);

        await manager.handleUnauthorizedResponse();

        expect(storage.values, isEmpty);
      },
    );
  });
}

final class _MemorySecureStorage implements AppSecureStorage {
  final Map<String, String> values = <String, String>{};

  @override
  Future<void> delete(String key) async {
    values.remove(key);
  }

  @override
  Future<void> deleteAll() async {
    values.clear();
  }

  @override
  Future<String?> read(String key) async {
    return values[key];
  }

  @override
  Future<void> write({required String key, required String value}) async {
    values[key] = value;
  }
}
