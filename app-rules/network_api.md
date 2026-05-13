# Network and API Strategy

## Owning Scope

This file defines the API client, Dio wrapper, interceptors, app result usage for network calls, network error mapping, and API rules.

Auth refresh rules are defined in [`authentication_session.md`](./authentication_session.md). App-wide result and error display rules are defined in [`error_handling.md`](./error_handling.md).

## API Client

Use one `ApiClient` wrapper around Dio.

```txt
core/network/api_client.dart
```

The app should not use Dio directly in feature repositories unless the repository receives it through a data source abstraction.

## API Client Responsibilities

- Base URL configuration.
- Timeouts.
- Common headers.
- Auth headers.
- Locale headers.
- Request cancellation.
- Error mapping.
- Response parsing.
- Sanitized logging.
- Token refresh coordination.
- Retry logic where safe.

## Recommended Interceptors

| Interceptor | Purpose |
|---|---|
| Auth interceptor | Adds access token |
| Refresh interceptor | Handles expired token cases |
| Locale interceptor | Adds locale header if backend supports it |
| Logging interceptor | Logs safe request info in non-production |
| Error interceptor | Converts low-level errors |
| Retry interceptor | Retries safe transient failures only |

## Result Handling

Use the app-wide `AppResult<T>` from [`error_handling.md`](./error_handling.md) instead of throwing raw exceptions through repositories, use cases, or controllers. Network-specific code may have private helper types internally, but public app-facing APIs should return `AppResult<T>` or typed domain values.

## Network Error Mapping

| Low-Level Error | App Failure |
|---|---|
| Timeout | `NetworkFailure.timeout` |
| No connection | `NetworkFailure.offline` |
| 401 | `AuthFailure.unauthenticated` |
| 403 | `AuthFailure.forbidden` |
| 404 | `NetworkFailure.notFound` |
| 422 | `ValidationFailure` |
| 500 | `NetworkFailure.server` |
| Unknown | `AppFailure.unknown` |

## API Rules

- Always configure timeouts.
- Do not let raw Dio exceptions reach the UI.
- Do not parse JSON in widgets.
- Do not expose DTOs to UI unless intentionally designed.
- Use cancellation for search and rapidly changing requests.
- Use pagination for large datasets.
- Use idempotency keys for offline sync writes where supported.

Search conventions are defined in [`search_filtering.md`](./search_filtering.md). Pagination conventions are defined in [`pagination_data_tables.md`](./pagination_data_tables.md).


## Request Lifecycle Rules

- Configure connect, send, and receive timeouts.
- Cancel stale search or autocomplete requests.
- Retry only safe idempotent requests unless the backend supports idempotency keys.
- Keep upload/download progress state out of generic API helpers unless it is part of the API contract.
