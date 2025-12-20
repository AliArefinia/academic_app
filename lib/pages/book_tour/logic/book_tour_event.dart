part of 'book_tour_cubit.dart';

@freezed
class BooktourEvent with _$BooktourEvent {
  const factory BooktourEvent.fetchBookExcerpts() = _FetchBookExcerpts;
  const factory BooktourEvent.onChipTap(String chip) = _OnChipTap;
  const factory BooktourEvent.toggleLike(int bookExcerptId) = _ToggleLike;
} 