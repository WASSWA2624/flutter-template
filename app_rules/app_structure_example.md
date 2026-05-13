# Example `App` Structure

## Owning Scope

This file gives an example root `App` composition.

The concepts used here are defined in their owning files: theming in [`theming.md`](./theming.md), routing in [`navigation.md`](./navigation.md), localization in [`localization_i18n.md`](./localization_i18n.md), and startup in [`startup_flow.md`](./startup_flow.md).

## Example

```dart
class App extends ConsumerWidget {
  const App({
    super.key,
    required this.config,
  });

  final AppConfig config;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);
    final themeMode = ref.watch(appThemeModeProvider);
    final locale = ref.watch(localeProvider);

    return MaterialApp.router(
      onGenerateTitle: (context) => context.l10n.appName,
      routerConfig: router,
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: themeMode.toFlutterThemeMode(),
      locale: locale,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      debugShowCheckedModeBanner: config.environment != AppEnvironment.production,
    );
  }
}
```

## Notes

The app title is generated from localization so web and desktop window titles follow the same no-hard-coded-text rule as the rest of the UI.

## App Composition Rules

- Keep `App` small.
- Do not initialize services inside `App.build`.
- Watch only app-level providers here.
- Keep route config outside the widget body when possible.
- Keep theme and locale reactive.
- Keep startup work in bootstrap/startup services.


## Example Boundary

This file shows composition only. It should not redefine routing, theming, localization, or provider rules. Those rules are owned by their dedicated convention files.
