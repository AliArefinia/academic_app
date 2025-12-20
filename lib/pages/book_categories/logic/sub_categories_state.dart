part of 'sub_categories_cubit.dart';

@freezed
class SubCategoriesState with _$SubCategoriesState {
  const factory SubCategoriesState.initial() = _Initial;
  const factory SubCategoriesState.loading() = _Loading;
  const factory SubCategoriesState.success({required List<CategoryModel> subCategories}) = _Success;
  const factory SubCategoriesState.error(String message) = _Error;
} 