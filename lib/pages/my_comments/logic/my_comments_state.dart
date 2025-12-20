part of 'my_comments_cubit.dart';

@freezed
class MycommentsState with _$MycommentsState {
  const factory MycommentsState({
    @Default(0) int rate,
    @Default("") String opinion,
    @Default(false) bool isContinued,
    @Default(false) bool isLoading,
    String? error,
    @Default(false) bool success,
    @Default(false) bool showCommentError,
    @Default(false) bool showRateError,
  }) = _MycommentsState;
}
