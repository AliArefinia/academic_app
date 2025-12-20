import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:academic/data/api/subscription/model/user_subscription_model.dart';
import 'package:academic/data/repository/subscription_repository.dart';

part 'my_subscriptions_state.dart';
part 'my_subscriptions_event.dart';
part 'my_subscriptions_cubit.freezed.dart';

@injectable
class MysubscriptionsCubit extends Cubit<MysubscriptionsState> {
  final ISubscriptionRepository _repository;

  MysubscriptionsCubit(this._repository)
      : super(const MysubscriptionsState.initial()) {
    fetchUserSubscriptions();
  }

  Future<void> fetchUserSubscriptions() async {
    try {
      emit(const MysubscriptionsState.loading());
      final activePlans = await _repository.getActivePlans();
      final expiredPlans = await _repository.getExpiredPlans();
      
      // Convert MyPlanModel to UserSubscriptionModel for compatibility
      final allSubscriptions = <UserSubscriptionModel>[];
      
      // Add active plans
      for (final plan in activePlans) {
        allSubscriptions.add(UserSubscriptionModel(
          id: 0, // We don't have ID in the new API
          title: plan.title,
          price: 0, // We don't have price in the new API
          days: 30, // Default to monthly
          purchaseDate: plan.startsAt,
          expiryDate: plan.expiresAt,
          status: plan.status,
          planId: 0, // We don't have planId in the new API
        ));
      }
      
      // Add expired plans
      for (final plan in expiredPlans) {
        allSubscriptions.add(UserSubscriptionModel(
          id: 0, // We don't have ID in the new API
          title: plan.title,
          price: 0, // We don't have price in the new API
          days: 30, // Default to monthly
          purchaseDate: plan.startsAt,
          expiryDate: plan.expiresAt,
          status: plan.status,
          planId: 0, // We don't have planId in the new API
        ));
      }
      
      emit(MysubscriptionsState.loaded(allSubscriptions, selectedIndex: 0));
    } catch (e) {
      emit(MysubscriptionsState.error(e.toString()));
    }
  }

  void selectTab(int index) {
    state.maybeWhen(
      loaded: (subscriptions, selectedIndex) {
        emit(MysubscriptionsState.loaded(subscriptions, selectedIndex: index));
      },
      orElse: () {},
    );
  }

  List<UserSubscriptionModel> getActiveSubscriptions() {
    return state.maybeWhen(
      loaded: (subscriptions, selectedIndex) => subscriptions
          .where((sub) => sub.subscriptionStatus == SubscriptionStatus.active)
          .toList(),
      orElse: () => [],
    );
  }


  List<UserSubscriptionModel> getExpiredSubscriptions() {
    return state.maybeWhen(
      loaded: (subscriptions, selectedIndex) => subscriptions
          .where((sub) => sub.subscriptionStatus == SubscriptionStatus.expired)
          .toList(),
      orElse: () => [],
    );
  }
}
