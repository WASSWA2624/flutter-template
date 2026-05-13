# Reusable Component System

## Owning Scope

This file defines shared UI component conventions.

Theme tokens are defined in [`theming.md`](./theming.md). Responsive behavior is defined in [`responsive_adaptive_design.md`](./responsive_adaptive_design.md). User-facing text rules are defined in [`localization_i18n.md`](./localization_i18n.md). Accessibility rules are defined in [`accessibility.md`](./accessibility.md).

## Component Philosophy

Create reusable components when they enforce consistency.

Do not create custom components just to rename Flutter widgets.

Good custom component:

```txt
AppButton with variants, loading state, accessibility, and consistent styling
```

Unnecessary custom component:

```txt
AppText that only wraps Text without adding meaningful standards
```

## Component Folder Structure

```txt
core/widgets/
  buttons/
    app_button.dart
    app_icon_button.dart
    app_text_button.dart
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

## Required Component Capabilities

Every reusable component should support:

- Light theme.
- Dark theme.
- Disabled state.
- Loading state where needed.
- Error state where needed.
- Focus state.
- Hover state where relevant.
- Keyboard access.
- Screen reader labels.
- Localization.
- Responsive spacing.
- Test keys.
- Consistent sizing.

## Button System

Use one standard button system.

Variants:

```txt
primary
secondary
outline
ghost
danger
```

Sizes:

```txt
small
medium
large
```

States:

```txt
default
hovered
focused
pressed
loading
disabled
```

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
- Do not pass raw colors to buttons from pages.
- Use `onPressed: null` for disabled state.
- Use loading state for async actions.
- Prevent double-submit on forms.

## Input System

All input components should use the same visual and validation rules.

Common props:

```dart
label
hint
value
errorText
enabled
readOnly
required
onChanged
onSubmitted
validator
keyboardType
textInputAction
autofillHints
semanticLabel
```

Input components:

| Component | Purpose |
|---|---|
| `AppTextField` | General text input |
| `AppPasswordField` | Password input with visibility toggle |
| `AppSelectField` | Single select dropdown/menu |
| `AppRadioGroup` | Small fixed option groups |
| `AppCheckbox` | Boolean selection |
| `AppSwitch` | Immediate on/off setting |
| `AppDatePicker` | Single date selection |
| `AppDateRangePicker` | Date range selection |
| `AppSearchField` | Search with debounce |

## Select Field Strategy

Use built-in Material components where possible.

Recommended behavior:

| Screen Type | Select Behavior |
|---|---|
| Mobile | Bottom sheet if many options, dropdown if few |
| Tablet | Dialog or menu |
| Desktop | Menu or popover |
| Web | Menu or searchable command-style list |

Use one generic component:

```dart
AppSelectField<T>
```

Do not create a different select component for every feature.

## Radio Group Strategy

Use radio groups for small option sets.

Supported layouts:

```txt
vertical
horizontal
responsive
```

Rules:

- Option labels must be localized.
- Disabled options must show disabled style.
- Validation errors must appear consistently.
- Keyboard navigation must work.

## Date Picker Strategy

Use a single `AppDatePicker` entry point.

Bad:

```dart
showDatePicker(...)
```

Good:

```dart
final selectedDate = await AppDatePicker.show(
  context: context,
  initialDate: state.birthDate,
  firstDate: DateTime(1900),
  lastDate: DateTime.now(),
);
```

Recommended behavior:

| Platform / Size | Behavior |
|---|---|
| Mobile | Bottom sheet or Material date picker dialog |
| Tablet | Dialog date picker |
| Desktop | Popover or dialog date picker |
| Web | Dialog or popover date picker |

Rules:

- Date labels must be localized.
- Store date values consistently.
- Display dates using locale-aware formatting.
- Do not duplicate date picker logic in feature screens.

Date and time formatting rules are defined in [`date_time_formatting.md`](./date_time_formatting.md).

## Dialog and Snackbar System

Create standard feedback helpers.

```dart
AppSnackbar.showSuccess(context, l10n.profileSaved);
AppSnackbar.showError(context, l10n.profileSaveFailed);
```

```dart
final confirmed = await AppDialog.confirm(
  context: context,
  title: l10n.deleteAccount,
  message: l10n.deleteAccountMessage,
  confirmLabel: l10n.delete,
  cancelLabel: l10n.cancel,
);
```

Rules:

- No raw `SnackBar` creation in feature pages.
- No raw `AlertDialog` creation unless approved for a special case.
- All messages must be localized.
- Error dialogs must not expose stack traces.

## Component Documentation

Every shared component should document:

- Purpose.
- When to use it.
- When not to use it.
- Required localization behavior.
- Accessibility behavior.
- Example usage.


## Component Ownership Rule

A feature may create feature-specific widgets, but shared UI rules belong here.

Rules:

- Do not create multiple date picker components for different features.
- Do not create multiple button systems.
- Do not bypass shared form components for normal forms.
- Add a new shared component only when at least two features need the same behavior or when consistency requires one central entry point.
