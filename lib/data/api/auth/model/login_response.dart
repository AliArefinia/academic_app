import 'package:json_annotation/json_annotation.dart';
import 'package:academic/core/error/json_parsing_error_handler.dart';

part 'login_response.g.dart';

@JsonSerializable()
class LoginResponse {
  final String message;
  final String token;
  final User user;

  LoginResponse({
    required this.message,
    required this.token,
    required this.user,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return JsonParsingErrorHandler.handleParsingError<LoginResponse>(
      modelName: 'LoginResponse',
      json: json,
      parseFunction: () => _$LoginResponseFromJson(json),
    );
  }

  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}

@JsonSerializable()
class User {
  final int id;
  final String name;
  final String? email;
  final String phone;
  @JsonKey(name: 'email_verified_at')
  final DateTime? emailVerifiedAt;
  final String? avatar;
  @JsonKey(name: 'invite_code')
  final String? inviteCode;
  final String? locale;
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;
  @JsonKey(name: 'deleted_at')
  final DateTime? deletedAt;

  User({
    required this.id,
    required this.name,
    this.email,
    required this.phone,
    this.emailVerifiedAt,
    this.avatar,
    this.inviteCode,
    this.locale,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return JsonParsingErrorHandler.handleParsingError<User>(
      modelName: 'User',
      json: json,
      parseFunction: () => _$UserFromJson(json),
    );
  }

  Map<String, dynamic> toJson() => _$UserToJson(this);
}