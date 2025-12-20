import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
class UserModel with _$UserModel {
  const factory UserModel({
    required int id,
    String? name,
    String? email,
    String? phone,
    @JsonKey(name: 'email_verified_at') String? emailVerifiedAt,
    String? avatar,
    @JsonKey(name: 'invite_code') String? inviteCode,
    @JsonKey(name: 'created_at') required String createdAt,
    @JsonKey(name: 'updated_at') required String updatedAt,
    @JsonKey(name: 'deleted_at') String? deletedAt,
    @JsonKey(name: 'last_name') String? lastName,
    String? gender,
    @JsonKey(name: 'date_of_birth') String? dateOfBirth,
    String? about,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);
} 