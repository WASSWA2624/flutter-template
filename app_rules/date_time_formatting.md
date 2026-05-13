# Date, Time, and Formatting Strategy

## Owning Scope

This file defines date/time storage, display, parsing, and formatting service rules.

Localization is defined in [`localization_i18n.md`](./localization_i18n.md). Date picker UI behavior is defined in [`reusable_components.md`](./reusable_components.md).

## Rules

- Store timestamps consistently.
- Prefer UTC for backend communication unless the domain requires local time.
- Display dates using the user's locale.
- Do not format dates manually inside widgets.
- Use one formatter service.
- Be careful with date-only values such as birthdays.
- Be explicit about timezone behavior.

## Formatter Service

```dart
class DateFormatter {
  DateFormatter(this.locale);

  final Locale locale;

  String formatShortDate(DateTime value) {
    return DateFormat.yMMMd(locale.toLanguageTag()).format(value);
  }

  String formatTime(DateTime value) {
    return DateFormat.jm(locale.toLanguageTag()).format(value);
  }
}
```

## Date-Only Values

A date-only value should not accidentally shift because of timezone conversion.

Examples:

```txt
birthday
appointment date without time
reporting period date
```

For date-only values, consider storing:

```txt
year
month
day
```

or a backend-approved date-only format.

## Formatting Rules

- Never concatenate date strings manually.
- Use locale-aware date and number formatters.
- Keep formatting out of repositories.
- Keep storage format and display format separate.
- Write tests for important date/time conversions.


## Time Zone Policy

- Store instants in UTC unless the domain explicitly needs local civil time.
- Keep date-only values separate from date-time values.
- Display values using the active locale and the user's expected time zone.
- Document domain-specific time zone rules, such as schedules or deadlines.
