import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'author_book_state.dart';
part 'author_book_event.dart'; // Add event part
part 'author_book_cubit.freezed.dart'; // Add freezed part

class AuthorbookCubit extends Cubit<AuthorbookState> {
  AuthorbookCubit() : super(const AuthorbookState.initial());
}
