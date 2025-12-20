import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:academic/core/error/error_message_mapper.dart';
import 'package:academic/data/api/auth/model/auth_phone.dart';
import 'package:injectable/injectable.dart';

import '../../../../data/repo/auth_repo.dart';

part 'login_state.dart';
part 'login_cubit.freezed.dart';

@injectable
class LoginCubit extends Cubit<LoginState> {
  final AuthRepo _authRepo;

  LoginCubit(this._authRepo) : super(const LoginState.initial()) {
    // Set the initial state to phone input.
    emit(const LoginState.phoneInput());
  }

  // Toggle to email input mode.
  void toggleToEmail() => emit(const LoginState.emailInput());

  // Toggle back to phone input mode.
  void toggleToPhone() => emit(const LoginState.phoneInput());

  /// Submits the phone login by calling the API via AuthRepo.
  Future<void> submitPhoneLogin(String phone) async {
    // Prevent duplicate calls if already loading
    if (state.maybeWhen(
      loading: () => true,
      orElse: () => false,
    )) {
      return;
    }
    
    try {
      // Emit loading state before making API call.
      emit(const LoginState.loading());
      // Call the phone authentication API.
      final AuthPhoneModel authResponse = await _authRepo.authPhone(phone);

      // Check if user has password to determine next step
      if (authResponse.has_password) {
        // If user has a password, navigate to the password entry page.
        emit(LoginState.navigateToPassword(phone, authResponse.is_invited));
      } else {
        // If user does not have a password, navigate to the verification code page.
        emit(LoginState.navigateToVerification(phone, authResponse.is_invited, authResponse.has_password, authResponse.new_user));
      }
    } catch (error) {
      // On error, emit an error state with the user-friendly error message.
      emit(LoginState.error(ErrorMessageMapper.mapError(error)));
    }
  }

  /// Submits the email login by calling the API via AuthRepo.
  Future<void> submitEmailLogin(String email, String password) async {
    try {
      // Emit loading state before making API call.
      emit(const LoginState.loading());
      // Call the email password authentication API.
      await _authRepo.loginEmailPassword(email, password);
      // On successful login, save user and token and emit success.
      // The saving is handled within the AuthRepo's loginEmailPassword method.
      emit(const LoginState.success()); // Assuming success state is sufficient for now.
    } catch (error) {
      // On error, emit an error state with the user-friendly error message.
      emit(LoginState.error(ErrorMessageMapper.mapError(error)));
    }
  }
}