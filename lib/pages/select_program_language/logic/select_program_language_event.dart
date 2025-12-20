part of 'select_program_language_cubit.dart';

@freezed
class SelectprogramlanguageEvent with _$SelectprogramlanguageEvent {
  const factory SelectprogramlanguageEvent.changeLanguage({
    required String selectedLanguage,
  }) = ChangeLanguage;
}
