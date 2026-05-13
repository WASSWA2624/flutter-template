# Localization and Internationalization Strategy

## Owning Scope

This file defines all user-facing text rules, locale files, ARB usage, pluralization, date/number localization, and right-to-left support expectations.

Date/time storage and formatting conventions are expanded in [`date_time_formatting.md`](./date_time_formatting.md).

## Main Rule

There must be no hard-coded user-facing text in the interface.

This includes:

- Page titles.
- Button labels.
- Navigation labels.
- Field labels.
- Field hints.
- Validation messages.
- Error messages.
- Dialog text.
- Snackbar text.
- Empty state text.
- Tooltips.
- Accessibility labels.

Bad:

```dart
Text('Login')
```

Good:

```dart
Text(l10n.login)
```

## Locale Folder

```txt
lib/l10n/
  app_en.arb
  app_es.arb
  app_fr.arb
```

Start development with English only:

```txt
app_en.arb
```

Add other languages when needed.

## `l10n.yaml`

```yaml
arb-dir: lib/l10n
template-arb-file: app_en.arb
output-localization-file: app_localizations.dart
nullable-getter: false
```

## `pubspec.yaml`

```yaml
flutter:
  generate: true
```

## Example ARB File

```json
{
  "@@locale": "en",
  "appName": "Starter App",
  "@appName": {
    "description": "The application name shown in the UI."
  },
  "login": "Log in",
  "@login": {
    "description": "Label for the login button."
  },
  "requiredField": "This field is required",
  "@requiredField": {
    "description": "Validation message for required form fields."
  },
  "itemsCount": "{count, plural, =0{No items} =1{1 item} other{{count} items}}",
  "@itemsCount": {
    "description": "Shows how many items are available.",
    "placeholders": {
      "count": {
        "type": "int"
      }
    }
  }
}
```

## App Setup

```dart
MaterialApp.router(
  routerConfig: router,
  theme: AppTheme.light(),
  darkTheme: AppTheme.dark(),
  themeMode: themeMode,
  localizationsDelegates: AppLocalizations.localizationsDelegates,
  supportedLocales: AppLocalizations.supportedLocales,
)
```

## Localization Extension

```dart
extension L10nX on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this);
}
```

Usage:

```dart
Text(context.l10n.login)
```

## Localization Rules

- Use ARB files for all user-facing text.
- Add metadata descriptions for translator context.
- Use placeholders for dynamic values.
- Use plural messages for counts.
- Use select messages for gender/status/category text where needed.
- Format dates and numbers using locale-aware formatters.
- Never concatenate translated strings manually.
- Support right-to-left layout when adding RTL languages.

Bad:

```dart
Text('${count.toString()} items')
```

Good:

```dart
Text(l10n.itemsCount(count))
```

## Naming Keys

Use clear, stable keys.

Good:

```txt
loginButtonLabel
profileSavedMessage
requiredFieldError
```

Bad:

```txt
text1
messageA
buttonBlue
```

Keys should describe meaning, not color, position, or temporary UI layout.


## Translation Governance

- English is the initial source locale.
- Each added language must have its own ARB file.
- Missing translations should fail CI for production builds when possible.
- Translator descriptions should explain intent, not repeat the same text.
- Do not build sentences by concatenating translated fragments.
