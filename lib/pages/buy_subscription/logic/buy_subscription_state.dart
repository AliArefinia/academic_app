part of 'buy_subscription_cubit.dart';

@freezed
class BuysubscriptionState with _$BuysubscriptionState {
  const factory BuysubscriptionState.initial() = _Initial;
  const factory BuysubscriptionState.loading() = _Loading;
  const factory BuysubscriptionState.loaded(
    List<SubscriptionPlanModel> plans,
    Map<int, bool> expandedItems,
  ) = _Loaded;
  const factory BuysubscriptionState.error(String message) = _Error;
}
