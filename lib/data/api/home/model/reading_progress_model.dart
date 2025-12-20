import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:academic/data/api/product/model/product_model.dart';

part 'reading_progress_model.freezed.dart';
part 'reading_progress_model.g.dart';

@freezed
class ReadingProgressModel with _$ReadingProgressModel {
  const factory ReadingProgressModel({
    required ProductModel product,
    required double progress,
    required int lastPosition,
    required DateTime lastReadAt,
    String? cachedEpubPath,
  }) = _ReadingProgressModel;

  factory ReadingProgressModel.fromJson(Map<String, dynamic> json) => _$ReadingProgressModelFromJson(json);
} 