part of 'my_book_excerpt_comments_cubit.dart';

@freezed
class MyBookExcerptCommentsState with _$MyBookExcerptCommentsState {
  const factory MyBookExcerptCommentsState({
    @Default(false) bool isLoading,
    @Default([]) List<MyBookExcerptComment> comments,
    String? error,
  }) = _MyBookExcerptCommentsState;
}

