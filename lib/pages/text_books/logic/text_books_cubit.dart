import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'text_books_state.dart';
part 'text_books_event.dart'; // Add event part
part 'text_books_cubit.freezed.dart'; // Add freezed part

class TextbooksCubit extends Cubit<TextbooksState> {
  TextbooksCubit() : super(const TextbooksState.initial());
}
