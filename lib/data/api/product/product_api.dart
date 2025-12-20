import 'package:dio/dio.dart';
import 'package:academic/data/api/product/model/product_model.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'product_api.g.dart';

@lazySingleton
@RestApi()
abstract class ProductApi {
  @factoryMethod
  factory ProductApi(Dio dio) = _ProductApi;

  @GET('/api/products/{id}')
  Future<dynamic> getProductRaw(@Path('id') int id);

  @POST('/api/reviews/store')
  Future<void> submitReview(@Body() Map<String, dynamic> body);

  @GET('/api/reviews')
  Future<dynamic> getUserReviews();
}

extension ProductApiExtension on ProductApi {
  Future<ProductModel> getProductWithData(int id) async {
    final response = await getProductRaw(id);
    return ProductModel.fromJson(response['data']);
  }
}