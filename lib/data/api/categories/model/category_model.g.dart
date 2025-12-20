// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryModel _$CategoryModelFromJson(Map<String, dynamic> json) =>
    CategoryModel(
      id: (json['id'] as num).toInt(),
      parentId: (json['parent_id'] as num?)?.toInt(),
      name: json['title'] as String,
      image: json['icon'] as String?,
      featured: json['featured'] as bool?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );

Map<String, dynamic> _$CategoryModelToJson(CategoryModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'parent_id': instance.parentId,
      'title': instance.name,
      'icon': instance.image,
      'featured': instance.featured,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };

CategoryResponse _$CategoryResponseFromJson(Map<String, dynamic> json) =>
    CategoryResponse(
      mainCategories: (json['main_categories'] as List<dynamic>)
          .map((e) => CategoryModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      featured: (json['featured'] as List<dynamic>)
          .map((e) => CategoryModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      subCategories: (json['sub_categories'] as List<dynamic>?)
          ?.map((e) => CategoryModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CategoryResponseToJson(CategoryResponse instance) =>
    <String, dynamic>{
      'main_categories': instance.mainCategories,
      'featured': instance.featured,
      'sub_categories': instance.subCategories,
    };

CategoryProductsResponse _$CategoryProductsResponseFromJson(
        Map<String, dynamic> json) =>
    CategoryProductsResponse(
      products: (json['products'] as List<dynamic>)
          .map((e) => BookModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CategoryProductsResponseToJson(
        CategoryProductsResponse instance) =>
    <String, dynamic>{
      'products': instance.products,
    };
