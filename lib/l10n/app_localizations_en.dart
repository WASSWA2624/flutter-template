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
  String get homeReadyTitle => 'Project setup complete';

  @override
  String get homeReadyBody =>
      'A minimal app shell is ready for shared architecture, routing, localization, state, networking, storage, and feature work.';

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
