part of 'cart_cubit.dart';

@freezed
class CartState with _$CartState {
  const factory CartState.initial() = _Initial;
  const factory CartState.loading() = _Loading;
  const factory CartState.success(List<CartItemModel> items, CartMeta meta) = _Success;
  const factory CartState.error(String message) = _Error;
}

@freezed
class DiscountState with _$DiscountState {
  const factory DiscountState.initial() = _DiscountInitial;
  const factory DiscountState.validating() = _DiscountValidating;
  const factory DiscountState.valid(String message) = _DiscountValid;
  const factory DiscountState.invalid(String message) = _DiscountInvalid;
} 