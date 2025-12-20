import 'package:dio/dio.dart';
import 'package:academic/data/api/subscription/model/my_plan_model.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'model/subscription_plan_model.dart';
import 'model/user_subscription_model.dart';
import 'model/my_plan_model.dart' as my_plan;

part 'subscription_api.g.dart';

@lazySingleton
@RestApi()
abstract class SubscriptionApi {
  @factoryMethod
  factory SubscriptionApi(Dio dio) = _SubscriptionApi;

  @GET('/api/plan')
  Future<SubscriptionPlansResponse> getSubscriptionPlans();

  @GET('/api/user/subscriptions')
  Future<UserSubscriptionsResponse> getUserSubscriptions();

  @GET('/api/my-plans/active')
  Future<my_plan.MyPlansResponse> getActivePlans();

  @GET('/api/my-plans/expired')
  Future<my_plan.MyPlansResponse> getExpiredPlans();
}
