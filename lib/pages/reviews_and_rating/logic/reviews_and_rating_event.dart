part of 'reviews_and_rating_cubit.dart';

@freezed
class ReviewsandratingEvent with _$ReviewsandratingEvent {
  const factory ReviewsandratingEvent.changeLanguage({
    required String selectedLanguage,
  }) = ChangeLanguage;
}
