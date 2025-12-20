part of 'language_bloc.dart';


@freezed
class LanguageEvent with _$LanguageEvent {
  const factory LanguageEvent.changeLanguage({
    required Language selectedLanguage,
  }) = ChangeLanguage;
}
