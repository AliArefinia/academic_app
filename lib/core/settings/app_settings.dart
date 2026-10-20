import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// App-wide user preferences (theme mode and language), persisted locally.
///
/// Theme mode defaults to [ThemeMode.system] so the app follows the device's
/// light/dark setting until the user picks one explicitly in Settings.
class AppSettings extends ChangeNotifier {
  AppSettings._(this._prefs)
      : _themeMode = _themeModeFromName(_prefs.getString(_themeModeKey)),
        _locale = _localeFromCode(_prefs.getString(_localeKey));

  static const String _themeModeKey = 'app_theme_mode';
  static const String _localeKey = 'app_locale';

  static const Locale persianLocale = Locale('fa', 'IR');
  static const Locale englishLocale = Locale('en', 'US');
  static const List<Locale> supportedLocales = [englishLocale, persianLocale];

  static late AppSettings instance;

  static Future<void> init() async {
    instance = AppSettings._(await SharedPreferences.getInstance());
  }

  final SharedPreferences _prefs;
  ThemeMode _themeMode;
  Locale _locale;

  ThemeMode get themeMode => _themeMode;

  Locale get locale => _locale;

  /// Whether the app is currently rendered with the dark theme.
  bool get isDarkActive => switch (_themeMode) {
        ThemeMode.dark => true,
        ThemeMode.light => false,
        ThemeMode.system =>
          WidgetsBinding.instance.platformDispatcher.platformBrightness ==
              Brightness.dark,
      };

  bool get isRtl => _locale.languageCode == persianLocale.languageCode;

  TextDirection get textDirection =>
      isRtl ? TextDirection.rtl : TextDirection.ltr;

  Future<void> setThemeMode(ThemeMode mode) async {
    if (mode == _themeMode) return;
    _themeMode = mode;
    notifyListeners();
    await _prefs.setString(_themeModeKey, mode.name);
  }

  Future<void> setLocale(Locale locale) async {
    if (locale.languageCode == _locale.languageCode) return;
    _locale = _localeFromCode(locale.languageCode);
    notifyListeners();
    await _prefs.setString(_localeKey, _locale.languageCode);
  }

  static ThemeMode _themeModeFromName(String? name) {
    return ThemeMode.values.firstWhere(
      (mode) => mode.name == name,
      orElse: () => ThemeMode.system,
    );
  }

  static Locale _localeFromCode(String? code) {
    return supportedLocales.firstWhere(
      (locale) => locale.languageCode == code,
      orElse: () => persianLocale,
    );
  }
}
