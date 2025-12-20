import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'model/shop_response.dart';

part 'shop_api_service.g.dart';

@lazySingleton
@RestApi()
abstract class ShopApiService {
  @factoryMethod
  factory ShopApiService(Dio dio) = _ShopApiService;

  @GET('/api/shop')
  Future<ShopResponse> getShop({
    @Query('query') String? query,
  });
}

