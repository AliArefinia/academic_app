part of 'my_subscriptions_cubit.dart';

@freezed
class MysubscriptionsEvent with _$MysubscriptionsEvent {
  const factory MysubscriptionsEvent.changeLanguage({
    required String selectedLanguage,
  }) = ChangeLanguage;
}
