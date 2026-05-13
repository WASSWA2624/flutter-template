# Reusable Components

## Scope
Defines the shared component system that keeps the app uniform without creating unnecessary custom widgets.

## Mandatory rules
- Prefer Flutter built-in Material/Cupertino widgets and wrap them only when consistency or repeated behavior is needed.
- Keep shared components minimal, flexible, and stable.
- Do not create multiple components for the same job.
- Do not put product-specific business logic in shared components.
- All user-facing labels, hints, validation messages, and accessibility labels must come from localization.
- Components must support enabled, disabled, loading, error, focused, and empty states where relevant.
- Components must adapt to supported screen sizes and input methods.

## Standard shared components
| Component | Built on | Purpose |
|---|---|---|
| `AppButton` | `FilledButton`, `OutlinedButton`, `TextButton` | primary, secondary, tertiary actions |
| `AppIconButton` | `IconButton` | icon actions with required semantic labels |
| `AppTextField` | `TextFormField` | text, number, password, multiline input |
| `AppSelectField<T>` | `DropdownMenu<T>` or Material menu primitives | searchable/filterable selection where needed |
| `AppRadioGroup<T>` | `RadioGroup` / `RadioListTile` | exclusive options |
| `AppCheckboxField` | `CheckboxListTile` | boolean option |
| `AppSwitchField` | `SwitchListTile` | setting toggle |
| `AppDateField` | `showDatePicker`, `CalendarDatePicker`, `InputDatePickerFormField` | date input with one API across screen sizes |
| `AppDialog` | `Dialog` / `AlertDialog` | consistent modal content |
| `AppScaffold` | `Scaffold` | shell spacing and responsive constraints |
| `AsyncStateScaffold` | shared composition | loading, empty, error, success states |
| `AppDataList` | `ListView`, slivers, pagination utilities | responsive list/data display |

## Form component rules
- Form components must expose validation hooks but must not own feature validation rules.
- Searchable selects must show options as overlays or menus, not by pushing unrelated content down unless the layout intentionally requires inline expansion.
- Date fields must use locale-aware formatting.
- Password fields must provide accessible show/hide behavior when used.

## Acceptance checklist
- A coding agent can build forms, lists, dialogs, empty states, and loading states using shared components only.
- Components look the same across features.
- Components work with keyboard, mouse, touch, and screen readers.

## Related rules
- [`forms.md`](./forms.md)
- [`theming.md`](./theming.md)
- [`responsive_adaptive_design.md`](./responsive_adaptive_design.md)
- [`accessibility.md`](./accessibility.md)
- [`localization_i18n.md`](./localization_i18n.md)
