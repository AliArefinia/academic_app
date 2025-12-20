part of 'my_comments_main_cubit.dart';

@freezed
class MycommentsmainState with _$MycommentsmainState {
  const factory MycommentsmainState({
    @Default('ثبت نظر جدید') String currentTab,
    @Default(false) bool isLoading,
    @Default(false) bool isError,
    @Default('') String errorMessage,
    @Default([]) List<UserReviewModel> reviews,
  }) = _MycommentsmainState;
}
