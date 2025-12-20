import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:academic/data/api/home/model/book_model.dart';

part 'tag_books_state.freezed.dart';

@freezed
class TagBooksState with _$TagBooksState {
  const factory TagBooksState.initial() = _Initial;
  const factory TagBooksState.loading() = _Loading;
  const factory TagBooksState.success({required List<BookModel> books}) = _Success;
  const factory TagBooksState.error(String message) = _Error;
}
