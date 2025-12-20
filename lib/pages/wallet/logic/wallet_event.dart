part of 'wallet_cubit.dart';

@freezed
class WalletEvent with _$WalletEvent {
  const factory WalletEvent.changeLanguage({
    required String selectedLanguage,
  }) = ChangeLanguage;
}
