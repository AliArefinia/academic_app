part of 'publishers_cubit.dart';

@freezed
class PublishersState with _$PublishersState {
  const factory PublishersState.initial() = _Initial;
  const factory PublishersState.loading() = _Loading;
  const factory PublishersState.success(List<PersonModel> publishers) = _Success;
  const factory PublishersState.error(String message) = _Error;
} 