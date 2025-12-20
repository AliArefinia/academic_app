import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:academic/core/storage/local_storage.dart';
import 'package:academic/data/model/invite_friends_model.dart';
import 'package:academic/data/model/gifts_model.dart';
import 'package:academic/data/repository/invitation_repository.dart';
import 'package:academic/data/repository/gifts_repository.dart';
import 'package:injectable/injectable.dart';

part 'invite_friends_state.dart';
part 'invite_friends_event.dart';
part 'invite_friends_cubit.freezed.dart';

@injectable
class InvitefriendsCubit extends Cubit<InvitefriendsState> {
  final LocalStorage _localStorage;
  final IInvitationRepository _invitationRepository;
  final IGiftsRepository _giftsRepository;
  
  InvitefriendsCubit(this._localStorage, this._invitationRepository, this._giftsRepository) : super(const InvitefriendsState()) {
    loadUserInviteCode();
    loadInvitedFriends(); // بارگذاری لیست دعوت‌ها هنگام شروع
  }

  void loadUserInviteCode() {
    final user = _localStorage.getUser();
    if (user != null && user.inviteCode != null) {
      emit(state.copyWith(inviteCode: user.inviteCode!));
    }
  }

  void onTabTap(String tabName) {
    emit(state.copyWith(currentTab: tabName));
    if (tabName == 'دعوت') {
      loadInvitedFriends();
    } else if (tabName == 'جوایز') {
      loadGifts();
    }
  }

  Future<void> loadInvitedFriends() async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    
    try {
      final response = await _invitationRepository.getMyInvites();
      final invitedFriends = response.data
          .map((item) => InvitedFriendsModel.fromApiItem(item))
          .toList();
      
      emit(state.copyWith(
        invitedFriends: invitedFriends,
        isLoading: false,
        errorMessage: null,
      ));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> loadGifts() async {
    emit(state.copyWith(isGiftsLoading: true, giftsErrorMessage: null));
    
    try {
      final response = await _giftsRepository.getMyGifts();
      final gifts = response.data
          .map((item) => GiftModel.fromApiItem(item))
          .toList();
      
      emit(state.copyWith(
        gifts: gifts,
        isGiftsLoading: false,
        giftsErrorMessage: null,
      ));
    } catch (e) {
      emit(state.copyWith(
        isGiftsLoading: false,
        giftsErrorMessage: e.toString(),
      ));
    }
  }
}
