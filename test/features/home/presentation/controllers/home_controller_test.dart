import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/features/home/data/repositories/home_repository_impl.dart';
import 'package:flutter_template/features/home/domain/entities/home_readiness_snapshot.dart';
import 'package:flutter_template/features/home/domain/repositories/home_repository.dart';
import 'package:flutter_template/features/home/presentation/controllers/home_controller.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('HomeController', () {
    test('loads readiness through an overridden repository provider', () async {
      const snapshot = HomeReadinessSnapshot(
        providerGraphReady: true,
        dependenciesOverrideable: true,
        asyncStateReady: true,
      );
      final repository = _FakeHomeRepository(snapshot);
      final container = ProviderContainer(
        overrides: [homeRepositoryProvider.overrideWithValue(repository)],
      );
      addTearDown(container.dispose);

      final value = await container.read(homeControllerProvider.future);

      expect(value, same(snapshot));
      expect(repository.callCount, 1);
      expect(
        container.read(homeControllerProvider),
        isA<AsyncData<HomeReadinessSnapshot>>(),
      );
    });

    test('maps repository failures into AsyncError state', () async {
      final repository = _FailingHomeRepository(StateError('load failed'));
      final container = ProviderContainer(
        overrides: [homeRepositoryProvider.overrideWithValue(repository)],
      );
      addTearDown(container.dispose);

      await expectLater(
        container.read(homeControllerProvider.future),
        throwsStateError,
      );

      expect(container.read(homeControllerProvider).hasError, isTrue);
      expect(repository.callCount, 1);
    });
  });
}

final class _FakeHomeRepository implements HomeRepository {
  _FakeHomeRepository(this.snapshot);

  final HomeReadinessSnapshot snapshot;
  int callCount = 0;

  @override
  Future<HomeReadinessSnapshot> loadReadiness() async {
    callCount += 1;
    return snapshot;
  }
}

final class _FailingHomeRepository implements HomeRepository {
  _FailingHomeRepository(this.error);

  final Object error;
  int callCount = 0;

  @override
  Future<HomeReadinessSnapshot> loadReadiness() async {
    callCount += 1;
    throw error;
  }
}
