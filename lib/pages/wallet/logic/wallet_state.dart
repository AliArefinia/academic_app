part of 'wallet_cubit.dart';

@freezed
class WalletState with _$WalletState {
  const factory WalletState({
    @Default(1) int index,
    @Default(0) int currentMoney,
    @Default(0) int amountOfCharge,
    @Default(false) bool isProcessingPayment,
    @Default(false) bool isPaymentSuccessful,
    String? error,
  }) = _WalletState;
}
