// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_books_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyBooksRootResponse _$MyBooksRootResponseFromJson(Map<String, dynamic> json) =>
    MyBooksRootResponse(
      status: (json['status'] as num?)?.toInt(),
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : MyBooksResponse.fromJson(json['data'] as Map<String, dynamic>),
      code: (json['code'] as num?)?.toInt(),
    );

Map<String, dynamic> _$MyBooksRootResponseToJson(
        MyBooksRootResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
      'code': instance.code,
    };

MyBooksResponse _$MyBooksResponseFromJson(Map<String, dynamic> json) =>
    MyBooksResponse(
      textBooksCount: (json['text_books_count'] as num?)?.toInt(),
      audioBooksCount: (json['audio_books_count'] as num?)?.toInt(),
      list: (json['list'] as List<dynamic>?)
          ?.map((e) => MyBookItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MyBooksResponseToJson(MyBooksResponse instance) =>
    <String, dynamic>{
      'text_books_count': instance.textBooksCount,
      'audio_books_count': instance.audioBooksCount,
      'list': instance.list,
    };

MyBookItem _$MyBookItemFromJson(Map<String, dynamic> json) => MyBookItem(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      image: json['image'] as String?,
      type: json['type'] as String?,
      progressTime: _toIntNullable(json['progress_time']),
      lastPageRead: _toIntNullable(json['last_page_read']),
    );

Map<String, dynamic> _$MyBookItemToJson(MyBookItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'image': instance.image,
      'type': instance.type,
      'progress_time': instance.progressTime,
      'last_page_read': instance.lastPageRead,
    };
