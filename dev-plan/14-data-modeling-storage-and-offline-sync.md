# 14 - Data modeling, storage, and offline sync

## Goal
Add model, Drift database, local storage, and offline sync foundations.

## Applies app rules
- [`data_modeling.md`](../app-rules/data_modeling.md)
- [`database_strategy.md`](../app-rules/database_strategy.md)
- [`storage_strategy.md`](../app-rules/storage_strategy.md)
- [`offline_sync.md`](../app-rules/offline_sync.md)

## Implementation tasks
1. Create model and mapper examples.
2. Create Drift database shell and migration structure.
3. Create preference and secure storage abstractions.
4. Create sync queue model/service placeholders.
5. Document offline-capable behavior and conflict boundaries.

## Expected output
- Database shell.
- Storage abstractions.
- Sync queue foundation.

## Acceptance criteria
- Widgets do not import database classes.
- Migrations are explicit.
- Sensitive data uses secure storage where supported.

## Coding-agent notes
- Do not skip rule references.
- Do not add product-specific behavior unless the step explicitly asks for it.
