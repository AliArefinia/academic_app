// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentRequest _$PaymentRequestFromJson(Map<String, dynamic> json) =>
    PaymentRequest(
      amount: (json['amount'] as num).toInt(),
      discountCode: json['discount_code'] as String?,
      gatewayName: json['gateway_name'] as String,
      bookIds: (json['book_ids'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList(),
      planId: (json['plan_id'] as num?)?.toInt(),
      type: json['type'] as String,
      mobile: json['mobile'] as String?,
    );

Map<String, dynamic> _$PaymentRequestToJson(PaymentRequest instance) =>
    <String, dynamic>{
      'amount': instance.amount,
      'discount_code': instance.discountCode,
      'gateway_name': instance.gatewayName,
      'book_ids': instance.bookIds,
      'plan_id': instance.planId,
      'type': instance.type,
      'mobile': instance.mobile,
    };

PaymentResponse _$PaymentResponseFromJson(Map<String, dynamic> json) =>
    PaymentResponse(
      redirectUrl: json['redirect_url'] as String,
      paidAmount: (json['paid_amount'] as num).toInt(),
      expireTime: (json['expire_time'] as num).toInt(),
      returnUrl: json['return_url'] as String?,
    );

Map<String, dynamic> _$PaymentResponseToJson(PaymentResponse instance) =>
    <String, dynamic>{
      'redirect_url': instance.redirectUrl,
      'paid_amount': instance.paidAmount,
      'expire_time': instance.expireTime,
      'return_url': instance.returnUrl,
    };

PaymentApiResponse _$PaymentApiResponseFromJson(Map<String, dynamic> json) =>
    PaymentApiResponse(
      status: (json['status'] as num).toInt(),
      message: json['message'] as String,
      data: PaymentResponse.fromJson(json['data'] as Map<String, dynamic>),
      code: (json['code'] as num).toInt(),
    );

Map<String, dynamic> _$PaymentApiResponseToJson(PaymentApiResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
      'code': instance.code,
    };

PaymentTrackingResponse _$PaymentTrackingResponseFromJson(
        Map<String, dynamic> json) =>
    PaymentTrackingResponse(
      status: json['status'] as bool,
      message: json['message'] as String,
    );

Map<String, dynamic> _$PaymentTrackingResponseToJson(
        PaymentTrackingResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
    };

PaymentVerifyRequest _$PaymentVerifyRequestFromJson(
        Map<String, dynamic> json) =>
    PaymentVerifyRequest(
      Authority: json['Authority'] as String,
    );

Map<String, dynamic> _$PaymentVerifyRequestToJson(
        PaymentVerifyRequest instance) =>
    <String, dynamic>{
      'Authority': instance.Authority,
    };

PaymentVerifyResponse _$PaymentVerifyResponseFromJson(
        Map<String, dynamic> json) =>
    PaymentVerifyResponse(
      status: (json['status'] as num).toInt(),
      message: json['message'] as String,
      data: json['data'] == null
          ? null
          : PaymentVerifyData.fromJson(json['data'] as Map<String, dynamic>),
      code: (json['code'] as num).toInt(),
    );

Map<String, dynamic> _$PaymentVerifyResponseToJson(
        PaymentVerifyResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
      'code': instance.code,
    };

PaymentVerifyData _$PaymentVerifyDataFromJson(Map<String, dynamic> json) =>
    PaymentVerifyData(
      id: (json['id'] as num).toInt(),
      orderNumber: json['order_number'] as String,
      userId: (json['user_id'] as num).toInt(),
      discountId: (json['discount_id'] as num?)?.toInt(),
      price: (json['price'] as num).toInt(),
      totalPrice: (json['total_price'] as num).toInt(),
      discountPrice: (json['discount_price'] as num).toInt(),
      status: json['status'] as bool,
      transactionId: json['transaction_id'] as String,
      type: json['type'] as String,
      gatewayName: json['gateway_name'] as String,
      planId: (json['plan_id'] as num?)?.toInt(),
      createdAt: json['created_at'] as String,
      updatedAt: json['updated_at'] as String,
      deletedAt: json['deleted_at'] as String?,
      items: (json['items'] as List<dynamic>)
          .map((e) => PaymentItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PaymentVerifyDataToJson(PaymentVerifyData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'order_number': instance.orderNumber,
      'user_id': instance.userId,
      'discount_id': instance.discountId,
      'price': instance.price,
      'total_price': instance.totalPrice,
      'discount_price': instance.discountPrice,
      'status': instance.status,
      'transaction_id': instance.transactionId,
      'type': instance.type,
      'gateway_name': instance.gatewayName,
      'plan_id': instance.planId,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'deleted_at': instance.deletedAt,
      'items': instance.items,
    };

PaymentItem _$PaymentItemFromJson(Map<String, dynamic> json) => PaymentItem(
      id: (json['id'] as num).toInt(),
      productId: (json['product_id'] as num).toInt(),
      orderId: (json['order_id'] as num).toInt(),
      price: (json['price'] as num).toInt(),
      createdAt: json['created_at'] as String,
      updatedAt: json['updated_at'] as String,
    );

Map<String, dynamic> _$PaymentItemToJson(PaymentItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'product_id': instance.productId,
      'order_id': instance.orderId,
      'price': instance.price,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };
