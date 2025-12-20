part of 'profile_management_cubit.dart';

@freezed
class ProfilemanagementEvent with _$ProfilemanagementEvent {
  const factory ProfilemanagementEvent.changeLanguage({
    required String selectedLanguage,
  }) = ChangeLanguage;
  const factory ProfilemanagementEvent.loadProfile() = LoadProfile;
  const factory ProfilemanagementEvent.updateProfile({
    required String name,
    required String lastName,
    String? password,
    required String gender,
    required String dateOfBirth,
    required String about,
    String? avatarImage,
  }) = UpdateProfile;
}
