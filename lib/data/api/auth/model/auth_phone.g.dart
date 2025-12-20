// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_phone.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthPhoneModel _$AuthPhoneModelFromJson(Map<String, dynamic> json) =>
    AuthPhoneModel(
      has_password: json['has_password'] as bool,
      message: json['message'] as String?,
      new_user: json['new_user'] as bool,
      is_invited: json['is_invited'] as bool?,
    );

Map<String, dynamic> _$AuthPhoneModelToJson(AuthPhoneModel instance) =>
    <String, dynamic>{
      'has_password': instance.has_password,
      'new_user': instance.new_user,
      'message': instance.message,
      'is_invited': instance.is_invited,
    };
