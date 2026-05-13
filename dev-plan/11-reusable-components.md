# 11 - Reusable components

## Goal

Create a minimal, flexible component system that enforces consistency without replacing Flutter's Material widgets unnecessarily.

## Applies app rules

- [`reusable_components.md`](../app-rules/reusable_components.md)
- [`theming.md`](../app-rules/theming.md)
- [`responsive_adaptive_design.md`](../app-rules/responsive_adaptive_design.md)
- [`accessibility.md`](../app-rules/accessibility.md)
- [`forms.md`](../app-rules/forms.md)
- [`date_time_formatting.md`](../app-rules/date_time_formatting.md)
- [`localization_i18n.md`](../app-rules/localization_i18n.md)

## Component philosophy

Create wrappers only when they add real standards:

Good:

```txt
AppButton with variants, loading state, accessibility, and consistent styling
```

Avoid:

```txt
AppText that only renames Text without adding rules
```

## Folder structure

```txt
lib/core/widgets/
  buttons/
    app_button.dart
    app_icon_button.dart
    app_button_variant.dart
  forms/
    app_text_field.dart
    app_password_field.dart
    app_select_field.dart
    app_radio_group.dart
    app_checkbox.dart
    app_switch.dart
    app_date_picker.dart
    app_date_range_picker.dart
    app_search_field.dart
    app_form_section.dart
  layout/
    app_page.dart
    app_scaffold.dart
    responsive_layout.dart
    app_card.dart
    app_surface.dart
    app_split_view.dart
    app_grid.dart
  navigation/
    adaptive_navigation.dart
    app_bottom_navigation.dart
    app_navigation_rail.dart
    app_sidebar.dart
    app_breadcrumbs.dart
  feedback/
    app_snackbar.dart
    app_dialog.dart
    app_bottom_sheet.dart
    app_loading_indicator.dart
    app_skeleton.dart
    app_empty_state.dart
    app_error_state.dart
  data_display/
    app_badge.dart
    app_avatar.dart
    app_list_tile.dart
    app_status_chip.dart
    app_data_table.dart
    app_pagination.dart
```

Implement only the smallest useful version of each component first. Avoid complex variants until a real feature needs them.

## Required baseline components

| Component | Minimum behavior |
|---|---|
| `AppButton` | primary/secondary/outline/ghost/danger, loading, disabled |
| `AppIconButton` | semantic label required |
| `AppTextField` | label, hint, error, validator, keyboard config |
| `AppPasswordField` | visibility toggle, autofill hints |
| `AppSelectField<T>` | generic typed select |
| `AppRadioGroup<T>` | vertical/horizontal/responsive option layouts |
| `AppCheckbox` / `AppSwitch` | consistent labels and validation/error support where needed |
| `AppDatePicker` | one entry point for date picking |
| `AppSearchField` | debounce support |
| `AppPage` | safe area, padding, max width, loading/error/empty slots |
| `AdaptiveNavigation` | bottom navigation, rail, or sidebar by breakpoint |
| `AppDialog` / `AppSnackbar` | localized feedback helpers |
| `AppLoadingState` / `AppErrorState` / `AppEmptyState` | consistent async UI states |

## Component capabilities

Every reusable component should support:

- light and dark themes
- disabled state
- loading/error state where relevant
- focus and hover states where relevant
- keyboard access
- screen reader labels
- localization
- responsive spacing
- test keys
- consistent sizing

## Button rules

Example:

```dart
AppButton(
  label: l10n.save,
  variant: AppButtonVariant.primary,
  isLoading: state.isSaving,
  onPressed: state.canSave ? controller.save : null,
)
```

Rules:

- Use localized labels.
- Do not pass raw colors from pages.
- Use `onPressed: null` for disabled state.
- Use loading state for async actions.
- Prevent double-submit in forms.

## Feedback rules

Feature pages should not create raw snackbars/dialogs for normal cases:

```dart
AppSnackbar.showSuccess(context, l10n.profileSaved);
```

```dart
final confirmed = await AppDialog.confirm(
  context: context,
  title: l10n.deleteTitle,
  message: l10n.deleteMessage,
  confirmLabel: l10n.delete,
  cancelLabel: l10n.cancel,
);
```

Do not expose stack traces or raw backend errors to users.

## Documentation and tests

Each shared component should include:

- short documentation comment
- usage example in `docs/COMPONENTS.md`
- widget test for main states
- responsive test when layout changes by width
- accessibility test for labels/focus where practical

## Acceptance criteria

- Core components exist and use Material widgets internally.
- Components consume theme tokens.
- Components support localization and accessibility.
- Feature pages use shared components for normal forms/actions/feedback.
- No duplicate button/date picker/form systems exist.
