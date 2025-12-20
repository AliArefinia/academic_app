part of 'gift_card_cubit.dart';

@freezed
class GiftcardEvent with _$GiftcardEvent {
  const factory GiftcardEvent.changeLanguage({
    required String selectedLanguage,
  }) = ChangeLanguage;
}
