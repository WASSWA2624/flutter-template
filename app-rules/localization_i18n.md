# Localization and Internationalization

## Scope
Defines how user-facing text, formatting, and accessibility labels are handled.

## Mandatory rules
- Do not hard-code user-facing text inside widgets, controllers, validators, or error views.
- Use generated Flutter localization files from `lib/l10n`.
- English is the initial development locale.
- Every future locale must have its own ARB file.
- Use locale-aware formatting for dates, times, numbers, currency, and plural messages.
- Keep localization keys descriptive and stable.
- Include accessibility labels and error messages in localization files.
- Do not concatenate translated strings when interpolation or pluralization is required.

## File standard
```txt
lib/l10n/
├── app_en.arb
├── app_<locale>.arb
└── l10n.yaml
```

## Key naming standard
| Purpose | Example |
|---|---|
| Page title | `authLoginTitle` |
| Button | `commonSaveButton` |
| Field label | `profileFirstNameLabel` |
| Validation | `validationRequired` |
| Empty state | `patientsEmptyTitle` |
| Error | `networkTimeoutMessage` |

## Acceptance checklist
- `flutter gen-l10n` succeeds.
- A scan of `lib/features` finds no hard-coded user-facing strings.
- Dates and numbers are formatted through shared formatting utilities.
- Changing locale updates the app without changing business logic.

## Related rules
- [`date_time_formatting.md`](./date_time_formatting.md)
- [`forms.md`](./forms.md)
- [`error_handling.md`](./error_handling.md)
- [`accessibility.md`](./accessibility.md)
