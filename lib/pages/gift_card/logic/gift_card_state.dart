part of 'gift_card_cubit.dart';

@freezed
class GiftcardState with _$GiftcardState {
  const factory GiftcardState({
    @Default(false) bool isContinued,
    @Default(false) bool isPaymentSuccessful,
    @Default(false) bool isProcessingPayment,
    @Default(1) int index,
    @Default(0) int amountOfCharge,
    String? error,
  }) = _GiftcardState;
}
