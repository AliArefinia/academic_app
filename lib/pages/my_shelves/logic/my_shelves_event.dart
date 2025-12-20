part of 'my_shelves_cubit.dart';

@freezed
class MyshelvesEvent with _$MyshelvesEvent {
  const factory MyshelvesEvent.changeLanguage({
    required String selectedLanguage,
  }) = ChangeLanguage;
}
