part of 'translators_cubit.dart';

@freezed
class TranslatorsState with _$TranslatorsState {
  const factory TranslatorsState.initial() = _Initial;
  const factory TranslatorsState.loading() = _Loading;
  const factory TranslatorsState.success(List<PersonModel> translators) = _Success;
  const factory TranslatorsState.error(String message) = _Error;
} 