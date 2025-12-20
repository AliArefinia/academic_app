// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_subscription_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserSubscriptionModel _$UserSubscriptionModelFromJson(
        Map<String, dynamic> json) =>
    UserSubscriptionModel(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      price: (json['price'] as num).toInt(),
      days: (json['days'] as num).toInt(),
      purchaseDate: json['purchase_date'] as String,
      expiryDate: json['expiry_date'] as String,
      status: json['status'] as String,
      planId: (json['plan_id'] as num).toInt(),
    );

Map<String, dynamic> _$UserSubscriptionModelToJson(
        UserSubscriptionModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'price': instance.price,
      'days': instance.days,
      'purchase_date': instance.purchaseDate,
      'expiry_date': instance.expiryDate,
      'status': instance.status,
      'plan_id': instance.planId,
    };

UserSubscriptionsResponse _$UserSubscriptionsResponseFromJson(
        Map<String, dynamic> json) =>
    UserSubscriptionsResponse(
      status: (json['status'] as num).toInt(),
      message: json['message'] as String,
      data: (json['data'] as List<dynamic>)
          .map((e) => UserSubscriptionModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      code: (json['code'] as num).toInt(),
    );

Map<String, dynamic> _$UserSubscriptionsResponseToJson(
        UserSubscriptionsResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
      'code': instance.code,
    };
