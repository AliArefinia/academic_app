// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartResponse _$CartResponseFromJson(Map<String, dynamic> json) => CartResponse(
      items: (json['items'] as List<dynamic>)
          .map((e) => CartItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      meta: CartMeta.fromJson(json['meta'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CartResponseToJson(CartResponse instance) =>
    <String, dynamic>{
      'items': instance.items,
      'meta': instance.meta,
    };

CartMeta _$CartMetaFromJson(Map<String, dynamic> json) => CartMeta(
      totalAmount: json['total_amount'],
      totalDiscount: json['total_discount'],
      total: (json['total'] as num).toInt(),
      bookIds: json['book_ids'] as List<dynamic>,
    );

Map<String, dynamic> _$CartMetaToJson(CartMeta instance) => <String, dynamic>{
      'total_amount': instance.totalAmount,
      'total_discount': instance.totalDiscount,
      'total': instance.total,
      'book_ids': instance.bookIds,
    };

CartItemModel _$CartItemModelFromJson(Map<String, dynamic> json) =>
    CartItemModel(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      image: json['image'] as String,
      price: (json['price'] as num).toInt(),
      discountPrice: (json['discount_price'] as num?)?.toInt() ?? 0,
      type: json['type'] as String,
      quantity: (json['quantity'] as num).toInt(),
      categories: (json['categories'] as List<dynamic>)
          .map((e) => (e as List<dynamic>).map((e) => e as String).toList())
          .toList(),
      publisher: json['publisher'] as String? ?? '',
    );

Map<String, dynamic> _$CartItemModelToJson(CartItemModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'image': instance.image,
      'price': instance.price,
      'discount_price': instance.discountPrice,
      'type': instance.type,
      'quantity': instance.quantity,
      'categories': instance.categories,
      'publisher': instance.publisher,
    };
