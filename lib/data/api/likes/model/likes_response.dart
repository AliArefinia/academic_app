import 'package:json_annotation/json_annotation.dart';

part 'likes_response.g.dart';

@JsonSerializable()
class LikesResponse {
  final bool liked;

  LikesResponse({required this.liked});

  factory LikesResponse.fromJson(Map<String, dynamic> json) =>
      _$LikesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LikesResponseToJson(this);
} 