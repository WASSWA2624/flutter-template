# Asset and Branding Strategy

## Owning Scope

This file defines asset folders, asset rules, and asset registration.

Theme usage is defined in [`theming.md`](./theming.md).

## Asset Folders

```txt
assets/
  icons/
  images/
  illustrations/
  logos/
```

## Asset Rules

- Keep asset names lowercase with underscores.
- Compress images before adding them.
- Use SVG only when needed and supported by the selected packages.
- Keep logos in a dedicated folder.
- Avoid huge image files.
- Use platform-specific launcher icon tooling.
- Keep light and dark asset variants when required.
- Do not duplicate the same asset under multiple names.

## Asset Path Constants

Use constants instead of raw strings spread across widgets.

```dart
class AssetPaths {
  const AssetPaths._();

  static const logo = 'assets/logos/app_logo.png';
  static const emptyState = 'assets/illustrations/empty_state.png';
}
```

## `pubspec.yaml` Asset Registration

```yaml
flutter:
  assets:
    - assets/icons/
    - assets/images/
    - assets/illustrations/
    - assets/logos/
```

## Branding Rules

- Keep app name environment-aware when needed.
- Keep launcher icon setup documented.
- Keep splash screen setup documented.
- Ensure brand colors are represented through the theme system, not raw widget colors.


## Asset Quality Rules

- Use appropriately sized raster images for each context.
- Prefer vector assets for simple scalable icons and illustrations when supported.
- Keep asset paths centralized.
- Compress large images before committing them.
- Provide accessible labels for meaningful images in the UI.
