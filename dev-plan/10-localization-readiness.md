# 10 - Localization readiness

## Goal

Prepare the template for localization from day one while shipping with English only by default.

## Applies app rules

- [`localization_i18n.md`](../app-rules/localization_i18n.md)
- [`date_time_formatting.md`](../app-rules/date_time_formatting.md)
- [`forms.md`](../app-rules/forms.md)
- [`validation.md`](../app-rules/validation.md)
- [`reusable_components.md`](../app-rules/reusable_components.md)
- [`coding_conventions.md`](../app-rules/coding_conventions.md)

## Files to create

```txt
l10n.yaml
lib/l10n/app_en.arb
lib/core/localization/l10n_extensions.dart
lib/core/localization/locale_controller.dart
lib/core/localization/locale_provider.dart
lib/core/utils/date_formatter.dart
```

## `l10n.yaml`

```yaml
arb-dir: lib/l10n
template-arb-file: app_en.arb
output-localization-file: app_localizations.dart
output-class: AppLocalizations
synthetic-package: false
nullable-getter: false
```

## Initial ARB file

Create `lib/l10n/app_en.arb`:

```json
{
  "@@locale": "en",
  "appName": "Flutter App Template",
  "homeTitle": "Home",
  "settingsTitle": "Settings",
  "save": "Save",
  "cancel": "Cancel",
  "retry": "Retry",
  "loading": "Loading",
  "emptyStateTitle": "Nothing here yet",
  "errorGenericTitle": "Something went wrong",
  "errorGenericMessage": "Please try again."
}
```

Add more keys as components and pages are created.

## Root app setup

Configure `MaterialApp.router` with:

- generated localization delegates
- supported locales
- selected locale from `localeProvider`
- fallback behavior through generated localization

## Localization extension

Create a context extension:

```dart
extension L10nX on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this);
}
```

## Date and number formatting

Use a single formatter service:

```dart
class DateFormatter {
  DateFormatter(this.locale);

  final Locale locale;

  String formatShortDate(DateTime value) {
    return DateFormat.yMd(locale.toLanguageTag()).format(value);
  }
}
```

Rules:

- Store timestamps consistently.
- Prefer UTC for backend communication unless the domain requires local time.
- Display dates using the user's locale.
- Do not format dates manually inside widgets.
- Be explicit about date-only values such as birthdays.

## Localization rules

- No user-facing hard-coded strings in widgets, controllers, dialogs, snackbars, validation messages, or menu labels.
- Use placeholders for dynamic values.
- Use plurals/selects when needed.
- Shared components accept localized labels or keys from callers.
- Feature-specific ARB keys should be named clearly, for example `loginEmailLabel`.

## Acceptance criteria

- `flutter gen-l10n` runs through `flutter pub get` or build.
- English localization exists.
- Root app uses generated delegates.
- Theme/settings screens use localization keys.
- Date formatting is centralized.
- No visible starter UI string is hard-coded directly in widgets.
