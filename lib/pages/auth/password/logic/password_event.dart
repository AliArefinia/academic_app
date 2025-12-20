part of 'password_cubit.dart';

@freezed
class PasswordEvent with _$PasswordEvent {
  const factory PasswordEvent.changeLanguage({
    required String selectedLanguage,
  }) = ChangeLanguage;
}
