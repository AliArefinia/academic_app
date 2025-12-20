part of 'invite_friends_cubit.dart';

@freezed
class InvitefriendsState with _$InvitefriendsState {
  const factory InvitefriendsState({
    @Default('دعوت') String currentTab,
    String? inviteCode,
    @Default([]) List<InvitedFriendsModel> invitedFriends,
    @Default([]) List<GiftModel> gifts,
    @Default(false) bool isLoading,
    @Default(false) bool isGiftsLoading,
    String? errorMessage,
    String? giftsErrorMessage,
  }) = _InvitefriendsState;
}


