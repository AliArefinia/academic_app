part of 'text_books_cubit.dart';

@freezed
class TextbooksEvent with _$TextbooksEvent {
  const factory TextbooksEvent.changeLanguage({
    required String selectedLanguage,
  }) = ChangeLanguage;
}
