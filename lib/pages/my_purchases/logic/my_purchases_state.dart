import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:academic/data/api/my_purchases/model/my_purchases_model.dart';

part 'my_purchases_state.freezed.dart';

@freezed
class MypurchasesState with _$MypurchasesState {
  const factory MypurchasesState.initial() = _Initial;
  const factory MypurchasesState.loading() = _Loading;
  const factory MypurchasesState.loaded(List<PurchaseItemModel> purchases) = _Loaded;
  const factory MypurchasesState.error(String message) = _Error;
  const factory MypurchasesState.empty() = _Empty;
}
