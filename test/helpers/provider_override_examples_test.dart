import 'package:flutter_template/core/errors/result.dart';
import 'package:flutter_template/features/home/data/repositories/home_repository_impl.dart';
import 'package:flutter_template/features/home/domain/entities/home_readiness_snapshot.dart';
import 'package:flutter_template/features/home/domain/repositories/home_repository.dart';
import 'package:flutter_template/features/home/presentation/controllers/home_controller.dart';
import 'package:flutter_test/flutter_test.dart';

import 'test_harness.dart';

void main() {
  group('provider override examples', () {
    test('builds a ready app container without production services', () {
      final container = createTestContainer(overrides: testReadyAppOverrides());

      expect(container.read(homeRepositoryProvider), isA<HomeRepositoryImpl>());
    });

    test('overrides a repository dependency for controller tests', () async {
      const snapshot = HomeReadinessSnapshot(
        providerGraphReady: true,
        dependenciesOverrideable: true,
        asyncStateReady: true,
      );
      final repository = _FakeHomeRepository(
        const Result<HomeReadinessSnapshot>.success(snapshot),
      );
      final container = createTestContainer(
        overrides: <Object?>[
          homeRepositoryProvider.overrideWithValue(repository),
        ],
      );

      final result = await container.read(homeControllerProvider.future);

      result.when(
        success: (value) => expect(value, same(snapshot)),
        failure: (_) => fail('Expected overridden repository success.'),
      );
      expect(repository.callCount, 1);
    });
  });
}

final class _FakeHomeRepository implements HomeRepository {
  _FakeHomeRepository(this.result);

  final Result<HomeReadinessSnapshot> result;
  int callCount = 0;

  @override
  Future<Result<HomeReadinessSnapshot>> loadReadiness() async {
    callCount += 1;

    return result;
  }
}
