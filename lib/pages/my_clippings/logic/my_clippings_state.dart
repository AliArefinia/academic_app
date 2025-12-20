part of 'my_clippings_cubit.dart';

@freezed
class MyClippingsState with _$MyClippingsState {
  const factory MyClippingsState({
    @Default(false) bool isLoading,
    @Default([]) List<MyBookExcerpt> myBookExcerpts,
    String? error,
    @Default(0) int index,
    @Default(false) bool isWhoLikeShow,
    @Default(false) bool isPeopleCommentsShow,
  }) = _MyClippingsState;
}
