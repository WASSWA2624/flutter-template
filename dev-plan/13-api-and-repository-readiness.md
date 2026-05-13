# 13 - API and repository readiness

## Goal

Prepare backend integration without tying the template to a specific backend. The backend is assumed to be separate and already developed.

## Applies app rules

- [`network_api.md`](../app-rules/network_api.md)
- [`repository_pattern_example.md`](../app-rules/repository_pattern_example.md)
- [`architecture.md`](../app-rules/architecture.md)
- [`data_modeling.md`](../app-rules/data_modeling.md)
- [`error_handling.md`](../app-rules/error_handling.md)
- [`security.md`](../app-rules/security.md)
- [`pagination_data_tables.md`](../app-rules/pagination_data_tables.md)

## Files to create

```txt
lib/core/network/api_client.dart
lib/core/network/api_interceptors.dart
lib/core/network/api_headers.dart
lib/core/network/api_error_mapper.dart
lib/core/network/network_info.dart
lib/core/network/pagination.dart
lib/core/errors/app_result.dart
lib/core/errors/app_failure.dart
lib/core/errors/app_exception.dart
lib/core/errors/error_mapper.dart
```

Feature-specific API code belongs in:

```txt
lib/features/<feature>/data/datasources/remote/
lib/features/<feature>/data/dto/
lib/features/<feature>/data/mappers/
lib/features/<feature>/data/repositories/
lib/features/<feature>/domain/repositories/
```

## API client responsibilities

The shared API client wrapper should handle:

- base URL from `AppConfig`
- default headers
- request timeouts
- response parsing boundaries
- cancellation tokens where needed
- retry policy only when safe
- error mapping to app failures
- auth token attachment through an auth/session abstraction
- logging sanitized request metadata, not secrets

## Dio setup

Create a factory:

```dart
class ApiClientFactory {
  const ApiClientFactory._();

  static Dio create(AppConfig config) {
    final dio = Dio(
      BaseOptions(
        baseUrl: config.apiBaseUrl.toString(),
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 20),
        sendTimeout: const Duration(seconds: 20),
      ),
    );

    dio.interceptors.addAll([
      RequestIdInterceptor(),
      AuthHeaderInterceptor(),
      SanitizedLoggingInterceptor(),
    ]);

    return dio;
  }
}
```

Keep real token access behind an interface; do not directly reach into secure storage from an interceptor without a token/session abstraction.

## Result handling

Use a reusable result type so repositories do not throw raw network exceptions into UI state:

```dart
sealed class AppResult<T> {
  const AppResult();
}

final class AppSuccess<T> extends AppResult<T> {
  const AppSuccess(this.value);
  final T value;
}

final class AppError<T> extends AppResult<T> {
  const AppError(this.failure);
  final AppFailure failure;
}
```

The exact implementation may use `freezed`, but keep the concept consistent.

## Repository pattern

Domain contract:

```dart
abstract interface class UserRepository {
  Future<AppResult<AppUser>> getCurrentUser();
}
```

Data implementation:

```dart
class UserRepositoryImpl implements UserRepository {
  const UserRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  final UserRemoteDataSource remoteDataSource;
  final UserLocalDataSource localDataSource;

  @override
  Future<AppResult<AppUser>> getCurrentUser() async {
    try {
      final dto = await remoteDataSource.getCurrentUser();
      final user = dto.toDomain();
      await localDataSource.saveUser(user);
      return AppSuccess(user);
    } on Object catch (error, stackTrace) {
      return AppError(ApiErrorMapper.map(error, stackTrace));
    }
  }
}
```

## Pagination readiness

Create generic pagination models:

```txt
PaginationRequest
PaginationMeta
PagedResult<T>
```

Support cursor and page-number strategies, but do not force one backend style.

## Rules

- Do not add backend-specific SDKs to the foundation.
- Do not hard-code API paths in UI.
- Data sources call APIs; repositories coordinate results.
- DTOs are not domain entities.
- Connectivity is only a signal, not proof of internet access.
- Network failures, DNS failures, captive portals, and backend errors must be handled.

## Acceptance criteria

- API client is configured but backend-agnostic.
- Repositories are contract-based and testable.
- Network errors map to app failures.
- Pagination types exist.
- No widget imports Dio, DTOs, or remote data sources directly.
