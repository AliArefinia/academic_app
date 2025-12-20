// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_gifts_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyGiftsResponse _$MyGiftsResponseFromJson(Map<String, dynamic> json) =>
    MyGiftsResponse(
      status: (json['status'] as num).toInt(),
      message: json['message'] as String,
      data: (json['data'] as List<dynamic>)
          .map((e) => MyGiftItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      code: (json['code'] as num).toInt(),
    );

Map<String, dynamic> _$MyGiftsResponseToJson(MyGiftsResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
      'code': instance.code,
    };

MyGiftItem _$MyGiftItemFromJson(Map<String, dynamic> json) => MyGiftItem(
      tracking_code: json['tracking_code'] as String,
      amount: (json['amount'] as num).toInt(),
      type: json['type'] as String,
      created_at: json['created_at'] as String,
    );

Map<String, dynamic> _$MyGiftItemToJson(MyGiftItem instance) =>
    <String, dynamic>{
      'tracking_code': instance.tracking_code,
      'amount': instance.amount,
      'type': instance.type,
      'created_at': instance.created_at,
    };
