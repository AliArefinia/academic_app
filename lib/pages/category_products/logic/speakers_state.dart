part of 'speakers_cubit.dart';

@freezed
class SpeakersState with _$SpeakersState {
  const factory SpeakersState.initial() = _Initial;
  const factory SpeakersState.loading() = _Loading;
  const factory SpeakersState.success(List<PersonModel> speakers) = _Success;
  const factory SpeakersState.error(String message) = _Error;
} 