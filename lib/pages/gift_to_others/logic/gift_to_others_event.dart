part of 'gift_to_others_cubit.dart';

@freezed
class GifttoothersEvent with _$GifttoothersEvent {
  const factory GifttoothersEvent.changeLanguage({
    required String selectedLanguage,
  }) = ChangeLanguage;
}
