# Offline and Sync Strategy

## Owning Scope

This file defines offline-capable behavior, repository strategies, read/write flows, sync queue fields, sync statuses, conflict strategies, and offline UI requirements.

Storage responsibilities are defined in [`storage_strategy.md`](./storage_strategy.md). Database rules are defined in [`database_strategy.md`](./database_strategy.md).

## Offline Goal

The app should be offline-capable where needed.

Not every feature must be offline-first, but the foundation must support offline-first features cleanly.

## Data Flow

```txt
UI
↓
Controller
↓
Use case
↓
Repository
↓
Local data source + Remote data source
```

The UI should not know whether data came from cache, database, or network.

## Repository Strategies

| Strategy | Behavior | Use Case |
|---|---|---|
| Cache first | Show local data first, refresh from network | Most read-heavy screens |
| Network first | Try API first, fallback to cache | Fresh data is important |
| Local only | Use only local data | Settings, drafts |
| Network only | Require live API | Sensitive transactions |
| Offline queue | Save action locally, sync later | Forms, create/update/delete actions |

## Offline-First Read Flow

```txt
Read local database
↓
Show cached data immediately
↓
Check network availability
↓
Fetch fresh data if online
↓
Save fresh data locally
↓
Update UI from local database stream
```

## Offline Write Flow

```txt
User submits action
↓
Validate locally
↓
Save optimistic local change
↓
Add sync task to queue
↓
If online, process queue
↓
If offline, wait
↓
When connection returns, sync
↓
Resolve conflict if needed
```

## Sync Queue Model

A sync task should include:

```txt
id
entityType
entityId
action
payload
status
retryCount
createdAt
updatedAt
idempotencyKey
lastError
```

## Sync Task Statuses

```txt
pending
processing
synced
failed
conflicted
cancelled
```

## Conflict Strategies

| Strategy | Meaning | Use Case |
|---|---|---|
| Server wins | Server version replaces local | Shared records where server is source of truth |
| Client wins | Local version overwrites server | User-owned drafts |
| Newest update wins | Latest timestamp wins | Low-risk records |
| Manual merge | User or admin resolves conflict | Important collaborative data |

Define conflict rules per feature. Do not use one global conflict strategy for all data.

## Offline UI Requirements

Offline-capable screens should communicate:

- Whether data is cached.
- Whether a change is pending sync.
- Whether sync failed.
- Whether there is a conflict.
- Whether the user can retry.

Use localized messages from [`localization_i18n.md`](./localization_i18n.md).

## Sync Rules

- Never assume connectivity means the API is reachable.
- Use idempotency keys for queued writes when supported.
- Keep retry counts and retry backoff.
- Do not keep retrying failed tasks forever.
- Keep conflict resolution explicit.
- Keep sync errors user-friendly.


## Offline Scope Rule

Not every feature should be offline-first. Choose the strategy per feature and document it in the feature README.

Examples:

| Feature Type | Typical Offline Strategy |
|---|---|
| Public reference data | Cache first |
| User drafts | Local first with sync queue |
| Payments or sensitive transactions | Network only |
| Settings | Local first, sync when needed |
