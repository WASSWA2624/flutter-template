# Validation Strategy

## Owning Scope

This file defines where validation belongs, how server validation errors map to fields, and validation rules.

Form UX is defined in [`forms.md`](./forms.md). Business value objects are defined in [`data_modeling.md`](./data_modeling.md).

## Validator Location

| Validation Type | Location |
|---|---|
| Required field UI feedback | Presentation/form field |
| Simple format check | Presentation or shared validator |
| Business rule | Domain value object or use case |
| API contract validation | Backend and data mapping |
| Authoritative validation | Backend |

## Validation Layers

Client validation improves UX. Backend validation protects the system.

Both are required.

```txt
UI validation
↓
Domain validation
↓
Backend validation
```

## Server Error Mapping

Server validation errors should be converted into field errors when possible.

Example server response:

```json
{
  "errors": {
    "email": "Email is already used",
    "password": "Password is too weak"
  }
}
```

Map this to:

```txt
email field error
password field error
```

Do not show all field-specific validation failures as one generic snackbar.

## Shared Validators

Shared validators belong in:

```txt
core/utils/validators.dart
```

Business-critical validators should be modeled as domain value objects when they carry meaning.

## Validation Rules

- Keep validation messages localized.
- Keep business validation out of widgets.
- Keep remote validation debounced.
- Avoid validating on every keystroke for expensive checks.
- Do not trust client validation only.
- Do not expose backend internal field names directly to users.
- Normalize values before validation when needed.

Example normalization:

```dart
final normalizedEmail = email.trim().toLowerCase();
```


## Validation Message Rules

- Validation messages must be localized.
- Field validation should be specific and helpful.
- Domain validation should be reusable and independent from widgets.
- Backend validation errors should be mapped to app-level failures before reaching the UI.
