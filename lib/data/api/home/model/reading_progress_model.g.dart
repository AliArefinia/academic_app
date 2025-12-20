// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reading_progress_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ReadingProgressModelImpl _$$ReadingProgressModelImplFromJson(
        Map<String, dynamic> json) =>
    _$ReadingProgressModelImpl(
      product: ProductModel.fromJson(json['product'] as Map<String, dynamic>),
      progress: (json['progress'] as num).toDouble(),
      lastPosition: (json['lastPosition'] as num).toInt(),
      lastReadAt: DateTime.parse(json['lastReadAt'] as String),
      cachedEpubPath: json['cachedEpubPath'] as String?,
    );

Map<String, dynamic> _$$ReadingProgressModelImplToJson(
        _$ReadingProgressModelImpl instance) =>
    <String, dynamic>{
      'product': instance.product,
      'progress': instance.progress,
      'lastPosition': instance.lastPosition,
      'lastReadAt': instance.lastReadAt.toIso8601String(),
      'cachedEpubPath': instance.cachedEpubPath,
    };
