import 'package:injectable/injectable.dart';
import '../api/subscription/subscription_api.dart';
import '../api/subscription/model/subscription_plan_model.dart';
import '../api/subscription/model/user_subscription_model.dart';
import '../api/subscription/model/my_plan_model.dart' as my_plan;

abstract class ISubscriptionRepository {
  Future<List<SubscriptionPlanModel>> getSubscriptionPlans();
  Future<List<UserSubscriptionModel>> getUserSubscriptions();
  Future<List<my_plan.MyPlanModel>> getActivePlans();
  Future<List<my_plan.MyPlanModel>> getExpiredPlans();
}

@LazySingleton(as: ISubscriptionRepository)
class SubscriptionRepository implements ISubscriptionRepository {
  final SubscriptionApi _api;

  SubscriptionRepository(this._api);

  @override
  Future<List<SubscriptionPlanModel>> getSubscriptionPlans() async {
    final response = await _api.getSubscriptionPlans();
    return response.data;
  }

  @override
  Future<List<UserSubscriptionModel>> getUserSubscriptions() async {
    final response = await _api.getUserSubscriptions();
    return response.data;
  }

  @override
  Future<List<my_plan.MyPlanModel>> getActivePlans() async {
    final response = await _api.getActivePlans();
    return response.data;
  }

  @override
  Future<List<my_plan.MyPlanModel>> getExpiredPlans() async {
    final response = await _api.getExpiredPlans();
    return response.data;
  }
}
