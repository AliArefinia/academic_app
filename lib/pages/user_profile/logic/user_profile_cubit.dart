import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:academic/core/storage/local_storage.dart';
import 'package:academic/data/api/auth/model/auth_response_model.dart';
import 'package:academic/data/repo/auth_repo.dart';
import 'package:academic/data/repo/profile_repository.dart';
import 'package:injectable/injectable.dart';

part 'user_profile_state.dart';
part 'user_profile_event.dart'; // Add event part
part 'user_profile_cubit.freezed.dart'; // Add freezed part

@injectable
class UserprofileCubit extends Cubit<UserprofileState> {
  final LocalStorage _localStorage;
  final AuthRepo _authRepo;
  final ProfileRepository _profileRepository;

  UserprofileCubit(this._localStorage, this._authRepo, this._profileRepository) : super(const UserprofileState.initial()) {
    loadUserData();
  }

  Future<void> loadUserData() async {
    try {
      emit(const UserprofileState.loading());
      
      // First try to get from API to ensure we have the latest data
      try {
        final profile = await _profileRepository.getProfile();
        // Preserve invite code from existing user data
        final existingUser = _localStorage.getUser();
        final updatedProfile = UserModel(
          id: profile.id,
          name: profile.name,
          phone: profile.phone,
          inviteCode: existingUser?.inviteCode ?? profile.inviteCode, // Preserve invite code
          createdAt: profile.createdAt,
          updatedAt: profile.updatedAt,
          lastName: profile.lastName,
          gender: profile.gender,
          dateOfBirth: profile.dateOfBirth,
          about: profile.about,
          avatar: profile.avatar,
        );
        await _localStorage.saveUser(updatedProfile);
        emit(UserprofileState.loaded(updatedProfile));
      } catch (apiError) {
        // If API fails, try to get from local storage as fallback
        final user = _localStorage.getUser();
        if (user != null) {
          emit(UserprofileState.loaded(user));
        } else {
          // If both API and local storage fail, show error
          emit(const UserprofileState.error('خطا در بارگذاری اطلاعات پروفایل. لطفا اتصال اینترنت خود را بررسی کنید.'));
        }
      }
    } catch (e) {
      emit(UserprofileState.error('خطا در بارگذاری اطلاعات پروفایل: ${e.toString()}'));
    }
  }

  Future<void> logout() async {
    // Optionally emit a loading state before logout
    // emit(const UserprofileState.loading());
    try {
      await _authRepo.logout();
      // Logout is successful, the interceptor in ApiClient will clear local storage
      // and potentially handle navigation if set up that way. If not, navigate here.
      // Since the requirement is to return to the login page, we will handle navigation here.
      emit(const UserprofileState.initial()); // Or a specific logged out state if needed
    } catch (e) {
      // Even if logout API call fails, local storage should be cleared by AuthRepo.
      // We might want to show an error message to the user.
      emit(UserprofileState.error('Logout failed: ${e.toString()}'));
    }
  }
}
