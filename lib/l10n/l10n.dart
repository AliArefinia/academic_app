import 'package:academic/core/settings/app_settings.dart';
import 'package:academic/l10n/app_localizations.dart';

export 'package:academic/l10n/app_localizations.dart';

AppLocalizations? _cached;

/// Translations for the app's current language.
///
/// Usable outside the widget tree (cubits, services, helpers) as well as in
/// widgets. The widget tree is rebuilt from the root whenever the language
/// changes (see `main.dart`), so values read here are always up to date.
AppLocalizations get l10n {
  final locale = AppSettings.instance.locale;
  final cached = _cached;
  if (cached != null && cached.localeName == locale.languageCode) {
    return cached;
  }
  return _cached = lookupAppLocalizations(locale);
}
