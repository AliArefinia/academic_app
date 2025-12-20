import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'model/my_purchases_model.dart';

part 'my_purchases_api.g.dart';

@lazySingleton
@RestApi()
abstract class MyPurchasesApi {
  @factoryMethod
  factory MyPurchasesApi(Dio dio) = _MyPurchasesApi;

  @GET('/api/my-purchases')
  Future<MyPurchasesResponse> getMyPurchases();
} 