import 'package:academic/l10n/l10n.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'model/cart_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cart_api.g.dart';

@JsonSerializable()
class DiscountResponseModel {
  final int status;
  final String? message;
  final String? error;
  final int? code;
  final Map<String, dynamic>? data;

  DiscountResponseModel({
    required this.status,
    this.message,
    this.error,
    this.code,
    this.data,
  });

  String get displayMessage => message ?? error ?? l10n.unknownError;

  factory DiscountResponseModel.fromJson(Map<String, dynamic> json) =>
      _$DiscountResponseModelFromJson(json);
  Map<String, dynamic> toJson() => _$DiscountResponseModelToJson(this);
}

@lazySingleton
@RestApi()
abstract class CartApi {
  @factoryMethod
  factory CartApi(Dio dio) = _CartApi;

  @GET('/api/carts')
  Future<CartResponse> getCart();

  @POST('/api/carts/store')
  Future<void> addToCart(@Body() Map<String, dynamic> body);

  @DELETE('/api/carts/{id}')
  Future<void> removeFromCart(@Path('id') int id);

  @PUT('/api/carts/{id}/quantity')
  Future<void> updateQuantity(@Path('id') int id, @Body() Map<String, dynamic> body);

  @POST('/api/discount/check')
  @DioResponseType(ResponseType.json)
  Future<dynamic> applyDiscount(@Body() Map<String, dynamic> body);
} 