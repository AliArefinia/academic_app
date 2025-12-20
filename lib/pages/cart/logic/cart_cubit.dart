import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:academic/data/api/cart/model/cart_model.dart';
import 'package:academic/data/repository/cart_repository.dart';
import 'package:injectable/injectable.dart';

part 'cart_cubit.freezed.dart';
part 'cart_state.dart';

@injectable
class CartCubit extends Cubit<CartState> {
  final ICartRepository _repository;

  CartCubit(this._repository) : super(const CartState.initial());

  Future<void> getCart() async {
    try {
      emit(const CartState.loading());
      final response = await _repository.getCart();
      emit(CartState.success(response.items, response.meta));
    } catch (e) {
      emit(CartState.error('Failed to get cart: $e'));
    }
  }

  Future<void> addToCart(int bookId) async {
    try {
      emit(const CartState.loading());
      final response = await _repository.addToCart(bookId);
      emit(CartState.success(response.items, response.meta));
    } catch (e) {
      emit(CartState.error('Failed to add to cart: $e'));
    }
  }

  Future<void> removeFromCart(int cartItemId) async {
    try {
      emit(const CartState.loading());
      await _repository.removeFromCart(cartItemId);
      final response = await _repository.getCart();
      emit(CartState.success(response.items, response.meta));
    } catch (e) {
      emit(CartState.error('Failed to remove from cart: $e'));
    }
  }

  Future<void> updateQuantity(int cartItemId, int quantity) async {
    try {
      emit(const CartState.loading());
      await _repository.updateQuantity(cartItemId, quantity);
      final response = await _repository.getCart();
      emit(CartState.success(response.items, response.meta));
    } catch (e) {
      emit(CartState.error('Failed to update quantity: $e'));
    }
  }
} 