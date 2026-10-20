import 'package:academic/l10n/l10n.dart';
import 'package:json_annotation/json_annotation.dart';

part 'my_plan_model.g.dart';

@JsonSerializable()
class MyPlanModel {
  final String title;
  final String status;
  @JsonKey(name: 'starts_at')
  final String startsAt;
  @JsonKey(name: 'expires_at')
  final String expiresAt;

  MyPlanModel({
    required this.title,
    required this.status,
    required this.startsAt,
    required this.expiresAt,
  });

  factory MyPlanModel.fromJson(Map<String, dynamic> json) =>
      _$MyPlanModelFromJson(json);

  Map<String, dynamic> toJson() => _$MyPlanModelToJson(this);

  /// Get subscription status enum
  SubscriptionStatus get subscriptionStatus {
    switch (status.toLowerCase()) {
      case 'active':
        return SubscriptionStatus.active;
      case 'expired':
        return SubscriptionStatus.expired;
      default:
        return SubscriptionStatus.expired;
    }
  }
}

enum SubscriptionStatus {
  active,
  expired;

  String get displayName {
    switch (this) {
      case SubscriptionStatus.active:
        return l10n.active;
      case SubscriptionStatus.expired:
        return l10n.expiredStatus;
    }
  }
}

@JsonSerializable()
class MyPlansResponse {
  final int status;
  final String message;
  final List<MyPlanModel> data;
  final int code;

  MyPlansResponse({
    required this.status,
    required this.message,
    required this.data,
    required this.code,
  });

  factory MyPlansResponse.fromJson(Map<String, dynamic> json) =>
      _$MyPlansResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MyPlansResponseToJson(this);
}
