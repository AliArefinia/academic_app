// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shop_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShopResponse _$ShopResponseFromJson(Map<String, dynamic> json) => ShopResponse(
      pamphlets: json['pamphlets'] == null
          ? null
          : ShopProductSection.fromJson(
              json['pamphlets'] as Map<String, dynamic>),
      educational: json['educational'] == null
          ? null
          : ShopProductSection.fromJson(
              json['educational'] as Map<String, dynamic>),
      questionBank: json['question_bank'] == null
          ? null
          : ShopProductSection.fromJson(
              json['question_bank'] as Map<String, dynamic>),
      periodical: json['periodical'] == null
          ? null
          : ShopProductSection.fromJson(
              json['periodical'] as Map<String, dynamic>),
      quarterly: json['quarterly'] == null
          ? null
          : ShopProductSection.fromJson(
              json['quarterly'] as Map<String, dynamic>),
      monthly: json['monthly'] == null
          ? null
          : ShopProductSection.fromJson(
              json['monthly'] as Map<String, dynamic>),
      yearbook: json['yearbook'] == null
          ? null
          : ShopProductSection.fromJson(
              json['yearbook'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ShopResponseToJson(ShopResponse instance) =>
    <String, dynamic>{
      'pamphlets': instance.pamphlets,
      'educational': instance.educational,
      'question_bank': instance.questionBank,
      'periodical': instance.periodical,
      'quarterly': instance.quarterly,
      'monthly': instance.monthly,
      'yearbook': instance.yearbook,
    };

ShopProductSection _$ShopProductSectionFromJson(Map<String, dynamic> json) =>
    ShopProductSection(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ShopProductSectionToJson(ShopProductSection instance) =>
    <String, dynamic>{
      'data': instance.data,
    };
