// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chapter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ChapterImpl _$$ChapterImplFromJson(Map<String, dynamic> json) =>
    _$ChapterImpl(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      description: json['description'] as String?,
      user: json['user'] == null
          ? null
          : ChapterUser.fromJson(json['user'] as Map<String, dynamic>),
      notesCount: (json['notes_count'] as num?)?.toInt(),
      categoryId: (json['category_id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$ChapterImplToJson(_$ChapterImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'user': instance.user,
      'notes_count': instance.notesCount,
      'category_id': instance.categoryId,
    };

_$ChapterUserImpl _$$ChapterUserImplFromJson(Map<String, dynamic> json) =>
    _$ChapterUserImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      avatar: json['avatar'] as String?,
    );

Map<String, dynamic> _$$ChapterUserImplToJson(_$ChapterUserImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'avatar': instance.avatar,
    };
