part of 'payment_history_cubit.dart';

@freezed
class PaymenthistoryState with _$PaymenthistoryState {
  const factory PaymenthistoryState.initial() = _Initial;
  const factory PaymenthistoryState.loading() = _Loading;
  const factory PaymenthistoryState.success(List<PaymentHistoryModel> payments) = _Success;
  const factory PaymenthistoryState.error(String message) = _Error;
}
