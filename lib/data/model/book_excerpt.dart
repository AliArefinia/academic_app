import 'package:freezed_annotation/freezed_annotation.dart';

part 'book_excerpt.freezed.dart';
part 'book_excerpt.g.dart';

@freezed
class BookExcerpt with _$BookExcerpt {
  const factory BookExcerpt({
    required int id,
    required String text,
    required Book book,
    required Author author,
    @JsonKey(name: 'likes_count') int? likesCount,
    @JsonKey(name: 'comments_count') int? commentsCount,
    @JsonKey(name: 'is_liked') bool? isLiked,
    @JsonKey(name: 'is_bookmarked') bool? isBookmarked,
    String? date,
  }) = _BookExcerpt;

  factory BookExcerpt.fromJson(Map<String, dynamic> json) =>
      _$BookExcerptFromJson(json);
}

@freezed
class Book with _$Book {
  const factory Book({
    int? id,
    required String name,
    required String image,
    String? category,
    @JsonKey(name: 'avg_rate') int? avgRate,
  }) = _Book;

  factory Book.fromJson(Map<String, dynamic> json) => _$BookFromJson(json);
}

@freezed
class Author with _$Author {
  const factory Author({
    int? id,
    required String name,
    required String avatar,
  }) = _Author;

  factory Author.fromJson(Map<String, dynamic> json) => _$AuthorFromJson(json);
}
