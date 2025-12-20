import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:academic/data/api/product_request/model/product_request_model.dart';

part 'product_request_api.g.dart';

@RestApi()
@lazySingleton
abstract class ProductRequestApi {
  @factoryMethod
  factory ProductRequestApi(Dio dio) = _ProductRequestApi;

  @POST('/api/product/request')
  Future<ProductRequestResponse> uploadProductRequest(
    @Body() FormData formData,
  );
}

