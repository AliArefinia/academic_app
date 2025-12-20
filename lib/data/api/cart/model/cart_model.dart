import 'package:academic/data/api/home/model/book_model.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:academic/data/api/product/model/product_model.dart';
import 'package:academic/core/error/json_parsing_error_handler.dart';

part 'cart_model.g.dart';

@JsonSerializable()
class CartResponse {
  final List<CartItemModel> items;
  final CartMeta meta;

  CartResponse({required this.items, required this.meta});

  factory CartResponse.fromJson(Map<String, dynamic> json) {
    return JsonParsingErrorHandler.handleParsingError<CartResponse>(
      modelName: 'CartResponse',
      json: json,
      parseFunction: () {
        final data = json['data'] as Map<String, dynamic>;
        final list = data['list'] as List;
        final meta = data['meta'] as Map<String, dynamic>;
        return CartResponse(
          items: list.map((e) => CartItemModel.fromJson(e as Map<String, dynamic>)).toList(),
          meta: CartMeta.fromJson(meta),
        );
      },
    );
  }

  Map<String, dynamic> toJson() => _$CartResponseToJson(this);
}

@JsonSerializable()
class CartMeta {
  @JsonKey(name: 'total_amount')
  final dynamic totalAmount;
  @JsonKey(name: 'total_discount')
  final dynamic totalDiscount;
  final int total;
  @JsonKey(name: 'book_ids')
  final List<dynamic> bookIds;

  CartMeta({
    required this.totalAmount,
    required this.totalDiscount,
    required this.total,
    required this.bookIds,
  });

  factory CartMeta.fromJson(Map<String, dynamic> json) {
    return JsonParsingErrorHandler.handleParsingError<CartMeta>(
      modelName: 'CartMeta',
      json: json,
      parseFunction: () => _$CartMetaFromJson(json),
    );
  }
  Map<String, dynamic> toJson() => _$CartMetaToJson(this);

  bool containsBookId(int bookId) {
    return bookIds.any((id) => id is int ? id == bookId : int.tryParse(id.toString()) == bookId);
  }

  String get formattedTotalAmount {
    if (totalAmount is String) return totalAmount;
    if (totalAmount is int) return totalAmount.toString();
    return '0';
  }

  String get formattedTotalDiscount {
    if (totalDiscount is String) return totalDiscount;
    if (totalDiscount is int) return totalDiscount.toString();
    return '0';
  }
}

@JsonSerializable()
class CartItemModel {
  final int id;
  final String name;
  final String image;
  final int price;
  @JsonKey(name: 'discount_price', defaultValue: 0)
  final int discountPrice;
  final String type;
  final int quantity;
  final List<List<String>> categories;
  @JsonKey(name: 'publisher', defaultValue: '')
  final String publisher;

  CartItemModel({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    required this.discountPrice,
    required this.type,
    required this.quantity,
    required this.categories,
    required this.publisher,
  });

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return JsonParsingErrorHandler.handleParsingError<CartItemModel>(
      modelName: 'CartItemModel',
      json: json,
      parseFunction: () => _$CartItemModelFromJson(json),
    );
  }
  Map<String, dynamic> toJson() => _$CartItemModelToJson(this);
} 