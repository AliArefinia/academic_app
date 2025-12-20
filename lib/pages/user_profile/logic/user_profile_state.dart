part of 'user_profile_cubit.dart';

@freezed
class UserprofileState with _$UserprofileState {
  const factory UserprofileState.initial() = _Initial;
  const factory UserprofileState.loading() = _Loading;
  const factory UserprofileState.loaded(UserModel user) = _Loaded;
  const factory UserprofileState.error(String message) = _Error;
}
