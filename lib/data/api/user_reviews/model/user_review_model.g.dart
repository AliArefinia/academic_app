// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_review_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserReviewModel _$UserReviewModelFromJson(Map<String, dynamic> json) =>
    UserReviewModel(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      type: json['type'] as String?,
      image: json['image'] as String?,
      authorNames: (json['author_names'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      publisherName: json['publisher_name'] as String?,
      rate: _stringToInt(json['rate']),
      comment: json['comment'] as String?,
    );

Map<String, dynamic> _$UserReviewModelToJson(UserReviewModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'type': instance.type,
      'image': instance.image,
      'author_names': instance.authorNames,
      'publisher_name': instance.publisherName,
      'rate': instance.rate,
      'comment': instance.comment,
    };
