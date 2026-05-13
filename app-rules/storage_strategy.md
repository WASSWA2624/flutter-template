# Local Storage Strategy

## Owning Scope

This file defines storage layers and when to use each storage type.

Database structure and migration rules are owned by [`database_strategy.md`](./database_strategy.md). Auth token lifecycle is owned by [`authentication_session.md`](./authentication_session.md).

## Storage Layers

| Storage Type | Use For | Do Not Use For |
|---|---|---|
| Secure storage | Tokens, session secrets, sensitive values | Large datasets, normal settings |
| Preferences | Theme, locale, non-sensitive flags | Tokens, private user data |
| Database | Structured offline data, cached records, sync queue | Secrets without encryption strategy |
| Cache service | Temporary data with expiry policy | Long-term source of truth |

## Secure Storage

Use secure storage for sensitive values.

Examples:

```txt
access token
refresh token
session id
private auth metadata
```

Use one wrapper service instead of calling package APIs directly from features.

## Preferences

Use preferences for non-sensitive app settings.

Examples:

```txt
theme mode
locale
last selected tab
non-sensitive feature preferences
```

## Cache Policy

Every cache should define:

- Cache key.
- Data type.
- Expiry time.
- Refresh behavior.
- Invalidating event.
- Whether stale data may be shown.

## Data Expiry

Choose expiry based on data type.

| Data Type | Typical Expiry |
|---|---|
| User profile | Refresh on login/startup |
| App settings | Until changed |
| Reference data | Hours or days |
| Dashboard data | Minutes |
| Search results | Short-lived |

## Storage Rules

- Do not store secrets in `shared_preferences`.
- Do not store large structured data in preferences.
- Do not expose storage packages directly to feature code.
- Do not keep sensitive cached data after logout unless the product explicitly requires it and security has approved it.
- Keep storage keys centralized.
- Document retention behavior for sensitive features.


## Web Storage Boundary

Browser storage is easier for users or scripts to inspect than native secure storage. For web authentication, prefer backend-managed secure cookies when the backend supports them. Avoid long-lived browser tokens.
