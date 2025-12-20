part of 'book_case_detail_cubit.dart';

@freezed
class BookCaseDetailState with _$BookCaseDetailState {
  const factory BookCaseDetailState.loading() = _Loading;
  const factory BookCaseDetailState.success(BookCaseDetailResponse item) = _Success;
  const factory BookCaseDetailState.error(String message) = _Error;
}