// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_history_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Book _$BookFromJson(Map<String, dynamic> json) => Book(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String?,
      type: json['type'] as String?,
    );

Map<String, dynamic> _$BookToJson(Book instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'type': instance.type,
    };

PaymentHistoryModel _$PaymentHistoryModelFromJson(Map<String, dynamic> json) =>
    PaymentHistoryModel(
      id: (json['id'] as num).toInt(),
      trackingCode: json['tracking_code'] as String?,
      paidAmount: (json['paid_amount'] as num?)?.toInt(),
      gatewayName: json['gateway_name'] as String?,
      discountPercent: (json['discount_percent'] as num?)?.toInt(),
      status: json['status'] as String?,
      date: json['date'] as String?,
      books: _booksFromJson(json['books']),
    );

Map<String, dynamic> _$PaymentHistoryModelToJson(
        PaymentHistoryModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'tracking_code': instance.trackingCode,
      'paid_amount': instance.paidAmount,
      'gateway_name': instance.gatewayName,
      'discount_percent': instance.discountPercent,
      'status': instance.status,
      'date': instance.date,
      'books': instance.books,
    };

PaymentHistoryResponse _$PaymentHistoryResponseFromJson(
        Map<String, dynamic> json) =>
    PaymentHistoryResponse(
      status: (json['status'] as num).toInt(),
      message: json['message'] as String,
      data: (json['data'] as List<dynamic>)
          .map((e) => PaymentHistoryModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      code: (json['code'] as num).toInt(),
    );

Map<String, dynamic> _$PaymentHistoryResponseToJson(
        PaymentHistoryResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
      'code': instance.code,
    };
