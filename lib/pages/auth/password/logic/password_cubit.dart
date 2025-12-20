import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:academic/core/error/error_message_mapper.dart';
import 'package:injectable/injectable.dart';

import '../../../../data/repo/auth_repo.dart';

part 'password_state.dart';
part 'password_event.dart'; // Add event part
part 'password_cubit.freezed.dart'; // Add freezed part

@injectable
class PasswordCubit extends Cubit<PasswordState> {
  final AuthRepo _authRepo;
  final String _phone;

  PasswordCubit(this._authRepo, this._phone) : super(const PasswordState.initial());

  Future<void> submitPasswordLogin(String password, {String? inviteCode}) async {
    if (isClosed) return; // Check if cubit is closed before emitting
    emit(const PasswordState.loading());
    try {
      await _authRepo.loginPassword(_phone, password, inviteCode: inviteCode);
      if (isClosed) return; // Check if cubit is closed before emitting
      emit(const PasswordState.success());
    } catch (e) {
      if (isClosed) return; // Check if cubit is closed before emitting
      emit(PasswordState.error(ErrorMessageMapper.mapError(e)));
    }
  }
}
