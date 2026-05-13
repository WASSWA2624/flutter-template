# 10 - Localization readiness

## Goal
Set up generated localization with English as the initial locale.

## Applies app rules
- [`localization_i18n.md`](../app-rules/localization_i18n.md)
- [`date_time_formatting.md`](../app-rules/date_time_formatting.md)
- [`forms.md`](../app-rules/forms.md)
- [`error_handling.md`](../app-rules/error_handling.md)

## Implementation tasks
1. Create `l10n.yaml` and `app_en.arb`.
2. Wire localization delegates into `App`.
3. Create formatting utilities for dates, times, and numbers.
4. Move all visible starter text into localization.
5. Add a check or review rule for hard-coded UI text.

## Expected output
- Generated localization setup.
- English ARB file.
- Formatting utilities.

## Acceptance criteria
- No starter UI text is hard-coded in widgets.
- Locale-aware formatting is used.
- `flutter gen-l10n` succeeds.

## Coding-agent notes
- Do not skip rule references.
- Do not add product-specific behavior unless the step explicitly asks for it.
