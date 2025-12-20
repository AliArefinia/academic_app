// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'study_tour_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StudyTourRequestModel _$StudyTourRequestModelFromJson(
        Map<String, dynamic> json) =>
    StudyTourRequestModel(
      categoryId: (json['category_id'] as num).toInt(),
      title: json['title'] as String,
      description: json['description'] as String,
    );

Map<String, dynamic> _$StudyTourRequestModelToJson(
        StudyTourRequestModel instance) =>
    <String, dynamic>{
      'category_id': instance.categoryId,
      'title': instance.title,
      'description': instance.description,
    };

StudyTourRequestResponse _$StudyTourRequestResponseFromJson(
        Map<String, dynamic> json) =>
    StudyTourRequestResponse(
      status: (json['status'] as num).toInt(),
      message: json['message'] as String,
      data: StudyTourRequestData.fromJson(json['data'] as Map<String, dynamic>),
      code: (json['code'] as num).toInt(),
    );

Map<String, dynamic> _$StudyTourRequestResponseToJson(
        StudyTourRequestResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
      'code': instance.code,
    };

StudyTourRequestData _$StudyTourRequestDataFromJson(
        Map<String, dynamic> json) =>
    StudyTourRequestData(
      title: json['title'] as String,
      category: json['category'] as String,
      description: json['description'] as String,
      answer: json['answer'] as String?,
      books: json['books'] as List<dynamic>,
      status: json['status'] as String,
      createdAt: json['created_at'] as String,
      updatedAt: json['updated_at'] as String,
    );

Map<String, dynamic> _$StudyTourRequestDataToJson(
        StudyTourRequestData instance) =>
    <String, dynamic>{
      'title': instance.title,
      'category': instance.category,
      'description': instance.description,
      'answer': instance.answer,
      'books': instance.books,
      'status': instance.status,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };

StudyTourRequestListResponse _$StudyTourRequestListResponseFromJson(
        Map<String, dynamic> json) =>
    StudyTourRequestListResponse(
      status: (json['status'] as num).toInt(),
      message: json['message'] as String,
      data: StudyTourRequestListData.fromJson(
          json['data'] as Map<String, dynamic>),
      code: (json['code'] as num).toInt(),
    );

Map<String, dynamic> _$StudyTourRequestListResponseToJson(
        StudyTourRequestListResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
      'code': instance.code,
    };

StudyTourRequestListData _$StudyTourRequestListDataFromJson(
        Map<String, dynamic> json) =>
    StudyTourRequestListData(
      list: (json['list'] as List<dynamic>)
          .map((e) => StudyTourRequestData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$StudyTourRequestListDataToJson(
        StudyTourRequestListData instance) =>
    <String, dynamic>{
      'list': instance.list,
    };

StudyTourBook _$StudyTourBookFromJson(Map<String, dynamic> json) =>
    StudyTourBook(
      id: (json['id'] as num).toInt(),
      type: json['type'] as String,
      name: json['name'] as String,
      image: json['image'] as String,
      price: (json['price'] as num).toInt(),
      discountPrice: (json['discount_price'] as num).toInt(),
    );

Map<String, dynamic> _$StudyTourBookToJson(StudyTourBook instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'name': instance.name,
      'image': instance.image,
      'price': instance.price,
      'discount_price': instance.discountPrice,
    };
