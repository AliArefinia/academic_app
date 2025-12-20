part of 'get_started_cubit.dart';

@freezed
class GetStartedEvent with _$GetStartedEvent {
  const factory GetStartedEvent.changeLanguage({
    required String selectedLanguage,
  }) = ChangeLanguage;
}
