import 'package:json_annotation/json_annotation.dart';
import 'package:academic/core/error/json_parsing_error_handler.dart';

part 'payment_model.g.dart';

enum PaymentType {
  book,
  subscription,
  giftCard,
  wallet;

  String get apiValue {
    switch (this) {
      case PaymentType.book:
        return 'book';
      case PaymentType.subscription:
        return 'subscription';
      case PaymentType.giftCard:
        return 'gift_card';
      case PaymentType.wallet:
        return 'wallet';
    }
  }
}

@JsonSerializable()
class PaymentRequest {
  final int amount;
  @JsonKey(name: 'discount_code')
  final String? discountCode;
  @JsonKey(name: 'gateway_name')
  final String gatewayName;
  @JsonKey(name: 'book_ids')
  final List<int>? bookIds;
  @JsonKey(name: 'plan_id')
  final int? planId;
  final String type;
  final String? mobile;

  PaymentRequest({
    required this.amount,
    this.discountCode,
    required this.gatewayName,
    this.bookIds,
    this.planId,
    required this.type,
    this.mobile,
  });

  factory PaymentRequest.fromJson(Map<String, dynamic> json) {
    return JsonParsingErrorHandler.handleParsingError<PaymentRequest>(
      modelName: 'PaymentRequest',
      json: json,
      parseFunction: () => _$PaymentRequestFromJson(json),
    );
  }

  Map<String, dynamic> toJson() => _$PaymentRequestToJson(this);
}

@JsonSerializable()
class PaymentResponse {
  @JsonKey(name: 'redirect_url')
  final String redirectUrl;
  @JsonKey(name: 'paid_amount')
  final int paidAmount;
  @JsonKey(name: 'expire_time')
  final int expireTime;
  @JsonKey(name: 'return_url')
  final String? returnUrl;

  PaymentResponse({
    required this.redirectUrl,
    required this.paidAmount,
    required this.expireTime,
    this.returnUrl,
  });

  factory PaymentResponse.fromJson(Map<String, dynamic> json) {
    return JsonParsingErrorHandler.handleParsingError<PaymentResponse>(
      modelName: 'PaymentResponse',
      json: json,
      parseFunction: () => _$PaymentResponseFromJson(json),
    );
  }

  Map<String, dynamic> toJson() => _$PaymentResponseToJson(this);
}

@JsonSerializable()
class PaymentApiResponse {
  final int status;
  final String message;
  final PaymentResponse data;
  final int code;

  PaymentApiResponse({
    required this.status,
    required this.message,
    required this.data,
    required this.code,
  });

  factory PaymentApiResponse.fromJson(Map<String, dynamic> json) {
    return JsonParsingErrorHandler.handleParsingError<PaymentApiResponse>(
      modelName: 'PaymentApiResponse',
      json: json,
      parseFunction: () => _$PaymentApiResponseFromJson(json),
    );
  }

  Map<String, dynamic> toJson() => _$PaymentApiResponseToJson(this);
}

@JsonSerializable()
class PaymentTrackingResponse {
  final bool status;
  final String message;

  PaymentTrackingResponse({
    required this.status,
    required this.message,
  });

  factory PaymentTrackingResponse.fromJson(Map<String, dynamic> json) {
    return JsonParsingErrorHandler.handleParsingError<PaymentTrackingResponse>(
      modelName: 'PaymentTrackingResponse',
      json: json,
      parseFunction: () => _$PaymentTrackingResponseFromJson(json),
    );
  }

  Map<String, dynamic> toJson() => _$PaymentTrackingResponseToJson(this);
}

@JsonSerializable()
class PaymentVerifyRequest {
  final String Authority;

  PaymentVerifyRequest({
    required this.Authority,
  });

  factory PaymentVerifyRequest.fromJson(Map<String, dynamic> json) {
    return JsonParsingErrorHandler.handleParsingError<PaymentVerifyRequest>(
      modelName: 'PaymentVerifyRequest',
      json: json,
      parseFunction: () => _$PaymentVerifyRequestFromJson(json),
    );
  }

  Map<String, dynamic> toJson() => _$PaymentVerifyRequestToJson(this);
}

@JsonSerializable()
class PaymentVerifyResponse {
  final int status;
  final String message;
  final PaymentVerifyData? data;
  final int code;

  PaymentVerifyResponse({
    required this.status,
    required this.message,
    this.data,
    required this.code,
  });

  factory PaymentVerifyResponse.fromJson(Map<String, dynamic> json) {
    return JsonParsingErrorHandler.handleParsingError<PaymentVerifyResponse>(
      modelName: 'PaymentVerifyResponse',
      json: json,
      parseFunction: () => _$PaymentVerifyResponseFromJson(json),
    );
  }

  Map<String, dynamic> toJson() => _$PaymentVerifyResponseToJson(this);
}

@JsonSerializable()
class PaymentVerifyData {
  final int id;
  @JsonKey(name: 'order_number')
  final String orderNumber;
  @JsonKey(name: 'user_id')
  final int userId;
  @JsonKey(name: 'discount_id')
  final int? discountId;
  final int price;
  @JsonKey(name: 'total_price')
  final int totalPrice;
  @JsonKey(name: 'discount_price')
  final int discountPrice;
  final bool status;
  @JsonKey(name: 'transaction_id')
  final String transactionId;
  final String type;
  @JsonKey(name: 'gateway_name')
  final String gatewayName;
  @JsonKey(name: 'plan_id')
  final int? planId;
  @JsonKey(name: 'created_at')
  final String createdAt;
  @JsonKey(name: 'updated_at')
  final String updatedAt;
  @JsonKey(name: 'deleted_at')
  final String? deletedAt;
  final List<PaymentItem> items;

  PaymentVerifyData({
    required this.id,
    required this.orderNumber,
    required this.userId,
    this.discountId,
    required this.price,
    required this.totalPrice,
    required this.discountPrice,
    required this.status,
    required this.transactionId,
    required this.type,
    required this.gatewayName,
    this.planId,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.items,
  });

  factory PaymentVerifyData.fromJson(Map<String, dynamic> json) {
    return JsonParsingErrorHandler.handleParsingError<PaymentVerifyData>(
      modelName: 'PaymentVerifyData',
      json: json,
      parseFunction: () => _$PaymentVerifyDataFromJson(json),
    );
  }

  Map<String, dynamic> toJson() => _$PaymentVerifyDataToJson(this);
}

@JsonSerializable()
class PaymentItem {
  final int id;
  @JsonKey(name: 'product_id')
  final int productId;
  @JsonKey(name: 'order_id')
  final int orderId;
  final int price;
  @JsonKey(name: 'created_at')
  final String createdAt;
  @JsonKey(name: 'updated_at')
  final String updatedAt;

  PaymentItem({
    required this.id,
    required this.productId,
    required this.orderId,
    required this.price,
    required this.createdAt,
    required this.updatedAt,
  });

  factory PaymentItem.fromJson(Map<String, dynamic> json) {
    return JsonParsingErrorHandler.handleParsingError<PaymentItem>(
      modelName: 'PaymentItem',
      json: json,
      parseFunction: () => _$PaymentItemFromJson(json),
    );
  }

  Map<String, dynamic> toJson() => _$PaymentItemToJson(this);
}
