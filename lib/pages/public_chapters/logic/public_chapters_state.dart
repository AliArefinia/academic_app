part of 'public_chapters_cubit.dart';

@freezed
class PublicChaptersState with _$PublicChaptersState {
  const factory PublicChaptersState.initial() = _Initial;
  const factory PublicChaptersState.loading() = _Loading;
  const factory PublicChaptersState.loaded(List<Chapter> chapters) = _Loaded;
  const factory PublicChaptersState.error(String message) = _Error;
}
