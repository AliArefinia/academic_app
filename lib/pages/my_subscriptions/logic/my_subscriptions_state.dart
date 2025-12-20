part of 'my_subscriptions_cubit.dart';

@freezed
class MysubscriptionsState with _$MysubscriptionsState {
  const factory MysubscriptionsState.initial() = _Initial;
  const factory MysubscriptionsState.loading() = _Loading;
  const factory MysubscriptionsState.loaded(
    List<UserSubscriptionModel> subscriptions, {
    @Default(0) int selectedIndex,
  }) = _Loaded;
  const factory MysubscriptionsState.error(String message) = _Error;
}

