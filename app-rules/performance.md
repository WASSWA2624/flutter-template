# Performance Strategy

## Owning Scope

This file defines widget performance, rebuild control, image performance, web performance, and desktop performance.

State management conventions are defined in [`state_management.md`](./state_management.md). Database performance is defined in [`database_strategy.md`](./database_strategy.md).

## Performance Principles

- Use `const` widgets whenever possible.
- Avoid unnecessary rebuilds.
- Split large widgets into smaller widgets.
- Use lazy lists for large data.
- Cache expensive calculations.
- Avoid heavy work on the UI thread.
- Compress images.
- Use pagination for large API responses.
- Use debouncing for search inputs.
- Avoid unnecessary animations.
- Dispose controllers correctly.

## Widget Performance

Bad:

```dart
ListView(
  children: items.map((item) => ItemTile(item)).toList(),
)
```

Good:

```dart
ListView.builder(
  itemCount: items.length,
  itemBuilder: (context, index) {
    return ItemTile(item: items[index]);
  },
)
```

## Rebuild Control

- Watch only the provider values needed by the widget.
- Use `select` for small pieces of state.
- Move expensive calculations outside `build`.
- Use memoization for derived values where useful.
- Avoid putting a whole app state object into one provider.

## Image Performance

Use:

```txt
Proper image sizes
Lazy loading
Caching when needed
SVG for simple icons
Compressed assets
Responsive image sizes
```

## Web Performance

- Keep initial load small.
- Avoid loading unnecessary assets at startup.
- Use route-based lazy loading where possible.
- Be careful with large images and fonts.
- Avoid heavy synchronous work during first render.
- Make deep links refresh-safe.

## Desktop Performance

- Avoid rebuilding large sidebars unnecessarily.
- Keep data tables virtualized or paginated.
- Avoid fixed giant layouts on extremely large displays.
- Handle window resizing smoothly.
- Use efficient local database queries.

## Performance Review Checklist

Before release, check:

- Main flows are smooth on low-end mobile.
- Large lists use builders or virtualization.
- Images are compressed and properly sized.
- Search input is debounced.
- API requests are paginated.
- Expensive providers are not refreshed unnecessarily.
- Release builds are tested, not only debug builds.


## Measurement Rules

- Measure performance in profile or release mode, not debug mode.
- Use Flutter DevTools for rebuild, memory, and frame analysis.
- Define performance budgets for startup, major lists, large forms, and dashboard screens.
- Do not optimize by guessing when measurement is practical.
