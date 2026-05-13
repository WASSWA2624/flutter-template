# Database Strategy

## Owning Scope

This file defines local database expectations, Drift usage, table organization, migrations, and local persistence rules.

Storage type selection is defined in [`storage_strategy.md`](./storage_strategy.md). Offline sync behavior is defined in [`offline_sync.md`](./offline_sync.md).

## Recommended Database

Use Drift for typed SQLite access in offline-capable apps.

Drift should be used for:

- Structured local records.
- Offline-first read models.
- Sync queue records.
- Cached API responses that need querying.
- Local drafts.

## Database Folder

```txt
core/storage/database/
  app_database.dart
  database_connection.dart
  database_migrations.dart
  tables/
```

Feature-specific tables may be grouped by feature when the app grows.

```txt
core/storage/database/tables/
  auth_tables.dart
  profile_tables.dart
  sync_tables.dart
```

## Drift Rules

- Keep table definitions clear and documented.
- Keep database access inside local data sources.
- Do not query the database from widgets.
- Use streams for offline-first UI updates.
- Keep migrations explicit.
- Test migrations when schema changes.

## Migration Rules

- Never delete production tables casually.
- Write migrations for schema changes.
- Keep migration versions documented.
- Test upgrade paths from old versions.
- Back up important local data before destructive migrations if possible.

## Local Data Source Pattern

```dart
abstract interface class UserLocalDataSource {
  Stream<List<UserDto>> watchUsers();
  Future<void> upsertUsers(List<UserDto> users);
  Future<void> clearUsers();
}
```

The repository decides how local and remote data are combined. The local data source only handles local persistence.

## Database Performance Rules

- Add indexes for frequently queried columns.
- Avoid loading large tables into memory.
- Use pagination for large local lists.
- Keep write batches efficient.
- Avoid blocking UI during heavy local operations.
- Clean expired cache records periodically.


## Schema Ownership Rules

- Each feature owns the tables that represent its domain data.
- Shared infrastructure owns cross-feature tables such as sync queue metadata.
- Migrations must be deterministic and tested.
- Do not delete user data during migrations unless the product explicitly requires it and the behavior is documented.
