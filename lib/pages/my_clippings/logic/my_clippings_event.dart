part of 'my_clippings_cubit.dart';

@freezed
class MyclippingsEvent with _$MyclippingsEvent {
  const factory MyclippingsEvent.changeLanguage({
    required String selectedLanguage,
  }) = ChangeLanguage;
}
