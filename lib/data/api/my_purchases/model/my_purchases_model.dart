import 'package:json_annotation/json_annotation.dart';
import 'package:academic/core/error/json_parsing_error_handler.dart';

part 'my_purchases_model.g.dart';

// Helper functions (assuming they are defined elsewhere or will be added)
String _toStr(dynamic value) {
  if (value == null) return ''; // Return empty string for null
  return value.toString();
}

int _toInt(dynamic value) {
  if (value == null) return 0; // Return 0 for null
  if (value is int) return value;
  if (value is String) return int.tryParse(value) ?? 0; // Return 0 for null or parse error
  if (value is double) return value.toInt();
  return 0; // Return 0 for other types
}

@JsonSerializable()
class PurchasedBookModel {
  @JsonKey(fromJson: _toInt) // Use the helper for potential null int
  final int? id;
  final String? name;
  final String? image;

  PurchasedBookModel({
    this.id,
    this.name,
    this.image,
  });

  factory PurchasedBookModel.fromJson(Map<String, dynamic> json) {
    return JsonParsingErrorHandler.handleParsingError<PurchasedBookModel>(
      modelName: 'PurchasedBookModel',
      json: json,
      parseFunction: () => _$PurchasedBookModelFromJson(json),
    );
  }

  Map<String, dynamic> toJson() => _$PurchasedBookModelToJson(this);
}

@JsonSerializable()
class PurchaseItemModel {
  // Updated based on API response structure
  final int? id; // Assuming id is present and nullable
  @JsonKey(name: 'tracking_code')
  final String? trackingCode;
  final String? date;
  final String? status; // Assuming status is a string
  final String? amount;
  @JsonKey(name: 'discount_amount')
  final String? discountAmount;
  final List<PurchasedBookModel>? books; // Added books list

  PurchaseItemModel({
    this.id,
    this.trackingCode,
    this.date,
    this.status,
    this.amount,
    this.discountAmount,
    this.books,
  });

  factory PurchaseItemModel.fromJson(Map<String, dynamic> json) {
    return JsonParsingErrorHandler.handleParsingError<PurchaseItemModel>(
      modelName: 'PurchaseItemModel',
      json: json,
      parseFunction: () => _$PurchaseItemModelFromJson(json),
    );
  }

  Map<String, dynamic> toJson() => _$PurchaseItemModelToJson(this);
}

@JsonSerializable()
class MyPurchasesResponse {
  final List<PurchaseItemModel> data;

  MyPurchasesResponse({required this.data});

  factory MyPurchasesResponse.fromJson(Map<String, dynamic> json) {
    return JsonParsingErrorHandler.handleParsingError<MyPurchasesResponse>(
      modelName: 'MyPurchasesResponse',
      json: json,
      parseFunction: () => _$MyPurchasesResponseFromJson(json),
    );
  }

  Map<String, dynamic> toJson() => _$MyPurchasesResponseToJson(this);
} 