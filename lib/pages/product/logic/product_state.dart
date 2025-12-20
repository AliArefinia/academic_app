part of 'product_cubit.dart';

@freezed
class ProductState with _$ProductState {
  const factory ProductState({
    @Default(0) int personRate,
    @Default('') String selectedUsefulOption,
    @Default(false) bool isLoading,
    @Default(false) bool isBookmarking,
    String? error,
    String? successMessage,
    ProductModel? product,
  }) = _ProductState;
}
