part of 'my_comments_cubit.dart';

@freezed
class MycommentsEvent with _$MycommentsEvent {
  const factory MycommentsEvent.changeLanguage({
    required String selectedLanguage,
  }) = ChangeLanguage;
}
