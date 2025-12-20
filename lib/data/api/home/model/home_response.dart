import 'package:academic/data/api/home/model/slider_model.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:academic/core/error/json_parsing_error_handler.dart';

import 'banner_model.dart';
import 'book_model.dart';
import 'category_model.dart';
import 'package:academic/data/api/product/model/product_model.dart';

part 'home_response.g.dart';

@JsonSerializable()
class HomeResponse {
  final SliderSection? sliders;
  final BannerSection? banners;
  final CategorySection? categories;
  @JsonKey(name: 'audio_books')
  final BookSection? audioBooks;
  @JsonKey(name: 'text_books')
  final BookSection? textBooks;
  @JsonKey(name: 'latest_products')
  final ProductSection? latestProducts;
  @JsonKey(name: 'offer_products')
  final ProductSection? offerProducts;
  @JsonKey(name: 'featured_products')
  final ProductSection? featuredProducts;

  HomeResponse({
    this.sliders,
    this.banners,
    this.categories,
    this.audioBooks,
    this.textBooks,
    this.latestProducts,
    this.offerProducts,
    this.featuredProducts,
  });

  factory HomeResponse.fromJson(Map<String, dynamic> json) {
    return JsonParsingErrorHandler.handleParsingError<HomeResponse>(
      modelName: 'HomeResponse',
      json: json,
      parseFunction: () => _$HomeResponseFromJson(json),
    );
  }

  Map<String, dynamic> toJson() => _$HomeResponseToJson(this);
}

@JsonSerializable()
class SliderSection {
  final List<SliderModel>? data;

  SliderSection({this.data});

  factory SliderSection.fromJson(Map<String, dynamic> json) {
    return JsonParsingErrorHandler.handleParsingError<SliderSection>(
      modelName: 'SliderSection',
      json: json,
      parseFunction: () => _$SliderSectionFromJson(json),
    );
  }

  Map<String, dynamic> toJson() => _$SliderSectionToJson(this);
}

@JsonSerializable()
class BannerSection {
  final List<BannerModel>? data;

  BannerSection({this.data});

  factory BannerSection.fromJson(Map<String, dynamic> json) {
    return JsonParsingErrorHandler.handleParsingError<BannerSection>(
      modelName: 'BannerSection',
      json: json,
      parseFunction: () => _$BannerSectionFromJson(json),
    );
  }

  Map<String, dynamic> toJson() => _$BannerSectionToJson(this);
}

@JsonSerializable()
class CategorySection {
  final List<CategoryModel>? data;

  CategorySection({this.data});

  factory CategorySection.fromJson(Map<String, dynamic> json) {
    return JsonParsingErrorHandler.handleParsingError<CategorySection>(
      modelName: 'CategorySection',
      json: json,
      parseFunction: () => _$CategorySectionFromJson(json),
    );
  }

  Map<String, dynamic> toJson() => _$CategorySectionToJson(this);
}

@JsonSerializable()
class BookSection {
  final List<BookModel>? data;

  BookSection({this.data});

  factory BookSection.fromJson(Map<String, dynamic> json) {
    return JsonParsingErrorHandler.handleParsingError<BookSection>(
      modelName: 'BookSection',
      json: json,
      parseFunction: () => _$BookSectionFromJson(json),
    );
  }

  Map<String, dynamic> toJson() => _$BookSectionToJson(this);
}

@JsonSerializable()
class ProductSection {
  final List<ProductModel>? data;

  ProductSection({this.data});

  factory ProductSection.fromJson(Map<String, dynamic> json) {
    return JsonParsingErrorHandler.handleParsingError<ProductSection>(
      modelName: 'ProductSection',
      json: json,
      parseFunction: () => _$ProductSectionFromJson(json),
    );
  }

  Map<String, dynamic> toJson() => _$ProductSectionToJson(this);
}
