import 'package:injectable/injectable.dart';
import '../api/shop/shop_api_service.dart';
import '../api/shop/model/shop_response.dart';
import 'package:dio/dio.dart';

@lazySingleton
class ShopRepository {
  final ShopApiService _apiService;

  ShopRepository(this._apiService);

  Future<ShopResponse> fetchShopData({
    String? query,
  }) async {
    try {
      return await _apiService.getShop(
        query: query,
      );
    } on DioException catch (e) {
      final message = e.response?.data['message']?.toString() ?? 
          e.message ?? 
          'خطا در دریافت اطلاعات بازارچه';
      throw Exception(message);
    } catch (e) {
      throw Exception('خطای غیرمنتظره: ${e.toString()}');
    }
  }
}

