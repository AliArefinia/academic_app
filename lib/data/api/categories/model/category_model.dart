import 'package:json_annotation/json_annotation.dart';
import '../../home/model/book_model.dart';

part 'category_model.g.dart';

@JsonSerializable()
class CategoryModel {
  final int id;
  @JsonKey(name: 'parent_id')
  final int? parentId;
  @JsonKey(name: 'title')
  final String name;
  @JsonKey(name: 'icon')
  final String? image;
  final bool? featured;
  @JsonKey(name: 'created_at')
  final String? createdAt;
  @JsonKey(name: 'updated_at')
  final String? updatedAt;

  CategoryModel({
    required this.id,
    this.parentId,
    required this.name,
    this.image,
    this.featured,
    this.createdAt,
    this.updatedAt,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryModelToJson(this);
}

@JsonSerializable()
class CategoryResponse {
  @JsonKey(name: 'main_categories')
  final List<CategoryModel> mainCategories;
  final List<CategoryModel> featured;
  @JsonKey(name: 'sub_categories')
  final List<CategoryModel>? subCategories;

  CategoryResponse({
    required this.mainCategories,
    required this.featured,
    this.subCategories,
  });

  factory CategoryResponse.fromJson(Map<String, dynamic> json) {
    List<CategoryModel> parseCategoryList(dynamic data) {
      if (data is List) {
        return data.map((e) => CategoryModel.fromJson(e as Map<String, dynamic>)).toList();
      } else if (data is Map) {
        // اگر Map بود و کلید data داشت، مقدار data را به عنوان لیست استفاده کن
        if (data.containsKey('data') && data['data'] is List) {
          return (data['data'] as List).map((e) => CategoryModel.fromJson(e as Map<String, dynamic>)).toList();
        }
        // اگر Map معمولی بود
        return data.values.map((e) => CategoryModel.fromJson(e as Map<String, dynamic>)).toList();
      } else {
        return [];
      }
    }
    return CategoryResponse(
      mainCategories: parseCategoryList(json['main_categories']),
      featured: parseCategoryList(json['featured']),
      subCategories: json['sub_categories'] != null ? parseCategoryList(json['sub_categories']) : null,
    );
  }

  Map<String, dynamic> toJson() => _$CategoryResponseToJson(this);
}

@JsonSerializable()
class CategoryProductsResponse {
  @JsonKey(name: 'products')
  final List<BookModel> products;

  CategoryProductsResponse({required this.products});

  factory CategoryProductsResponse.fromJson(Map<String, dynamic> json) {
    final productsList = json['products'] ?? json['list'] ?? [];
    return CategoryProductsResponse(
      products: (productsList as List)
          .map((e) => BookModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => _$CategoryProductsResponseToJson(this);
} 