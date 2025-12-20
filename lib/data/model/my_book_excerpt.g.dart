// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_book_excerpt.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyBookExcerpt _$MyBookExcerptFromJson(Map<String, dynamic> json) =>
    MyBookExcerpt(
      id: (json['id'] as num).toInt(),
      author: Author.fromJson(json['author'] as Map<String, dynamic>),
      book: Book.fromJson(json['book'] as Map<String, dynamic>),
      text: json['text'] as String,
      likesCount: (json['likes_count'] as num).toInt(),
      commentsCount: (json['comments_count'] as num?)?.toInt(),
      isLiked: json['is_liked'] as bool?,
      date: json['date'] as String?,
    );

Map<String, dynamic> _$MyBookExcerptToJson(MyBookExcerpt instance) =>
    <String, dynamic>{
      'id': instance.id,
      'author': instance.author,
      'book': instance.book,
      'text': instance.text,
      'likes_count': instance.likesCount,
      'comments_count': instance.commentsCount,
      'is_liked': instance.isLiked,
      'date': instance.date,
    };

Author _$AuthorFromJson(Map<String, dynamic> json) => Author(
      name: json['name'] as String,
      avatar: json['avatar'] as String,
    );

Map<String, dynamic> _$AuthorToJson(Author instance) => <String, dynamic>{
      'name': instance.name,
      'avatar': instance.avatar,
    };

Book _$BookFromJson(Map<String, dynamic> json) => Book(
      name: json['name'] as String,
      image: json['image'] as String,
    );

Map<String, dynamic> _$BookToJson(Book instance) => <String, dynamic>{
      'name': instance.name,
      'image': instance.image,
    };
