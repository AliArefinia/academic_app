import 'package:json_annotation/json_annotation.dart';
import 'package:academic/core/error/json_parsing_error_handler.dart';

part 'auth_phone.g.dart';

@JsonSerializable()
class AuthPhoneModel {
  final bool has_password;
  final bool new_user;
  final String? message;
  final bool? is_invited;

  AuthPhoneModel(
      {required this.has_password,
      required this.message,
      required this.new_user,
      this.is_invited});

  factory AuthPhoneModel.fromJson(Map<String, dynamic> json) {
    return JsonParsingErrorHandler.handleParsingError<AuthPhoneModel>(
      modelName: 'AuthPhoneModel',
      json: json,
      parseFunction: () => _$AuthPhoneModelFromJson(json),
    );
  }

  Map<String, dynamic> toJson() => _$AuthPhoneModelToJson(this);
}
