# 14 - Data modeling, storage, and offline sync readiness

## Goal

Create a clean data model strategy, local storage boundaries, and offline-capable scaffolding without forcing every app to be fully offline-first.

## Applies app rules

- [`data_modeling.md`](../app-rules/data_modeling.md)
- [`storage_strategy.md`](../app-rules/storage_strategy.md)
- [`database_strategy.md`](../app-rules/database_strategy.md)
- [`offline_sync.md`](../app-rules/offline_sync.md)
- [`repository_pattern_example.md`](../app-rules/repository_pattern_example.md)
- [`date_time_formatting.md`](../app-rules/date_time_formatting.md)
- [`security.md`](../app-rules/security.md)

## Model types

| Type | Layer | Purpose |
|---|---|---|
| Entity | Domain | Business object |
| Value object | Domain | Validated domain value |
| DTO | Data | API/database transfer object |
| Mapper | Data | Converts DTO/local model to domain |
| View model | Presentation | UI-specific display shape, only if useful |
| State model | Presentation/application | Controller state |

## Files to create

```txt
lib/core/storage/preferences/preferences_service.dart
lib/core/storage/cache/cache_policy.dart
lib/core/storage/cache/cache_service.dart
lib/core/storage/cache/cache_entry.dart
lib/core/storage/database/app_database.dart
lib/core/storage/database/database_connection.dart
lib/core/storage/database/database_migrations.dart
lib/core/storage/database/tables/
lib/core/sync/sync_queue.dart
lib/core/sync/sync_task.dart
lib/core/sync/sync_status.dart
lib/core/sync/sync_service.dart
lib/core/sync/conflict_strategy.dart
```

## Storage responsibilities

| Storage type | Use for | Do not use for |
|---|---|---|
| Secure storage | tokens, session secrets, sensitive values | large datasets, normal settings |
| Preferences | theme, locale, simple non-sensitive flags | tokens, private user data |
| Database | structured offline data, cached records, sync queue | unencrypted secrets |
| Cache service | temporary data with expiry policy | long-term source of truth |

## Drift database readiness

Create a basic database shell:

```dart
@DriftDatabase(tables: [])
class AppDatabase extends _$AppDatabase {
  AppDatabase(super.e);

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) => m.createAll(),
        onUpgrade: (m, from, to) async {
          // Add versioned migrations here.
        },
      );
}
```

Add feature tables only when features need structured local data.

## Offline-ready repository flow

For offline-capable features:

```txt
UI listens to repository-backed local state
↓
Repository reads/writes local database first
↓
Repository syncs with remote when available
↓
UI shows data state and sync state separately
```

## Sync queue model

Create generic scaffolding:

```txt
SyncTask
  id
  entityType
  entityId
  operation
  payload
  status
  retryCount
  createdAt
  updatedAt
  lastAttemptAt
```

Statuses:

```txt
pending
running
completed
failed
cancelled
conflict
```

Conflict strategies are feature-specific:

- server wins
- client wins
- merge
- manual review

Do not apply one global conflict strategy to all data.

## Web offline boundary

The template should be offline-ready, not automatically full PWA/offline-web capable. If a product needs web offline behavior, implement a deliberate service-worker/PWA strategy in that product.

## Acceptance criteria

- Storage responsibilities are clear and enforced.
- Preferences and secure storage wrappers exist.
- Drift database shell exists if offline/database is enabled.
- Sync scaffolding exists without forcing a backend contract.
- Domain entities, DTOs, and mappers are separate.
- Sensitive values are not stored in preferences or normal database tables.
