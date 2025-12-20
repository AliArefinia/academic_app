// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_invites_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyInvitesResponse _$MyInvitesResponseFromJson(Map<String, dynamic> json) =>
    MyInvitesResponse(
      status: (json['status'] as num).toInt(),
      message: json['message'] as String,
      data: (json['data'] as List<dynamic>)
          .map((e) => MyInviteItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      code: (json['code'] as num).toInt(),
    );

Map<String, dynamic> _$MyInvitesResponseToJson(MyInvitesResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
      'code': instance.code,
    };

MyInviteItem _$MyInviteItemFromJson(Map<String, dynamic> json) => MyInviteItem(
      name: json['name'] as String,
      score: (json['score'] as num).toInt(),
      created_at: json['created_at'] as String,
    );

Map<String, dynamic> _$MyInviteItemToJson(MyInviteItem instance) =>
    <String, dynamic>{
      'name': instance.name,
      'score': instance.score,
      'created_at': instance.created_at,
    };
