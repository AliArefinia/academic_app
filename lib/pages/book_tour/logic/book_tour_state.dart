part of 'book_tour_cubit.dart';

@freezed
class BooktourState with _$BooktourState {
  const factory BooktourState({
    @Default([]) List<BookExcerpt> bookExcerpts,
    @Default(false) bool isLoading,
    String? error,
    @Default('همه') String currentChip,
  }) = _BooktourState;
} 