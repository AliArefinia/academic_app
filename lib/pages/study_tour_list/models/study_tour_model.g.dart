// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'study_tour_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StudyTourModel _$StudyTourModelFromJson(Map<String, dynamic> json) =>
    StudyTourModel(
      title: json['title'] as String,
      category: json['category'] as String,
      description: json['description'] as String,
      answer: json['answer'] as String?,
      books: (json['books'] as List<dynamic>)
          .map((e) => StudyTourBook.fromJson(e as Map<String, dynamic>))
          .toList(),
      status: json['status'] as String,
      createdAt: json['created_at'] as String,
      updatedAt: json['updated_at'] as String,
    );

Map<String, dynamic> _$StudyTourModelToJson(StudyTourModel instance) =>
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
