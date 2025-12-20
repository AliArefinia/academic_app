part of 'my_comments_main_cubit.dart';

@freezed
class MycommentsmainEvent with _$MycommentsmainEvent {
  const factory MycommentsmainEvent.changeLanguage({
    required String selectedLanguage,
  }) = ChangeLanguage;
}
