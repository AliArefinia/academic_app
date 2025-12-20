part of 'bookmarked_books_cubit.dart';

@freezed
class BookmarkedBooksState with _$BookmarkedBooksState {
  const factory BookmarkedBooksState.loading() = _Loading;

  const factory BookmarkedBooksState.error(String message) = _Error;

  const factory BookmarkedBooksState.empty() = _Empty;

  const factory BookmarkedBooksState.success(
    List<BookModel> books,
  ) = _Success;
}
