import 'package:flutter/widgets.dart';
import 'package:flutter_template/l10n/app_localizations.dart';

extension AppLocalizationsBuildContext on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this);
}

extension StarterAppLocalizations on AppLocalizations {
  List<String> get supportedStarterPlatforms {
    return <String>[
      homeSupportedPlatformAndroid,
      homeSupportedPlatformIos,
      homeSupportedPlatformWeb,
      homeSupportedPlatformWindowsDesktop,
      homeSupportedPlatformMacosDesktop,
      homeSupportedPlatformLinuxDesktop,
    ];
  }
}
