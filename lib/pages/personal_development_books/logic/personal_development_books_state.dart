part of 'personal_development_books_cubit.dart';

@freezed
class PersonaldevelopmentbooksState with _$PersonaldevelopmentbooksState {
  const factory PersonaldevelopmentbooksState({
    required bool isTextBooksActive,
    required bool isAudioBooksActive,
    required bool isGridView,
  }) = _PersonaldevelopmentbooksState;

  factory PersonaldevelopmentbooksState.initial() =>
      const PersonaldevelopmentbooksState(
        isTextBooksActive: false,
        isAudioBooksActive: false,
        isGridView: true,
      );
}