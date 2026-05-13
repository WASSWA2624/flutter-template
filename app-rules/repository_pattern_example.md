# Example Repository Pattern

## Owning Scope

This file gives a concrete repository contract and implementation example.

Architecture rules are defined in [`architecture.md`](./architecture.md). Offline strategies are defined in [`offline_sync.md`](./offline_sync.md). Network rules are defined in [`network_api.md`](./network_api.md).

## Repository Contract

The contract belongs in the domain layer.

```dart
abstract interface class UserRepository {
  Stream<List<AppUser>> watchUsers();
  Future<AppResult<void>> refreshUsers();
}
```

The domain layer should not know whether users come from an API, database, cache, or test fake.

## Repository Implementation

The implementation belongs in the data layer.

```dart
class UserRepositoryImpl implements UserRepository {
  const UserRepositoryImpl({
    required UserRemoteDataSource remoteDataSource,
    required UserLocalDataSource localDataSource,
    required NetworkInfo networkInfo,
  })  : _remoteDataSource = remoteDataSource,
        _localDataSource = localDataSource,
        _networkInfo = networkInfo;

  final UserRemoteDataSource _remoteDataSource;
  final UserLocalDataSource _localDataSource;
  final NetworkInfo _networkInfo;

  @override
  Stream<List<AppUser>> watchUsers() {
    return _localDataSource.watchUsers().map(
          (dtos) => dtos.map((dto) => dto.toEntity()).toList(),
        );
  }

  @override
  Future<AppResult<void>> refreshUsers() async {
    final isOnline = await _networkInfo.isOnline();

    if (!isOnline) {
      return const AppResult.failure(NetworkFailure.offline());
    }

    final result = await _remoteDataSource.fetchUsers();

    return result.when(
      success: (dtos) async {
        await _localDataSource.upsertUsers(dtos);
        return const AppResult.success(null);
      },
      failure: AppResult.failure,
    );
  }
}
```

## Repository Rules

- Keep repository contracts in domain.
- Keep repository implementations in data.
- Return app-level results or failures, not raw exceptions.
- Map DTOs to entities before exposing them to domain/application layers.
- Keep offline strategy inside repository or use case, not UI.
- Do not show snackbars or dialogs from repositories.
- Do not navigate from repositories.

## Testing Rule

Repository implementations should be tested with fake remote/local data sources.


## Repository Ownership Rule

A repository coordinates data sources for one domain concept. It should not contain widget logic, localized messages, or route decisions.
