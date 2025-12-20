import 'package:json_annotation/json_annotation.dart';

part 'payment_history_model.g.dart';

List<Book>? _booksFromJson(dynamic json) {
  if (json == null) return null;
  if (json is! List) return null;
  
  final List<Book> books = [];
  for (var item in json) {
    // Skip empty arrays or non-map items
    if (item is Map<String, dynamic>) {
      try {
        books.add(Book.fromJson(item));
      } catch (e) {
        // Skip invalid book entries
        continue;
      }
    }
  }
  return books.isEmpty ? null : books;
}

@JsonSerializable()
class Book {
  final int id;
  final String? name;
  final String? type;

  Book({required this.id, this.name, this.type});

  factory Book.fromJson(Map<String, dynamic> json) => _$BookFromJson(json);

  Map<String, dynamic> toJson() => _$BookToJson(this);
}

@JsonSerializable()
class PaymentHistoryModel {
  final int id;
  @JsonKey(name: 'tracking_code')
  final String? trackingCode;
  @JsonKey(name: 'paid_amount')
  final int? paidAmount;
  @JsonKey(name: 'gateway_name')
  final String? gatewayName;
  @JsonKey(name: 'discount_percent')
  final int? discountPercent;
  final String? status;
  final String? date;
  @JsonKey(
    name: 'books',
    fromJson: _booksFromJson,
  )
  final List<Book>? books;

  PaymentHistoryModel({
    required this.id,
    this.trackingCode,
    this.paidAmount,
    this.gatewayName,
    this.discountPercent,
    this.status,
    this.date,
    this.books,
  });

  factory PaymentHistoryModel.fromJson(Map<String, dynamic> json) =>
      _$PaymentHistoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentHistoryModelToJson(this);
}

@JsonSerializable()
class PaymentHistoryResponse {
  final int status;
  final String message;
  final List<PaymentHistoryModel> data;
  final int code;

  PaymentHistoryResponse({
    required this.status,
    required this.message,
    required this.data,
    required this.code,
  });

  factory PaymentHistoryResponse.fromJson(Map<String, dynamic> json) =>
      _$PaymentHistoryResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentHistoryResponseToJson(this);
} 