part of 'book_publisher_cubit.dart';

@freezed
class BookpublisherEvent with _$BookpublisherEvent {
  const factory BookpublisherEvent.changeLanguage({
    required String selectedLanguage,
  }) = ChangeLanguage;
}
