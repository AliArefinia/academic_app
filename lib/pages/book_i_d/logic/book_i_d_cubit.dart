import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'book_i_d_state.dart';
part 'book_i_d_event.dart'; // Add event part
part 'book_i_d_cubit.freezed.dart'; // Add freezed part

class BookidCubit extends Cubit<BookidState> {
  BookidCubit() : super(const BookidState.initial());
}
