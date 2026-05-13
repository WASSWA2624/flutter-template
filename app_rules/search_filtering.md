# Search and Filtering Strategy

## Owning Scope

This file defines search and filtering behavior.

Pagination and data table behavior are defined in [`pagination_data_tables.md`](./pagination_data_tables.md). API request behavior is defined in [`network_api.md`](./network_api.md).

## Search Rules

- Debounce text input search.
- Cancel outdated search requests when possible.
- Keep search query in state.
- Show loading state for active searches.
- Show empty state for no results.
- Do not search on every keystroke without debounce.
- Persist search state only when the product needs it.

## Search Field

Use the shared `AppSearchField` from the component system.

It should support:

```txt
debounce
clear action
localized hint
keyboard submit
loading indicator when useful
```

## Filtering Rules

- Keep filters represented as typed state.
- Make active filters visible to the user.
- Allow clearing filters easily.
- Keep filter labels localized.
- Do not store sensitive filter values in URLs.
- Use URL query parameters only for safe, shareable filters.

## Search and Filter State Example

```dart
@freezed
class UserSearchState with _$UserSearchState {
  const factory UserSearchState({
    @Default('') String query,
    @Default(UserStatusFilter.all) UserStatusFilter status,
    @Default(false) bool isSearching,
  }) = _UserSearchState;
}
```

## Backend Coordination

Define whether search is:

```txt
local only
remote only
local first with remote refresh
```

Do not mix these strategies accidentally inside the UI.


## Search Request Rules

- Debounce text searches.
- Cancel stale requests when a newer query starts.
- Keep filters serializable when they should appear in the URL.
- Preserve filters when returning from a details page if the product expects continuity.
