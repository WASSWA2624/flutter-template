// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Flutter Template';

  @override
  String get startupLoadingTitle => 'Starting app';

  @override
  String get startupLoadingBody => 'Preparing local services.';

  @override
  String get startupErrorTitle => 'The app could not start';

  @override
  String get startupErrorBody =>
      'Restart the app or try again. Diagnostic details were logged safely.';

  @override
  String get commonRetryActionLabel => 'Try again';

  @override
  String get commonGoHomeActionLabel => 'Go home';

  @override
  String get navigationHomeLabel => 'Home';

  @override
  String get navigationSettingsLabel => 'Settings';

  @override
  String get homeReadyTitle => 'Project setup complete';

  @override
  String get homeReadyBody =>
      'A minimal app shell is ready for shared architecture, routing, localization, state, networking, storage, and feature work.';

  @override
  String get homeStarterFeaturesLabel => 'Starter foundation';

  @override
  String get homeFeatureResponsiveTitle => 'Responsive layout';

  @override
  String get homeFeatureResponsiveBody =>
      'Mobile, tablet, desktop, and web layouts share one adaptive shell.';

  @override
  String get homeFeatureNavigationTitle => 'Navigation';

  @override
  String get homeFeatureNavigationBody =>
      'Routes and menu destinations are centralized for simple expansion.';

  @override
  String get homeFeatureLocalizationTitle => 'Localization';

  @override
  String get homeFeatureLocalizationBody =>
      'English is active now, with generated localization ready for more languages.';

  @override
  String get homeFeatureSettingsTitle => 'Settings';

  @override
  String get homeFeatureSettingsBody =>
      'Theme and language preferences are wired through persistent app state.';

  @override
  String get homeLoadingTitle => 'Preparing home';

  @override
  String get homeLoadingBody => 'Loading the starter readiness state.';

  @override
  String get homeLoadErrorTitle => 'Home could not load';

  @override
  String get homeLoadErrorBody => 'Try the request again.';

  @override
  String get homeSupportedPlatformsLabel => 'Supported starter targets';

  @override
  String get homeSupportedPlatformAndroid => 'Android';

  @override
  String get homeSupportedPlatformIos => 'iOS';

  @override
  String get homeSupportedPlatformWeb => 'Web';

  @override
  String get homeSupportedPlatformWindowsDesktop => 'Windows desktop';

  @override
  String get homeSupportedPlatformMacosDesktop => 'macOS desktop';

  @override
  String get homeSupportedPlatformLinuxDesktop => 'Linux desktop';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get settingsBody =>
      'Choose the starter preferences that should apply across the app.';

  @override
  String get settingsLanguageSectionTitle => 'Language';

  @override
  String get settingsLanguageSectionBody =>
      'The template currently ships with English and can add more generated locales later.';

  @override
  String get settingsLanguageFieldLabel => 'App language';

  @override
  String get settingsLanguageEnglish => 'English';

  @override
  String get settingsThemeSectionTitle => 'Theme';

  @override
  String get settingsThemeSectionBody =>
      'Use the system appearance or choose a fixed light or dark theme.';

  @override
  String get settingsThemeModeFieldLabel => 'App theme';

  @override
  String get settingsThemeModeSystem => 'System';

  @override
  String get settingsThemeModeSystemDescription =>
      'Follow the platform appearance setting.';

  @override
  String get settingsThemeModeLight => 'Light';

  @override
  String get settingsThemeModeLightDescription => 'Use the light color scheme.';

  @override
  String get settingsThemeModeDark => 'Dark';

  @override
  String get settingsThemeModeDarkDescription => 'Use the dark color scheme.';

  @override
  String get settingsSaveErrorMessage => 'The preference could not be saved.';

  @override
  String get routeSessionRestoringTitle => 'Checking session';

  @override
  String get routeSessionRestoringBody =>
      'Session restoration must finish before this page can open.';

  @override
  String get routeAuthRequiredTitle => 'Sign-in required';

  @override
  String get routeAuthRequiredBody =>
      'A valid session is required before this page can open.';

  @override
  String get routeForbiddenTitle => 'Access denied';

  @override
  String get routeForbiddenBody =>
      'Your current session does not have permission to open this page.';

  @override
  String get routeNotFoundTitle => 'Page not found';

  @override
  String get routeNotFoundBody =>
      'The requested route does not exist or is no longer available.';

  @override
  String get validationRequired => 'This field is required.';

  @override
  String get errorNetworkTitle => 'Connection problem';

  @override
  String get errorNetworkMessage =>
      'The request could not finish. Check your connection and try again.';

  @override
  String get errorTimeoutTitle => 'Request timed out';

  @override
  String get errorTimeoutMessage => 'The request took too long. Try again.';

  @override
  String get errorOfflineTitle => 'No connection';

  @override
  String get errorOfflineMessage => 'Connect to the internet and try again.';

  @override
  String get errorCancelledTitle => 'Request cancelled';

  @override
  String get errorCancelledMessage =>
      'The request was cancelled before it finished.';

  @override
  String get errorUnauthorizedTitle => 'Sign-in required';

  @override
  String get errorUnauthorizedMessage => 'Sign in again to continue.';

  @override
  String get errorForbiddenTitle => 'Access denied';

  @override
  String get errorForbiddenMessage =>
      'You do not have permission to complete this action.';

  @override
  String get errorNotFoundTitle => 'Not found';

  @override
  String get errorNotFoundMessage =>
      'The requested item does not exist or is no longer available.';

  @override
  String get errorValidationTitle => 'Check the details';

  @override
  String get errorValidationMessage =>
      'Some details need attention before you can continue.';

  @override
  String get errorUnexpectedResponseTitle => 'Unexpected response';

  @override
  String get errorUnexpectedResponseMessage =>
      'The response could not be processed. Try again later.';

  @override
  String get errorStorageTitle => 'Storage unavailable';

  @override
  String get errorStorageMessage =>
      'Local data could not be accessed. Try again.';

  @override
  String get errorUnexpectedTitle => 'Something went wrong';

  @override
  String get errorUnexpectedMessage => 'Something went wrong. Try again.';
}
