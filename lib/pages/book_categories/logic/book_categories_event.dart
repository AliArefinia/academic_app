part of 'book_categories_cubit.dart';

@freezed
class BookcategoriesEvent with _$BookcategoriesEvent {
  const factory BookcategoriesEvent.changeLanguage({
    required String selectedLanguage,
  }) = ChangeLanguage;
}
