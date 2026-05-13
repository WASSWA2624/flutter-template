# 16 - Forms, validation, search, filtering, and data tables

## Goal

Standardize form UX, validation layers, search/filter state, pagination, and responsive data table behavior.

## Applies app rules

- [`forms.md`](../app-rules/forms.md)
- [`validation.md`](../app-rules/validation.md)
- [`search_filtering.md`](../app-rules/search_filtering.md)
- [`pagination_data_tables.md`](../app-rules/pagination_data_tables.md)
- [`reusable_components.md`](../app-rules/reusable_components.md)
- [`accessibility.md`](../app-rules/accessibility.md)
- [`network_api.md`](../app-rules/network_api.md)

## Form structure

Use shared form components from `core/widgets/forms/`.

Form pages should be composed like:

```txt
Page
↓
Feature form widget
↓
Shared input components
↓
Feature controller/state
↓
Use case/repository
```

## Form rules

- Labels are required for normal inputs.
- Validation messages are localized.
- Required fields must be clear.
- Async submit buttons show loading state.
- Double-submit must be prevented.
- Form fields should support keyboard navigation.
- Use autofill hints where relevant.
- Server validation errors must map back to fields where possible.

## Validation layers

| Validation type | Location |
|---|---|
| Required field UI feedback | Presentation/form field |
| Simple format check | Presentation or shared validator |
| Business rule | Domain value object or use case |
| API contract validation | Backend and data mapping |
| Authoritative validation | Backend |

Create:

```txt
lib/core/utils/validators.dart
lib/core/utils/input_formatters.dart
lib/core/errors/field_error.dart
```

## Server error mapping

Represent server field errors generically:

```dart
class FieldError {
  const FieldError({
    required this.field,
    required this.messageKey,
  });

  final String field;
  final String messageKey;
}
```

Map backend-specific field names inside the feature repository or mapper layer, not inside shared form widgets.

## Search and filtering

Create `AppSearchField` with debounce.

Search rules:

- Debounce text input.
- Cancel outdated requests when possible.
- Keep query/filter state in controller state.
- Show loading state for active searches.
- Show empty state for no results.
- Do not search on every keystroke without debounce.

Example state shape:

```dart
class SearchFilterState {
  const SearchFilterState({
    this.query = '',
    this.filters = const {},
    this.isSearching = false,
  });

  final String query;
  final Map<String, Object?> filters;
  final bool isSearching;
}
```

## Pagination and tables

Create:

```txt
lib/core/network/pagination.dart
lib/core/widgets/data_display/app_data_table.dart
lib/core/widgets/data_display/app_pagination.dart
```

Rules:

- Mobile tables may become cards/lists.
- Desktop tables should support horizontal overflow, sorting, and keyboard focus where useful.
- Pagination state belongs in feature state or repository query state.
- Use cursor pagination or page pagination based on backend contract.
- Data table headers and actions must be accessible.

## Acceptance criteria

- Shared form components are used by starter pages.
- Validation is layered correctly.
- Search input is debounced.
- Pagination models exist.
- Tables adapt for mobile and desktop.
- Error messages are localized and do not expose backend internals.
