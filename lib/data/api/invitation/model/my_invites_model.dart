import 'package:json_annotation/json_annotation.dart';
import 'package:academic/core/error/json_parsing_error_handler.dart';

part 'my_invites_model.g.dart';

@JsonSerializable()
class MyInvitesResponse {
  final int status;
  final String message;
  final List<MyInviteItem> data;
  final int code;

  MyInvitesResponse({
    required this.status,
    required this.message,
    required this.data,
    required this.code,
  });

  factory MyInvitesResponse.fromJson(Map<String, dynamic> json) {
    return JsonParsingErrorHandler.handleParsingError<MyInvitesResponse>(
      modelName: 'MyInvitesResponse',
      json: json,
      parseFunction: () => _$MyInvitesResponseFromJson(json),
    );
  }

  Map<String, dynamic> toJson() => _$MyInvitesResponseToJson(this);
}

@JsonSerializable()
class MyInviteItem {
  final String name;
  final int score;
  final String created_at;

  MyInviteItem({
    required this.name,
    required this.score,
    required this.created_at,
  });

  factory MyInviteItem.fromJson(Map<String, dynamic> json) {
    return JsonParsingErrorHandler.handleParsingError<MyInviteItem>(
      modelName: 'MyInviteItem',
      json: json,
      parseFunction: () => _$MyInviteItemFromJson(json),
    );
  }

  Map<String, dynamic> toJson() => _$MyInviteItemToJson(this);
}
