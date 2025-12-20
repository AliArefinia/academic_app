part of 'invite_friends_cubit.dart';

@freezed
class InvitefriendsEvent with _$InvitefriendsEvent {
  const factory InvitefriendsEvent.changeLanguage({
    required String selectedLanguage,
  }) = ChangeLanguage;
}
