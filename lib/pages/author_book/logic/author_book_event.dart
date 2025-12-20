part of 'author_book_cubit.dart';

@freezed
class AuthorbookEvent with _$AuthorbookEvent {
  const factory AuthorbookEvent.changeLanguage({
    required String selectedLanguage,
  }) = ChangeLanguage;
}
