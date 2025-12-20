part of 'my_books_cubit.dart';

@freezed
class MyBooksState with _$MyBooksState {
  const factory MyBooksState.loading() = _Loading;

  const factory MyBooksState.error(String message) = _Error;

  const factory MyBooksState.empty() = _Empty;

  const factory MyBooksState.success(
      MyBooksResponse data, {
        @Default(0) int selectedCategory,
      }) = _Success;
}