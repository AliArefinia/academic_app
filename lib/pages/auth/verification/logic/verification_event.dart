part of 'verification_cubit.dart';

@freezed
class VerificationEvent with _$VerificationEvent {
  const factory VerificationEvent.changeLanguage({
    required String selectedLanguage,
  }) = ChangeLanguage;
}
