import 'package:injectable/injectable.dart';
import '../api/cart/cart_api.dart';
import '../api/cart/model/cart_model.dart';
import 'package:dio/dio.dart';

abstract class ICartRepository {
  Future<CartResponse> getCart();
  Future<CartResponse> addToCart(int bookId);
  Future<void> removeFromCart(int cartItemId);
  Future<void> updateQuantity(int cartItemId, int quantity);
  Future<DiscountResponseModel> applyDiscount(String code);
}

@LazySingleton(as: ICartRepository)
class CartRepository implements ICartRepository {
  final CartApi _api;

  CartRepository(this._api);

  @override
  Future<CartResponse> getCart() async {
    try {
      final response = await _api.getCart();
      return response;
    } catch (e) {
      throw Exception('Failed to get cart: $e');
    }
  }

  @override
  Future<CartResponse> addToCart(int bookId) async {
    try {
      await _api.addToCart({'book_id': bookId});
      return await getCart();
    } catch (e) {
      throw Exception('Failed to add to cart: $e');
    }
  }

  @override
  Future<void> removeFromCart(int cartItemId) async {
    try {
      await _api.removeFromCart(cartItemId);
    } catch (e) {
      throw Exception('Failed to remove from cart: $e');
    }
  }

  @override
  Future<void> updateQuantity(int cartItemId, int quantity) async {
    try {
      await _api.updateQuantity(cartItemId, {'quantity': quantity});
    } catch (e) {
      throw Exception('Failed to update quantity: $e');
    }
  }

  @override
  Future<DiscountResponseModel> applyDiscount(String code) async {
    try {
      final response = await _api.applyDiscount({'code': code});
      // The API returns a Map<String, dynamic>, not a Response object. So we parse it directly.
      return DiscountResponseModel.fromJson(response as Map<String, dynamic>);
    } catch (e) {
      throw Exception('Failed to apply discount: $e');
    }
  }
}