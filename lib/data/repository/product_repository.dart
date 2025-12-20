import 'package:injectable/injectable.dart';
import '../api/product/product_api.dart';
import '../api/product/model/product_model.dart';
import 'package:dio/dio.dart';

abstract class IProductRepository {
  Future<ProductModel> getProduct(int id);
  Future<void> submitReview({
    required int productId,
    required String comment,
    int? rate,
    int? recommendation,
  });
  Future<List<CommentModel>> getUserReviews();
}

@LazySingleton(as: IProductRepository)
class ProductRepository implements IProductRepository {
  final ProductApi _api;
  ProductRepository(this._api);

  @override
  Future<ProductModel> getProduct(int id) async {
    try {
      final response = await _api.getProductRaw(id);
      final data = response['data'] as Map<String, dynamic>? ?? {};
      return ProductModel.fromJson(data);
    } on DioException catch (e) {
      final message = e.response?.data['message']?.toString() ?? 
          e.message ?? 
          'Network error occurred.';
      throw Exception(message);
    } catch (e) {
      throw Exception('Unexpected error: ${e.toString()}');
    }
  }

  @override
  Future<void> submitReview({
    required int productId,
    required String comment,
    int? rate,
    int? recommendation,
  }) async {
    final data = {
      'product_id': productId,
      'comment': comment,
      if (rate != null) 'rate': rate,
      if (recommendation != null) 'recommendation': recommendation,
    };
    await _api.submitReview(data);
  }

  @override
  Future<List<CommentModel>> getUserReviews() async {
    try {
      final response = await _api.getUserReviews();
      final data = response['data'] as List<dynamic>? ?? [];
      return data.map((json) => CommentModel.fromJson(json)).toList();
    } on DioException catch (e) {
      final message = e.response?.data['message']?.toString() ??
          e.message ??
          'Network error occurred.';
      throw Exception(message);
    } catch (e) {
      throw Exception('Unexpected error: ${e.toString()}');
    }
  }
}