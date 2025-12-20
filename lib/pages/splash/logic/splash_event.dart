part of 'splash_cubit.dart';

@freezed
class SplashEvent with _$SplashEvent {
  const factory SplashEvent.changeLanguage({
    required String selectedLanguage,
  }) = ChangeLanguage;
}
