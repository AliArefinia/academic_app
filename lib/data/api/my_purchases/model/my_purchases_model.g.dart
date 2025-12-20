// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_purchases_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PurchasedBookModel _$PurchasedBookModelFromJson(Map<String, dynamic> json) =>
    PurchasedBookModel(
      id: _toInt(json['id']),
      name: json['name'] as String?,
      image: json['image'] as String?,
    );

Map<String, dynamic> _$PurchasedBookModelToJson(PurchasedBookModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'image': instance.image,
    };

PurchaseItemModel _$PurchaseItemModelFromJson(Map<String, dynamic> json) =>
    PurchaseItemModel(
      id: (json['id'] as num?)?.toInt(),
      trackingCode: json['tracking_code'] as String?,
      date: json['date'] as String?,
      status: json['status'] as String?,
      amount: json['amount'] as String?,
      discountAmount: json['discount_amount'] as String?,
      books: (json['books'] as List<dynamic>?)
          ?.map((e) => PurchasedBookModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PurchaseItemModelToJson(PurchaseItemModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'tracking_code': instance.trackingCode,
      'date': instance.date,
      'status': instance.status,
      'amount': instance.amount,
      'discount_amount': instance.discountAmount,
      'books': instance.books,
    };

MyPurchasesResponse _$MyPurchasesResponseFromJson(Map<String, dynamic> json) =>
    MyPurchasesResponse(
      data: (json['data'] as List<dynamic>)
          .map((e) => PurchaseItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MyPurchasesResponseToJson(
        MyPurchasesResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
    };
