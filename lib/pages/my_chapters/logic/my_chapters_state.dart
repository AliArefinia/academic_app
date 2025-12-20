part of 'my_chapters_cubit.dart';

@freezed
class MyChaptersState with _$MyChaptersState {
  const factory MyChaptersState.initial() = _Initial;
  const factory MyChaptersState.loading() = _Loading;
  const factory MyChaptersState.loaded(List<Chapter> chapters) = _Loaded;
  const factory MyChaptersState.error(String message) = _Error;
}
