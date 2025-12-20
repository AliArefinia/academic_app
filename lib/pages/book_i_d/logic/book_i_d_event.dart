part of 'book_i_d_cubit.dart';

@freezed
class BookidEvent with _$BookidEvent {
  const factory BookidEvent.changeLanguage({
    required String selectedLanguage,
  }) = ChangeLanguage;
}
