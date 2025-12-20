part of 'payment_cubit.dart';

@freezed
class PaymentState with _$PaymentState {
  const factory PaymentState.initial() = _Initial;
  const factory PaymentState.loading() = _Loading;
  const factory PaymentState.success(PaymentResponse response) = _Success;
  const factory PaymentState.verified(PaymentVerifyResponse response) = _Verified;
  const factory PaymentState.tracked(PaymentTrackingResponse response) = _Tracked;
  const factory PaymentState.error(String message) = _Error;
} 