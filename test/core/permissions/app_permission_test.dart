import 'package:flutter_template/core/permissions/app_permission.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AppPermissionGrant', () {
    const usersReadPermission = AppPermission('users.read');
    const reportsReadPermission = AppPermission('reports.read');

    test('centralizes all and any permission checks', () {
      final grant = AppPermissionGrant(<AppPermission>{usersReadPermission});

      expect(grant.grants(usersReadPermission), isTrue);
      expect(grant.grants(reportsReadPermission), isFalse);
      expect(grant.grantsAll(<AppPermission>{usersReadPermission}), isTrue);
      expect(
        grant.grantsAll(<AppPermission>{
          usersReadPermission,
          reportsReadPermission,
        }),
        isFalse,
      );
      expect(
        grant.grantsAny(<AppPermission>{
          usersReadPermission,
          reportsReadPermission,
        }),
        isTrue,
      );
    });
  });
}
