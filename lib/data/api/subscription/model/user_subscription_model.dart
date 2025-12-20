import 'package:json_annotation/json_annotation.dart';
import 'package:academic/core/utils/price_parser.dart';

part 'user_subscription_model.g.dart';

enum SubscriptionStatus {
  active,
  reserved,
  expired;

  String get displayName {
    switch (this) {
      case SubscriptionStatus.active:
        return 'فعال';
      case SubscriptionStatus.reserved:
        return 'رزرو شده';
      case SubscriptionStatus.expired:
        return 'منقضی شده';
    }
  }
}

@JsonSerializable()
class UserSubscriptionModel {
  final int id;
  final String title;
  final int price;
  final int days;
  @JsonKey(name: 'purchase_date')
  final String purchaseDate;
  @JsonKey(name: 'expiry_date')
  final String expiryDate;
  final String status;
  @JsonKey(name: 'plan_id')
  final int planId;

  UserSubscriptionModel({
    required this.id,
    required this.title,
    required this.price,
    required this.days,
    required this.purchaseDate,
    required this.expiryDate,
    required this.status,
    required this.planId,
  });

  factory UserSubscriptionModel.fromJson(Map<String, dynamic> json) =>
      _$UserSubscriptionModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserSubscriptionModelToJson(this);

  /// Get formatted price for display
  String get formattedPrice {
    return PriceParser.formatPrice(price.toDouble());
  }

  /// Get duration text based on days
  String get durationText {
    if (days == 1) return 'روزه';
    if (days < 30) return 'روزه';
    if (days == 30) return 'ماهانه';
    if (days < 365) return 'ماهانه';
    if (days == 365) return 'سالانه';
    return 'روزه';
  }

  /// Get subscription status enum
  SubscriptionStatus get subscriptionStatus {
    switch (status.toLowerCase()) {
      case 'active':
        return SubscriptionStatus.active;
      case 'reserved':
        return SubscriptionStatus.reserved;
      case 'expired':
        return SubscriptionStatus.expired;
      default:
        return SubscriptionStatus.expired;
    }
  }
}

@JsonSerializable()
class UserSubscriptionsResponse {
  final int status;
  final String message;
  final List<UserSubscriptionModel> data;
  final int code;

  UserSubscriptionsResponse({
    required this.status,
    required this.message,
    required this.data,
    required this.code,
  });

  factory UserSubscriptionsResponse.fromJson(Map<String, dynamic> json) =>
      _$UserSubscriptionsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UserSubscriptionsResponseToJson(this);
}
