import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[Locale('en')];

  /// Application title shown in app bars and platform task lists.
  ///
  /// In en, this message translates to:
  /// **'Flutter Template'**
  String get appTitle;

  /// Title shown while startup dependencies initialize.
  ///
  /// In en, this message translates to:
  /// **'Starting app'**
  String get startupLoadingTitle;

  /// Body text shown while startup dependencies initialize.
  ///
  /// In en, this message translates to:
  /// **'Preparing local services.'**
  String get startupLoadingBody;

  /// Title shown when startup initialization fails.
  ///
  /// In en, this message translates to:
  /// **'The app could not start'**
  String get startupErrorTitle;

  /// Safe user-facing startup error message.
  ///
  /// In en, this message translates to:
  /// **'Restart the app or try again. Diagnostic details were logged safely.'**
  String get startupErrorBody;

  /// Label for actions that retry a failed operation.
  ///
  /// In en, this message translates to:
  /// **'Try again'**
  String get commonRetryActionLabel;

  /// Label for actions that navigate back to the home route.
  ///
  /// In en, this message translates to:
  /// **'Go home'**
  String get commonGoHomeActionLabel;

  /// Navigation label for the home destination.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get navigationHomeLabel;

  /// Home page title for the starter template readiness state.
  ///
  /// In en, this message translates to:
  /// **'Project setup complete'**
  String get homeReadyTitle;

  /// Home page body for the starter template readiness state.
  ///
  /// In en, this message translates to:
  /// **'A minimal app shell is ready for shared architecture, routing, localization, state, networking, storage, and feature work.'**
  String get homeReadyBody;

  /// Title shown while the home feature controller loads readiness state.
  ///
  /// In en, this message translates to:
  /// **'Preparing home'**
  String get homeLoadingTitle;

  /// Body shown while the home feature controller loads readiness state.
  ///
  /// In en, this message translates to:
  /// **'Loading the starter readiness state.'**
  String get homeLoadingBody;

  /// Title shown when the home feature controller fails.
  ///
  /// In en, this message translates to:
  /// **'Home could not load'**
  String get homeLoadErrorTitle;

  /// Body shown when the home feature controller fails.
  ///
  /// In en, this message translates to:
  /// **'Try the request again.'**
  String get homeLoadErrorBody;

  /// Heading for the list of starter target platforms.
  ///
  /// In en, this message translates to:
  /// **'Supported starter targets'**
  String get homeSupportedPlatformsLabel;

  /// Starter target platform label for Android.
  ///
  /// In en, this message translates to:
  /// **'Android'**
  String get homeSupportedPlatformAndroid;

  /// Starter target platform label for iOS.
  ///
  /// In en, this message translates to:
  /// **'iOS'**
  String get homeSupportedPlatformIos;

  /// Starter target platform label for web.
  ///
  /// In en, this message translates to:
  /// **'Web'**
  String get homeSupportedPlatformWeb;

  /// Starter target platform label for Windows desktop.
  ///
  /// In en, this message translates to:
  /// **'Windows desktop'**
  String get homeSupportedPlatformWindowsDesktop;

  /// Starter target platform label for macOS desktop.
  ///
  /// In en, this message translates to:
  /// **'macOS desktop'**
  String get homeSupportedPlatformMacosDesktop;

  /// Starter target platform label for Linux desktop.
  ///
  /// In en, this message translates to:
  /// **'Linux desktop'**
  String get homeSupportedPlatformLinuxDesktop;

  /// Title shown while session restoration blocks a guarded route.
  ///
  /// In en, this message translates to:
  /// **'Checking session'**
  String get routeSessionRestoringTitle;

  /// Body shown while session restoration blocks a guarded route.
  ///
  /// In en, this message translates to:
  /// **'Session restoration must finish before this page can open.'**
  String get routeSessionRestoringBody;

  /// Title shown when a route requires authentication.
  ///
  /// In en, this message translates to:
  /// **'Sign-in required'**
  String get routeAuthRequiredTitle;

  /// Body shown when a route requires authentication.
  ///
  /// In en, this message translates to:
  /// **'A valid session is required before this page can open.'**
  String get routeAuthRequiredBody;

  /// Title shown when a session lacks route permission.
  ///
  /// In en, this message translates to:
  /// **'Access denied'**
  String get routeForbiddenTitle;

  /// Body shown when a session lacks route permission.
  ///
  /// In en, this message translates to:
  /// **'Your current session does not have permission to open this page.'**
  String get routeForbiddenBody;

  /// Title shown when a route cannot be matched.
  ///
  /// In en, this message translates to:
  /// **'Page not found'**
  String get routeNotFoundTitle;

  /// Body shown when a route cannot be matched.
  ///
  /// In en, this message translates to:
  /// **'The requested route does not exist or is no longer available.'**
  String get routeNotFoundBody;

  /// Generic required-field validation message for forms.
  ///
  /// In en, this message translates to:
  /// **'This field is required.'**
  String get validationRequired;

  /// Title for a generic network failure.
  ///
  /// In en, this message translates to:
  /// **'Connection problem'**
  String get errorNetworkTitle;

  /// Safe user-facing message for a generic network failure.
  ///
  /// In en, this message translates to:
  /// **'The request could not finish. Check your connection and try again.'**
  String get errorNetworkMessage;

  /// Title for a timeout failure.
  ///
  /// In en, this message translates to:
  /// **'Request timed out'**
  String get errorTimeoutTitle;

  /// Safe user-facing message for a timeout failure.
  ///
  /// In en, this message translates to:
  /// **'The request took too long. Try again.'**
  String get errorTimeoutMessage;

  /// Title for an offline failure.
  ///
  /// In en, this message translates to:
  /// **'No connection'**
  String get errorOfflineTitle;

  /// Safe user-facing message for an offline failure.
  ///
  /// In en, this message translates to:
  /// **'Connect to the internet and try again.'**
  String get errorOfflineMessage;

  /// Title for a cancelled request failure.
  ///
  /// In en, this message translates to:
  /// **'Request cancelled'**
  String get errorCancelledTitle;

  /// Safe user-facing message for a cancelled request failure.
  ///
  /// In en, this message translates to:
  /// **'The request was cancelled before it finished.'**
  String get errorCancelledMessage;

  /// Title for an unauthorized failure.
  ///
  /// In en, this message translates to:
  /// **'Sign-in required'**
  String get errorUnauthorizedTitle;

  /// Safe user-facing message for an unauthorized failure.
  ///
  /// In en, this message translates to:
  /// **'Sign in again to continue.'**
  String get errorUnauthorizedMessage;

  /// Title for a forbidden failure.
  ///
  /// In en, this message translates to:
  /// **'Access denied'**
  String get errorForbiddenTitle;

  /// Safe user-facing message for a forbidden failure.
  ///
  /// In en, this message translates to:
  /// **'You do not have permission to complete this action.'**
  String get errorForbiddenMessage;

  /// Title for a not-found failure.
  ///
  /// In en, this message translates to:
  /// **'Not found'**
  String get errorNotFoundTitle;

  /// Safe user-facing message for a not-found failure.
  ///
  /// In en, this message translates to:
  /// **'The requested item does not exist or is no longer available.'**
  String get errorNotFoundMessage;

  /// Title for a validation failure.
  ///
  /// In en, this message translates to:
  /// **'Check the details'**
  String get errorValidationTitle;

  /// Safe user-facing message for a validation failure.
  ///
  /// In en, this message translates to:
  /// **'Some details need attention before you can continue.'**
  String get errorValidationMessage;

  /// Title for an unexpected API response failure.
  ///
  /// In en, this message translates to:
  /// **'Unexpected response'**
  String get errorUnexpectedResponseTitle;

  /// Safe user-facing message for an unexpected API response failure.
  ///
  /// In en, this message translates to:
  /// **'The response could not be processed. Try again later.'**
  String get errorUnexpectedResponseMessage;

  /// Title for a local storage failure.
  ///
  /// In en, this message translates to:
  /// **'Storage unavailable'**
  String get errorStorageTitle;

  /// Safe user-facing message for a local storage failure.
  ///
  /// In en, this message translates to:
  /// **'Local data could not be accessed. Try again.'**
  String get errorStorageMessage;

  /// Title for an unexpected failure.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong'**
  String get errorUnexpectedTitle;

  /// Generic safe error message for unexpected recoverable failures.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong. Try again.'**
  String get errorUnexpectedMessage;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
