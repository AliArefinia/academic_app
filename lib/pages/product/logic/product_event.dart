part of 'product_cubit.dart';

@freezed
class ProductEvent with _$ProductEvent {
  const factory ProductEvent.changeLanguage({
    required String selectedLanguage,
  }) = ChangeLanguage;
}
