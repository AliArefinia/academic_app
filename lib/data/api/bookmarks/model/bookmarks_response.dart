import 'package:json_annotation/json_annotation.dart';

part 'bookmarks_response.g.dart';

@JsonSerializable()
class BookmarksResponse {
  final bool bookmarked;

  BookmarksResponse({required this.bookmarked});

  factory BookmarksResponse.fromJson(Map<String, dynamic> json) =>
      _$BookmarksResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BookmarksResponseToJson(this);
} 