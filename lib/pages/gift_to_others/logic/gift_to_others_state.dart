part of 'gift_to_others_cubit.dart';

@freezed
class GifttoothersState with _$GifttoothersState {
  const factory GifttoothersState.initial() = _Initial;
  const factory GifttoothersState.processing() = _Processing;
  const factory GifttoothersState.success() = _Success;
  const factory GifttoothersState.error(String message) = _Error;
}
