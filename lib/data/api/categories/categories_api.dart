import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import 'model/category_model.dart';

part 'categories_api.g.dart';

@RestApi()
@lazySingleton
abstract class CategoriesApi {
  @factoryMethod
  factory CategoriesApi(Dio dio) = _CategoriesApi;

  @GET('/api/categories')
  Future<CategoryResponse> getCategories({
    @Query('query') String? query,
  });

  @GET('/api/categories/{id}/sub-categories')
  Future<CategoryResponse> getSubCategories(@Path('id') int categoryId);

  @GET('/api/categories/{id}')
  Future<CategoryProductsResponse> getCategoryProducts(
    @Path('id') int categoryId, {
    @Query('query') String? query,
    @Query('audio') int? audio,
    @Query('text') int? text,
    @Query('translators') List<int>? translators,
    @Query('authors') List<int>? authors,
    @Query('speakers') List<int>? speakers,
    @Query('publishers') List<int>? publishers,
  });
} 