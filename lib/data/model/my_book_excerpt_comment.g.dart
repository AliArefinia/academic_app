// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_book_excerpt_comment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyBookExcerptComment _$MyBookExcerptCommentFromJson(
        Map<String, dynamic> json) =>
    MyBookExcerptComment(
      id: (json['id'] as num).toInt(),
      text: json['text'] as String,
      avatar: json['avatar'] as String,
    );

Map<String, dynamic> _$MyBookExcerptCommentToJson(
        MyBookExcerptComment instance) =>
    <String, dynamic>{
      'id': instance.id,
      'text': instance.text,
      'avatar': instance.avatar,
    };
