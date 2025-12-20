import 'package:json_annotation/json_annotation.dart';
import 'package:academic/core/error/json_parsing_error_handler.dart';

part 'auth_response_model.g.dart';

@JsonSerializable()
class AuthResponse {
  final String token;
  final UserModel user;

  AuthResponse({required this.token, required this.user});

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return JsonParsingErrorHandler.handleParsingError<AuthResponse>(
      modelName: 'AuthResponse',
      json: json,
      parseFunction: () => _$AuthResponseFromJson(json),
    );
  }

  Map<String, dynamic> toJson() => _$AuthResponseToJson(this);
}


@JsonSerializable()
class UserModel {
  final int id;
  final String name;
  final String? phone;
  @JsonKey(name: 'invite_code')
  final String? inviteCode;
  @JsonKey(name: 'created_at')
  final String? createdAt;
  @JsonKey(name: 'updated_at')
  final String? updatedAt;
  @JsonKey(name: 'last_name')
  final String? lastName;
  final String? gender;
  @JsonKey(name: 'date_of_birth')
  final String? dateOfBirth;
  final String? about;
  final String? avatar;

  UserModel({
    required this.id,
    required this.name,
    this.phone,
    this.inviteCode,
    this.createdAt,
    this.updatedAt,
    this.lastName,
    this.gender,
    this.dateOfBirth,
    this.about,
    this.avatar,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return JsonParsingErrorHandler.handleParsingError<UserModel>(
      modelName: 'UserModel',
      json: json,
      parseFunction: () {
        // Support both 'avatar_image' and 'avatar', fallback to empty string
        final avatar = (json['avatar_image'] as String?) ?? (json['avatar'] as String?) ?? '';
        return UserModel(
          id: (json['id'] as num).toInt(),
          name: json['name'] as String,
          phone: json['phone'] as String?,
          inviteCode: json['invite_code'] as String?,
          createdAt: json['created_at'] as String?,
          updatedAt: json['updated_at'] as String?,
          lastName: json['last_name'] as String?,
          gender: json['gender'] as String?,
          dateOfBirth: json['date_of_birth'] as String?,
          about: json['about'] as String?,
          avatar: avatar,
        );
      },
    );
  }

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}