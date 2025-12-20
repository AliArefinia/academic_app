part of 'profile_management_cubit.dart';

@freezed
class ProfilemanagementState with _$ProfilemanagementState {
  const factory ProfilemanagementState.initial() = _Initial;
  const factory ProfilemanagementState.loading() = _Loading;
  const factory ProfilemanagementState.loaded(UserModel user, {String? updateError}) = _Loaded;
  const factory ProfilemanagementState.error(String message) = _Error;
  const factory ProfilemanagementState.success(String message) = _Success;
}
