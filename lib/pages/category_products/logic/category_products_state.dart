part of 'category_products_cubit.dart';

@freezed
class CategoryProductsState with _$CategoryProductsState {
  const factory CategoryProductsState.initial() = _Initial;
  const factory CategoryProductsState.loading() = _Loading;
  const factory CategoryProductsState.success({required List<BookModel> products}) = _Success;
  const factory CategoryProductsState.error(String message) = _Error;
} 