import 'package:academic/l10n/l10n.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:academic/core/error/json_parsing_error_handler.dart';
import 'package:academic/core/utils/price_parser.dart';

part 'subscription_plan_model.g.dart';

@JsonSerializable()
class SubscriptionPlanModel {
  final int id;
  final String title;
  final int price;
  final int days;

  SubscriptionPlanModel({
    required this.id,
    required this.title,
    required this.price,
    required this.days,
  });

  factory SubscriptionPlanModel.fromJson(Map<String, dynamic> json) {
    return JsonParsingErrorHandler.handleParsingError<SubscriptionPlanModel>(
      modelName: 'SubscriptionPlanModel',
      json: json,
      parseFunction: () => _$SubscriptionPlanModelFromJson(json),
    );
  }

  Map<String, dynamic> toJson() => _$SubscriptionPlanModelToJson(this);

  /// Get formatted price for display
  String get formattedPrice {
    return PriceParser.formatPrice(price.toDouble());
  }

  /// Get duration text based on days
  String get durationText {
    if (days == 1) return l10n.daily;
    if (days < 30) return l10n.daily;
    if (days == 30) return l10n.monthly;
    if (days < 365) return l10n.monthly;
    if (days == 365) return l10n.yearly;
    if (days > 365) return l10n.yearly;
    return l10n.daily;
  }

  /// Get discount percentage (placeholder for future use)
  String get discountPercentage => '0';

  /// Get original price (same as price for now)
  int get originalPrice => price;
}

@JsonSerializable()
class SubscriptionPlansResponse {
  final int status;
  final String message;
  final List<SubscriptionPlanModel> data;
  final int code;

  SubscriptionPlansResponse({
    required this.status,
    required this.message,
    required this.data,
    required this.code,
  });

  factory SubscriptionPlansResponse.fromJson(Map<String, dynamic> json) {
    return JsonParsingErrorHandler.handleParsingError<SubscriptionPlansResponse>(
      modelName: 'SubscriptionPlansResponse',
      json: json,
      parseFunction: () => _$SubscriptionPlansResponseFromJson(json),
    );
  }

  Map<String, dynamic> toJson() => _$SubscriptionPlansResponseToJson(this);
}
