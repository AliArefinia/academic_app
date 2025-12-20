part of 'language_bloc.dart';

@freezed
class LanguageState with _$LanguageState {
  const factory LanguageState({
    @Default(Language.farsi) Language selectedLanguage,
  }) = _LanguageState;
}
