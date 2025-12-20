part of 'password_cubit.dart';

@freezed
class PasswordState with _$PasswordState {
  const factory PasswordState.initial() = _Initial;
  const factory PasswordState.loading() = _Loading;
  const factory PasswordState.success() = _Success;
  const factory PasswordState.error(String message) = _Error;
}
