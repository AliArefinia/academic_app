// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CommentModelImpl _$$CommentModelImplFromJson(Map<String, dynamic> json) =>
    _$CommentModelImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      type: json['type'] as String,
      image: json['image'] as String,
      author_names: (json['author_names'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      publisher_name: json['publisher_name'] as String,
      rate: json['rate'] as String,
    );

Map<String, dynamic> _$$CommentModelImplToJson(_$CommentModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'type': instance.type,
      'image': instance.image,
      'author_names': instance.author_names,
      'publisher_name': instance.publisher_name,
      'rate': instance.rate,
    };
