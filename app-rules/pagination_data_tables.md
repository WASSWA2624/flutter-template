# Pagination and Data Table Strategy

## Owning Scope

This file defines pagination behavior and data table conventions.

Search and filtering are defined in [`search_filtering.md`](./search_filtering.md).

## Pagination Rules

Use pagination for large API responses and large local lists.

Pagination state should include:

```txt
page or cursor
page size
has more
is loading
is refreshing
current items
last error
```

## Pagination Types

| Type | Use Case |
|---|---|
| Page-based | Simple numbered pages |
| Cursor-based | Feeds and changing datasets |
| Offset-based | Simple backend lists, less ideal for changing data |
| Infinite scroll | Activity feeds and mobile lists |
| Manual load more | Good when user control is preferred |

## Pagination Behavior Rules

- Avoid loading large datasets all at once.
- Show loading indicators for next page loads.
- Preserve already loaded items during next page loading.
- Handle refresh separately from load-more.
- Handle duplicate records when using cursor-based APIs.
- Keep page size configurable where useful.

## Data Table Rules

Data tables should support:

- Horizontal scrolling or responsive column reduction.
- Sorting where needed.
- Filtering where needed.
- Pagination.
- Empty state.
- Loading state.
- Row actions.
- Keyboard and mouse interaction.

## Desktop Table Behavior

Desktop data tables should not become unreadable on narrow windows.

Options:

```txt
hide lower-priority columns
switch to card/list layout
allow horizontal scroll
use details page for secondary fields
```

## Mobile Table Behavior

On mobile, prefer cards or compact rows over dense desktop tables.


## Table Accessibility Rules

- Use readable headers.
- Preserve keyboard access for sorting, row actions, and pagination controls.
- Announce empty and loading states clearly.
- Avoid dense tables on small screens when a card layout is easier to read.
