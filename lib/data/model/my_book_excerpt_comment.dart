import 'package:json_annotation/json_annotation.dart';

part 'my_book_excerpt_comment.g.dart';

@JsonSerializable()
class MyBookExcerptComment {
  final int id;
  final String text;
  final String avatar;

  MyBookExcerptComment({
    required this.id,
    required this.text,
    required this.avatar,
  });

  factory MyBookExcerptComment.fromJson(Map<String, dynamic> json) =>
      _$MyBookExcerptCommentFromJson(json);

  Map<String, dynamic> toJson() => _$MyBookExcerptCommentToJson(this);
}

