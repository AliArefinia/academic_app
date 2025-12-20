// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$NoteImpl _$$NoteImplFromJson(Map<String, dynamic> json) => _$NoteImpl(
      id: (json['id'] as num).toInt(),
      excerpt: json['text'] as String?,
      userNote: json['description'] as String?,
      name: json['name'] as String?,
      book: json['book'] == null
          ? null
          : NoteBook.fromJson(json['book'] as Map<String, dynamic>),
      createdAt: json['created_at'] as String?,
    );

Map<String, dynamic> _$$NoteImplToJson(_$NoteImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'text': instance.excerpt,
      'description': instance.userNote,
      'name': instance.name,
      'book': instance.book,
      'created_at': instance.createdAt,
    };

_$NoteBookImpl _$$NoteBookImplFromJson(Map<String, dynamic> json) =>
    _$NoteBookImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      image: json['image'] as String?,
      author: json['author'] == null
          ? null
          : NoteAuthor.fromJson(json['author'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$NoteBookImplToJson(_$NoteBookImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'image': instance.image,
      'author': instance.author,
    };

_$NoteAuthorImpl _$$NoteAuthorImplFromJson(Map<String, dynamic> json) =>
    _$NoteAuthorImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      avatar: json['avatar'] as String?,
    );

Map<String, dynamic> _$$NoteAuthorImplToJson(_$NoteAuthorImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'avatar': instance.avatar,
    };
