import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/features/home/data/repositories/home_repository_impl.dart';
import 'package:flutter_template/features/home/domain/entities/home_readiness_snapshot.dart';

final homeControllerProvider =
    AsyncNotifierProvider<HomeController, HomeReadinessSnapshot>(
      HomeController.new,
    );

final class HomeController extends AsyncNotifier<HomeReadinessSnapshot> {
  @override
  Future<HomeReadinessSnapshot> build() {
    return ref.watch(homeRepositoryProvider).loadReadiness();
  }

  Future<void> refresh() async {
    state = const AsyncLoading<HomeReadinessSnapshot>();
    state = await AsyncValue.guard(() {
      return ref.read(homeRepositoryProvider).loadReadiness();
    });
  }
}
