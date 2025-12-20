part of 'payment_history_cubit.dart';

@freezed
class PaymenthistoryEvent with _$PaymenthistoryEvent {
  const factory PaymenthistoryEvent.changeLanguage({
    required String selectedLanguage,
  }) = ChangeLanguage;
}
