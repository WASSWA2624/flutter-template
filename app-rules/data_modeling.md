# Data Modeling Strategy

## Owning Scope

This file defines entities, value objects, DTOs, state models, view models, and mapper rules.

Repository implementation examples are defined in [`repository_pattern_example.md`](./repository_pattern_example.md).

## Model Types

Use different model types for different responsibilities.

| Type | Layer | Purpose |
|---|---|---|
| Entity | Domain | Business object |
| Value object | Domain | Validated value, such as email |
| DTO | Data | API/database transfer object |
| View model | Presentation | UI-specific display model if needed |
| State model | Presentation/Application | Controller state |

## Entity Example

```dart
class AppUser {
  const AppUser({
    required this.id,
    required this.email,
    required this.displayName,
  });

  final String id;
  final String email;
  final String displayName;
}
```

## DTO Example

```dart
@JsonSerializable()
class UserDto {
  const UserDto({
    required this.id,
    required this.email,
    required this.displayName,
  });

  factory UserDto.fromJson(Map<String, dynamic> json) => _$UserDtoFromJson(json);

  final String id;
  final String email;
  final String displayName;

  Map<String, dynamic> toJson() => _$UserDtoToJson(this);
}
```

## Mapper Example

```dart
extension UserDtoMapper on UserDto {
  AppUser toEntity() {
    return AppUser(
      id: id,
      email: email,
      displayName: displayName,
    );
  }
}
```

## Value Object Example

```dart
class EmailAddress {
  const EmailAddress._(this.value);

  final String value;

  static Either<AuthFailure, EmailAddress> create(String input) {
    final normalized = input.trim().toLowerCase();
    final isValid = RegExp(r'^[^@]+@[^@]+\.[^@]+$').hasMatch(normalized);

    if (!isValid) {
      return left(AuthFailure.invalidEmail());
    }

    return right(EmailAddress._(normalized));
  }
}
```

## Data Modeling Rules

- Do not pass API DTOs into domain logic.
- Do not make UI depend on raw JSON.
- Keep mappers explicit.
- Keep generated serialization code out of widgets.
- Use immutable models for state.
- Prefer value objects for important business values.
- Keep DTOs shaped around external contracts.
- Keep entities shaped around business meaning.
- Do not make database table classes act as UI state.


## Immutability Rules

- Prefer immutable entities and state models.
- Use explicit mappers between DTOs and entities.
- Avoid optional fields in domain entities unless the business concept is genuinely optional.
- Keep presentation-only formatting out of domain entities.
