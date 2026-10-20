import 'package:academic/l10n/l10n.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:academic/core/error/error_message_mapper.dart';
import 'package:academic/core/storage/local_storage.dart';
import 'package:academic/data/api/auth/model/auth_response_model.dart';
import 'package:academic/data/repo/profile_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:dio/dio.dart';

part 'profile_management_state.dart';
part 'profile_management_event.dart';
part 'profile_management_cubit.freezed.dart';

@injectable
class ProfilemanagementCubit extends Cubit<ProfilemanagementState> {
  final ProfileRepository _profileRepository;
  final LocalStorage _localStorage;

  ProfilemanagementCubit(this._profileRepository, this._localStorage)
      : super(const ProfilemanagementState.initial()) {
    loadProfile();
  }

  Future<void> loadProfile() async {
    try {
      emit(const ProfilemanagementState.loading());
      
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
        emit(ProfilemanagementState.loaded(updatedProfile));
      } catch (apiError) {
        // If API fails, try to get from local storage as fallback
        final user = _localStorage.getUser();
        if (user != null) {
          emit(ProfilemanagementState.loaded(user));
        } else {
          // If both API and local storage fail, show error
          emit(ProfilemanagementState.error(l10n.errorLoadingProfileCheckInternet));
        }
      }
    } catch (e) {
      emit(ProfilemanagementState.error(l10n.errorLoadingProfileWithMessage(e.toString())));
    }
  }

  Future<void> updateProfile({
    required String name,
    required String lastName,
    String? password,
    required String gender,
    required String dateOfBirth,
    required String about,
    String? avatarImage,
  }) async {
    try {
      emit(const ProfilemanagementState.loading());
      final updatedProfile = await _profileRepository.updateProfile(
        name: name,
        lastName: lastName,
        password: password,
        gender: gender,
        dateOfBirth: dateOfBirth,
        about: about,
        avatarImage: avatarImage,
      );
      // Preserve invite code from existing user data
      final existingUser = _localStorage.getUser();
      final finalProfile = UserModel(
        id: updatedProfile.id,
        name: updatedProfile.name,
        phone: updatedProfile.phone,
        inviteCode: existingUser?.inviteCode ?? updatedProfile.inviteCode, // Preserve invite code
        createdAt: updatedProfile.createdAt,
        updatedAt: updatedProfile.updatedAt,
        lastName: updatedProfile.lastName,
        gender: updatedProfile.gender,
        dateOfBirth: updatedProfile.dateOfBirth,
        about: updatedProfile.about,
        avatar: updatedProfile.avatar,
      );
      await _localStorage.saveUser(finalProfile);
      emit(const ProfilemanagementState.success('profileUpdatedSuccessfully'));
      // After showing success message, emit loaded state to stay on the page
      await Future.delayed(const Duration(milliseconds: 100));
      emit(ProfilemanagementState.loaded(finalProfile));
    } on DioException catch (e) {
      // Get current user data to stay in loaded state
      final currentUser = _localStorage.getUser();
      if (currentUser != null) {
        // Extract user-friendly error message
        String errorMsg = ErrorMessageMapper.mapError(e);
        // Emit loaded without error first to ensure state change
        emit(ProfilemanagementState.loaded(currentUser));
        // Then emit with error
        await Future.delayed(const Duration(milliseconds: 10));
        emit(ProfilemanagementState.loaded(currentUser, updateError: errorMsg));
      } else {
        // Fallback to loading profile if no cached user
        await loadProfile();
      }
    } catch (e) {
      // Get current user data to stay in loaded state
      final currentUser = _localStorage.getUser();
      if (currentUser != null) {
        String errorMsg = ErrorMessageMapper.mapError(e);
        // Emit loaded without error first to ensure state change
        emit(ProfilemanagementState.loaded(currentUser));
        // Then emit with error
        await Future.delayed(const Duration(milliseconds: 10));
        emit(ProfilemanagementState.loaded(currentUser, updateError: errorMsg));
      } else {
        // Fallback to loading profile if no cached user
        await loadProfile();
      }
    }
  }
}
