import 'package:json_annotation/json_annotation.dart';

part 'my_book_excerpt.g.dart';

@JsonSerializable()
class MyBookExcerpt {
  final int id;
  final Author author;
  final Book book;
  final String text;
  @JsonKey(name: 'likes_count')
  final int likesCount;
  @JsonKey(name: 'comments_count')
  final int? commentsCount;
  @JsonKey(name: 'is_liked')
  final bool? isLiked;
  final String? date;

  MyBookExcerpt({
    required this.id,
    required this.author,
    required this.book,
    required this.text,
    required this.likesCount,
    this.commentsCount,
    this.isLiked,
    this.date,
  });

  factory MyBookExcerpt.fromJson(Map<String, dynamic> json) =>
      _$MyBookExcerptFromJson(json);

  Map<String, dynamic> toJson() => _$MyBookExcerptToJson(this);
}

@JsonSerializable()
class Author {
  final String name;
  final String avatar;

  Author({
    required this.name,
    required this.avatar,
  });

  factory Author.fromJson(Map<String, dynamic> json) => _$AuthorFromJson(json);

  Map<String, dynamic> toJson() => _$AuthorToJson(this);
}

@JsonSerializable()
class Book {
  final String name;
  final String image;

  Book({
    required this.name,
    required this.image,
  });

  factory Book.fromJson(Map<String, dynamic> json) => _$BookFromJson(json);

  Map<String, dynamic> toJson() => _$BookToJson(this);
}
