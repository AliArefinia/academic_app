import 'package:freezed_annotation/freezed_annotation.dart';

part 'upload_product_state.freezed.dart';

@freezed
class UploadProductState with _$UploadProductState {
  const factory UploadProductState.initial() = _Initial;
  const factory UploadProductState.loading() = _Loading;
  const factory UploadProductState.success(String message) = _Success;
  const factory UploadProductState.error(String message) = _Error;
}

