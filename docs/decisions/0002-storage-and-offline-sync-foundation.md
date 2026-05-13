# ADR 0002: Storage and Offline Sync Foundation

## Status

Accepted

## Context

The template needs reusable local persistence boundaries without assuming a
product API, authentication flow, or conflict policy.

Rule sources:

- `app-rules/data_modeling.md`
- `app-rules/database_strategy.md`
- `app-rules/storage_strategy.md`
- `app-rules/offline_sync.md`

## Decision

Use Drift for structured local records and sync queue storage. Keep the database
under `lib/core/storage/database`, with table definitions in `tables/` and
schema changes routed through `migrations/`.

Use `shared_preferences` only through `AppPreferencesStore` for small
non-sensitive preferences. Use `flutter_secure_storage` only through
`AppSecureStorage` for tokens and sensitive session artifacts where the platform
supports secure storage.

Represent pending writes with a generic sync queue entry. The queue stores a
stable local id, operation type, serialized JSON payload, sync status, retry
count, timestamps, and optional failure code. Connectivity remains a hint only;
actual sync workers must treat network calls as fallible and idempotent.

The starter conflict boundary is explicit: the core queue can mark entries as
`conflict`, but product features must define the merge, overwrite, retry, or
manual resolution behavior before release.

## Consequences

- Widgets and controllers do not import Drift tables or generated database row
  classes.
- Feature data sources map generated Drift rows into domain entities before
  data reaches repositories or presentation.
- Schema version `1` has a deterministic create path. Future schema changes
  must add explicit upgrade paths before incrementing the version.
- Offline-capable features can add local data sources and enqueue pending writes
  without changing app-wide storage choices.
