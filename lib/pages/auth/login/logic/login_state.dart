part of 'login_cubit.dart';

@freezed
class LoginState with _$LoginState {
  const factory LoginState.initial() = _Initial;
  const factory LoginState.phoneInput() = _PhoneInput;
  const factory LoginState.emailInput() = _EmailInput;
  const factory LoginState.loading() = _Loading;
  const factory LoginState.error(String message) = _Error;
  const factory LoginState.success() = _Success;
  const factory LoginState.navigateToPassword(String phone, bool? isInvited) = NavigateToPassword;
  const factory LoginState.navigateToVerification(String phone, bool? isInvited, bool hasPassword, bool newUser) = NavigateToVerification;
}