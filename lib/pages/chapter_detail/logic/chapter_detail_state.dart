part of 'chapter_detail_cubit.dart';

@freezed
class ChapterDetailState with _$ChapterDetailState {
  const factory ChapterDetailState.initial() = _Initial;
  const factory ChapterDetailState.loading() = _Loading;
  const factory ChapterDetailState.loaded(Chapter chapter, List<Note> notes) = _Loaded;
  const factory ChapterDetailState.error(String message) = _Error;
}
