import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:academic/data/api/my_books/model/my_books_response.dart';
import 'package:academic/data/repo/book_case_repository.dart';

import '../../data/api/my_book_cases/model/my_book_case_model.dart';

part 'book_case_detail_state.dart';
part 'book_case_detail_cubit.freezed.dart';

class BookCaseDetailCubit extends Cubit<BookCaseDetailState> {
  final BookCaseRepository repository;

  BookCaseDetailCubit(this.repository) : super(const BookCaseDetailState.loading());

  Future<void> fetchBookCase(int id) async {
    emit(const BookCaseDetailState.loading());

    try {
      final bookCase = await repository.getBooksForCase(id);
      emit(BookCaseDetailState.success(bookCase));
    } catch (e) {
      emit(BookCaseDetailState.error(e.toString()));
    }
  }
}