import 'dart:ui';

enum Language {
  english(
    Locale('en', 'US'),
    'English',
    'assets/ic_french.svg',
  ),
  farsi(
    Locale('fa', 'IR'),
    'فارسی',
    'assets/ic_germany.svg',
  );

  const Language(
      this.locale,
      this.text,
      this.flag,
      );

  final Locale locale;
  final String text;
  final String flag;

  /// Helper to get a list of all languages
  static List<Language> get languageList => Language.values;

  /// Find a language by its Locale
  static Language? findByLocale(Locale locale) {
    return languageList.firstWhere(
          (lang) => lang.locale == locale,
      orElse: () => english, // Default fallback
    );
  }
}
