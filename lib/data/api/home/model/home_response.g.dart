// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeResponse _$HomeResponseFromJson(Map<String, dynamic> json) => HomeResponse(
      sliders: json['sliders'] == null
          ? null
          : SliderSection.fromJson(json['sliders'] as Map<String, dynamic>),
      banners: json['banners'] == null
          ? null
          : BannerSection.fromJson(json['banners'] as Map<String, dynamic>),
      categories: json['categories'] == null
          ? null
          : CategorySection.fromJson(
              json['categories'] as Map<String, dynamic>),
      audioBooks: json['audio_books'] == null
          ? null
          : BookSection.fromJson(json['audio_books'] as Map<String, dynamic>),
      textBooks: json['text_books'] == null
          ? null
          : BookSection.fromJson(json['text_books'] as Map<String, dynamic>),
      latestProducts: json['latest_products'] == null
          ? null
          : ProductSection.fromJson(
              json['latest_products'] as Map<String, dynamic>),
      offerProducts: json['offer_products'] == null
          ? null
          : ProductSection.fromJson(
              json['offer_products'] as Map<String, dynamic>),
      featuredProducts: json['featured_products'] == null
          ? null
          : ProductSection.fromJson(
              json['featured_products'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$HomeResponseToJson(HomeResponse instance) =>
    <String, dynamic>{
      'sliders': instance.sliders,
      'banners': instance.banners,
      'categories': instance.categories,
      'audio_books': instance.audioBooks,
      'text_books': instance.textBooks,
      'latest_products': instance.latestProducts,
      'offer_products': instance.offerProducts,
      'featured_products': instance.featuredProducts,
    };

SliderSection _$SliderSectionFromJson(Map<String, dynamic> json) =>
    SliderSection(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => SliderModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SliderSectionToJson(SliderSection instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

BannerSection _$BannerSectionFromJson(Map<String, dynamic> json) =>
    BannerSection(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => BannerModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BannerSectionToJson(BannerSection instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

CategorySection _$CategorySectionFromJson(Map<String, dynamic> json) =>
    CategorySection(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => CategoryModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CategorySectionToJson(CategorySection instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

BookSection _$BookSectionFromJson(Map<String, dynamic> json) => BookSection(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => BookModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BookSectionToJson(BookSection instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

ProductSection _$ProductSectionFromJson(Map<String, dynamic> json) =>
    ProductSection(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ProductSectionToJson(ProductSection instance) =>
    <String, dynamic>{
      'data': instance.data,
    };
