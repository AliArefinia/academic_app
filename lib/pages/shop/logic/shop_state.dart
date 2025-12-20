import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../data/api/shop/model/shop_response.dart';

part 'shop_state.freezed.dart';

@freezed
class ShopState with _$ShopState {
  const factory ShopState.initial() = _Initial;
  const factory ShopState.loading() = _Loading;
  const factory ShopState.success(ShopResponse data) = _Success;
  const factory ShopState.empty() = _Empty;
  const factory ShopState.error(String message) = _Error;
}

