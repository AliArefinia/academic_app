// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_excerpt.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BookExcerptImpl _$$BookExcerptImplFromJson(Map<String, dynamic> json) =>
    _$BookExcerptImpl(
      id: (json['id'] as num).toInt(),
      text: json['text'] as String,
      book: Book.fromJson(json['book'] as Map<String, dynamic>),
      author: Author.fromJson(json['author'] as Map<String, dynamic>),
      likesCount: (json['likes_count'] as num?)?.toInt(),
      commentsCount: (json['comments_count'] as num?)?.toInt(),
      isLiked: json['is_liked'] as bool?,
      isBookmarked: json['is_bookmarked'] as bool?,
      date: json['date'] as String?,
    );

Map<String, dynamic> _$$BookExcerptImplToJson(_$BookExcerptImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'text': instance.text,
      'book': instance.book,
      'author': instance.author,
      'likes_count': instance.likesCount,
      'comments_count': instance.commentsCount,
      'is_liked': instance.isLiked,
      'is_bookmarked': instance.isBookmarked,
      'date': instance.date,
    };

_$BookImpl _$$BookImplFromJson(Map<String, dynamic> json) => _$BookImpl(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String,
      image: json['image'] as String,
      category: json['category'] as String?,
      avgRate: (json['avg_rate'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$BookImplToJson(_$BookImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'image': instance.image,
      'category': instance.category,
      'avg_rate': instance.avgRate,
    };

_$AuthorImpl _$$AuthorImplFromJson(Map<String, dynamic> json) => _$AuthorImpl(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String,
      avatar: json['avatar'] as String,
    );

Map<String, dynamic> _$$AuthorImplToJson(_$AuthorImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'avatar': instance.avatar,
    };
