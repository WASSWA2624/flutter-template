import 'dart:ui';

abstract final class AppStrings {
  static const String appTitle = 'Flutter Template';
  static const Locale defaultLocale = Locale('en');
  static const List<Locale> supportedLocales = <Locale>[defaultLocale];

  static const String startupLoadingTitle = 'Starting app';
  static const String startupLoadingBody = 'Preparing local services.';
  static const String startupErrorTitle = 'The app could not start';
  static const String startupErrorBody =
      'Restart the app or try again. Diagnostic details were logged safely.';
  static const String retryActionLabel = 'Try again';

  static const String readyTitle = 'Project setup complete';
  static const String readyBody =
      'A minimal app shell is ready for shared architecture, routing, '
      'localization, state, networking, storage, and feature work.';
  static const String supportedPlatformsLabel = 'Supported starter targets';
  static const List<String> supportedPlatforms = <String>[
    'Android',
    'iOS',
    'Web',
    'Windows desktop',
    'macOS desktop',
    'Linux desktop',
  ];
}
