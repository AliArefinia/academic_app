import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:academic/data/repository/bookmarks_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:academic/data/api/home/model/book_model.dart';

part 'bookmarked_books_state.dart';
part 'bookmarked_books_cubit.freezed.dart';

@injectable
class BookmarkedBooksCubit extends Cubit<BookmarkedBooksState> {
  final IBookmarksRepository _repository;

  BookmarkedBooksCubit(this._repository) : super(const BookmarkedBooksState.loading()) {
    loadBookmarkedBooks();
  }

  Future<void> loadBookmarkedBooks() async {
    emit(const BookmarkedBooksState.loading());

    try {
      final result = await _repository.getBookmarks(limit: 100);
      if(result.data != null){
        final booksList = result.data!.list ?? [];
        if(booksList.isEmpty){
          emit(const BookmarkedBooksState.empty());
        } else {
          emit(BookmarkedBooksState.success(booksList));
        }
      } else {
        emit(const BookmarkedBooksState.empty());
      }
    } catch (e) {
      emit(BookmarkedBooksState.error(e.toString()));
    }
  }

  Future<void> refresh() async {
    await loadBookmarkedBooks();
  }
}
