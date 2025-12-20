// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookModel _$BookModelFromJson(Map<String, dynamic> json) => BookModel(
      id: _toStr(json['id']),
      type: json['type'] as String?,
      name: json['name'] as String?,
      image: json['image'] as String?,
      author: json['author'] == null
          ? null
          : PersonModel.fromJson(json['author'] as Map<String, dynamic>),
      publisher: json['publisher'] as String?,
      publisherId: _toInt(json['publisher_id']),
      translator: json['translator'] as String?,
      audioTime: json['audioTime'] as String?,
      content: json['content'] as String?,
      price: _toDouble(json['price']),
      discountPrice: _toDouble(json['discount_price']),
      peopleRates: _toDouble(json['peopleRates']),
      numOfPeopleRates: _toInt(json['numOfPeopleRates']),
    );

Map<String, dynamic> _$BookModelToJson(BookModel instance) => <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'name': instance.name,
      'image': instance.image,
      'author': instance.author,
      'publisher': instance.publisher,
      'publisher_id': instance.publisherId,
      'translator': instance.translator,
      'audioTime': instance.audioTime,
      'content': instance.content,
      'price': instance.price,
      'discount_price': instance.discountPrice,
      'peopleRates': instance.peopleRates,
      'numOfPeopleRates': instance.numOfPeopleRates,
    };
