import 'package:injectable/injectable.dart';

import '../api/categories/categories_api.dart';
import '../api/categories/model/category_model.dart';

abstract class ICategoriesRepository {
  Future<CategoryResponse> getCategories({String? query});
  Future<CategoryResponse> getSubCategories(int categoryId);
}

@LazySingleton(as: ICategoriesRepository)
class CategoriesRepository implements ICategoriesRepository {
  final CategoriesApi _api;

  CategoriesRepository(this._api);

  @override
  Future<CategoryResponse> getCategories({String? query}) {
    return _api.getCategories(query: query);
  }

  @override
  Future<CategoryResponse> getSubCategories(int categoryId) {
    return _api.getSubCategories(categoryId);
  }
} 