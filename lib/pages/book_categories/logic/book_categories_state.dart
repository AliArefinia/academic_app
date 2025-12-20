part of 'book_categories_cubit.dart';

@freezed
class BookcategoriesState with _$BookcategoriesState {
  const factory BookcategoriesState.initial() = _Initial;
  const factory BookcategoriesState.loading() = _Loading;
  const factory BookcategoriesState.success({
    required List<CategoryModel> mainCategories,
    required List<CategoryModel> featuredCategories,
  }) = _Success;
  const factory BookcategoriesState.error(String message) = _Error;
}
