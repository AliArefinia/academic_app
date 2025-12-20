part of 'buy_subscription_cubit.dart';

@freezed
class BuysubscriptionEvent with _$BuysubscriptionEvent {
  const factory BuysubscriptionEvent.changeLanguage({
    required String selectedLanguage,
  }) = ChangeLanguage;
}
