part of 'user_profile_cubit.dart';

@freezed
class UserprofileEvent with _$UserprofileEvent {
  const factory UserprofileEvent.changeLanguage({
    required String selectedLanguage,
  }) = ChangeLanguage;
}
