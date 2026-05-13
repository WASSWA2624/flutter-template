import 'package:drift/native.dart';
import 'package:flutter_template/core/storage/database/app_database.dart';
import 'package:flutter_template/core/sync/sync_queue_entry.dart';
import 'package:flutter_template/core/sync/sync_queue_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('DriftSyncQueueService', () {
    late AppDatabase database;
    late DateTime now;
    late DriftSyncQueueService service;

    setUp(() {
      database = AppDatabase(NativeDatabase.memory());
      now = DateTime.utc(2026, 5, 13, 10);
      service = DriftSyncQueueService(database: database, clock: () => now);
    });

    tearDown(() async {
      await database.close();
    });

    test('enqueues pending writes in durable order', () async {
      await service.enqueue(
        SyncQueueEnqueueRequest(
          localId: ' local-1 ',
          operation: SyncQueueOperation.create,
          payload: SyncQueuePayload.fromMap(<String, Object?>{'id': 'local-1'}),
        ),
      );

      final batch = await service.nextBatch();

      expect(batch, hasLength(1));
      expect(batch.single.localId, 'local-1');
      expect(batch.single.operation, SyncQueueOperation.create);
      expect(batch.single.status, SyncQueueStatus.pending);
      expect(batch.single.payload.value, '{"id":"local-1"}');
    });

    test(
      'tracks failures and excludes synced entries from the next batch',
      () async {
        await service.enqueue(
          SyncQueueEnqueueRequest(
            localId: 'local-1',
            operation: SyncQueueOperation.update,
            payload: SyncQueuePayload.fromJsonString('{"id":"local-1"}'),
          ),
        );
        now = DateTime.utc(2026, 5, 13, 11);

        await service.markFailed('local-1', failureCode: 'network.offline');

        var batch = await service.nextBatch();
        expect(batch.single.status, SyncQueueStatus.failed);
        expect(batch.single.retryCount, 1);
        expect(batch.single.failureCode, 'network.offline');

        await service.markSynced('local-1');

        batch = await service.nextBatch();
        expect(batch, isEmpty);
      },
    );
  });
}
