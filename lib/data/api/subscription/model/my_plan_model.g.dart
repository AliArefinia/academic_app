// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_plan_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyPlanModel _$MyPlanModelFromJson(Map<String, dynamic> json) => MyPlanModel(
      title: json['title'] as String,
      status: json['status'] as String,
      startsAt: json['starts_at'] as String,
      expiresAt: json['expires_at'] as String,
    );

Map<String, dynamic> _$MyPlanModelToJson(MyPlanModel instance) =>
    <String, dynamic>{
      'title': instance.title,
      'status': instance.status,
      'starts_at': instance.startsAt,
      'expires_at': instance.expiresAt,
    };

MyPlansResponse _$MyPlansResponseFromJson(Map<String, dynamic> json) =>
    MyPlansResponse(
      status: (json['status'] as num).toInt(),
      message: json['message'] as String,
      data: (json['data'] as List<dynamic>)
          .map((e) => MyPlanModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      code: (json['code'] as num).toInt(),
    );

Map<String, dynamic> _$MyPlansResponseToJson(MyPlansResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
      'code': instance.code,
    };
