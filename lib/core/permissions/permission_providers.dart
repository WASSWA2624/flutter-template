import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/core/permissions/app_permission.dart';

final grantedAppPermissionsProvider = Provider<Set<AppPermission>>((ref) {
  return const <AppPermission>{};
});
