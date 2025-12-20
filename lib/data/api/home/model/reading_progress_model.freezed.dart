// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reading_progress_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ReadingProgressModel _$ReadingProgressModelFromJson(Map<String, dynamic> json) {
  return _ReadingProgressModel.fromJson(json);
}

/// @nodoc
mixin _$ReadingProgressModel {
  ProductModel get product => throw _privateConstructorUsedError;
  double get progress => throw _privateConstructorUsedError;
  int get lastPosition => throw _privateConstructorUsedError;
  DateTime get lastReadAt => throw _privateConstructorUsedError;
  String? get cachedEpubPath => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ReadingProgressModelCopyWith<ReadingProgressModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReadingProgressModelCopyWith<$Res> {
  factory $ReadingProgressModelCopyWith(ReadingProgressModel value,
          $Res Function(ReadingProgressModel) then) =
      _$ReadingProgressModelCopyWithImpl<$Res, ReadingProgressModel>;
  @useResult
  $Res call(
      {ProductModel product,
      double progress,
      int lastPosition,
      DateTime lastReadAt,
      String? cachedEpubPath});
}

/// @nodoc
class _$ReadingProgressModelCopyWithImpl<$Res,
        $Val extends ReadingProgressModel>
    implements $ReadingProgressModelCopyWith<$Res> {
  _$ReadingProgressModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? product = null,
    Object? progress = null,
    Object? lastPosition = null,
    Object? lastReadAt = null,
    Object? cachedEpubPath = freezed,
  }) {
    return _then(_value.copyWith(
      product: null == product
          ? _value.product
          : product // ignore: cast_nullable_to_non_nullable
              as ProductModel,
      progress: null == progress
          ? _value.progress
          : progress // ignore: cast_nullable_to_non_nullable
              as double,
      lastPosition: null == lastPosition
          ? _value.lastPosition
          : lastPosition // ignore: cast_nullable_to_non_nullable
              as int,
      lastReadAt: null == lastReadAt
          ? _value.lastReadAt
          : lastReadAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      cachedEpubPath: freezed == cachedEpubPath
          ? _value.cachedEpubPath
          : cachedEpubPath // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ReadingProgressModelImplCopyWith<$Res>
    implements $ReadingProgressModelCopyWith<$Res> {
  factory _$$ReadingProgressModelImplCopyWith(_$ReadingProgressModelImpl value,
          $Res Function(_$ReadingProgressModelImpl) then) =
      __$$ReadingProgressModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {ProductModel product,
      double progress,
      int lastPosition,
      DateTime lastReadAt,
      String? cachedEpubPath});
}

/// @nodoc
class __$$ReadingProgressModelImplCopyWithImpl<$Res>
    extends _$ReadingProgressModelCopyWithImpl<$Res, _$ReadingProgressModelImpl>
    implements _$$ReadingProgressModelImplCopyWith<$Res> {
  __$$ReadingProgressModelImplCopyWithImpl(_$ReadingProgressModelImpl _value,
      $Res Function(_$ReadingProgressModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? product = null,
    Object? progress = null,
    Object? lastPosition = null,
    Object? lastReadAt = null,
    Object? cachedEpubPath = freezed,
  }) {
    return _then(_$ReadingProgressModelImpl(
      product: null == product
          ? _value.product
          : product // ignore: cast_nullable_to_non_nullable
              as ProductModel,
      progress: null == progress
          ? _value.progress
          : progress // ignore: cast_nullable_to_non_nullable
              as double,
      lastPosition: null == lastPosition
          ? _value.lastPosition
          : lastPosition // ignore: cast_nullable_to_non_nullable
              as int,
      lastReadAt: null == lastReadAt
          ? _value.lastReadAt
          : lastReadAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      cachedEpubPath: freezed == cachedEpubPath
          ? _value.cachedEpubPath
          : cachedEpubPath // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ReadingProgressModelImpl implements _ReadingProgressModel {
  const _$ReadingProgressModelImpl(
      {required this.product,
      required this.progress,
      required this.lastPosition,
      required this.lastReadAt,
      this.cachedEpubPath});

  factory _$ReadingProgressModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ReadingProgressModelImplFromJson(json);

  @override
  final ProductModel product;
  @override
  final double progress;
  @override
  final int lastPosition;
  @override
  final DateTime lastReadAt;
  @override
  final String? cachedEpubPath;

  @override
  String toString() {
    return 'ReadingProgressModel(product: $product, progress: $progress, lastPosition: $lastPosition, lastReadAt: $lastReadAt, cachedEpubPath: $cachedEpubPath)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReadingProgressModelImpl &&
            (identical(other.product, product) || other.product == product) &&
            (identical(other.progress, progress) ||
                other.progress == progress) &&
            (identical(other.lastPosition, lastPosition) ||
                other.lastPosition == lastPosition) &&
            (identical(other.lastReadAt, lastReadAt) ||
                other.lastReadAt == lastReadAt) &&
            (identical(other.cachedEpubPath, cachedEpubPath) ||
                other.cachedEpubPath == cachedEpubPath));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, product, progress, lastPosition, lastReadAt, cachedEpubPath);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ReadingProgressModelImplCopyWith<_$ReadingProgressModelImpl>
      get copyWith =>
          __$$ReadingProgressModelImplCopyWithImpl<_$ReadingProgressModelImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ReadingProgressModelImplToJson(
      this,
    );
  }
}

abstract class _ReadingProgressModel implements ReadingProgressModel {
  const factory _ReadingProgressModel(
      {required final ProductModel product,
      required final double progress,
      required final int lastPosition,
      required final DateTime lastReadAt,
      final String? cachedEpubPath}) = _$ReadingProgressModelImpl;

  factory _ReadingProgressModel.fromJson(Map<String, dynamic> json) =
      _$ReadingProgressModelImpl.fromJson;

  @override
  ProductModel get product;
  @override
  double get progress;
  @override
  int get lastPosition;
  @override
  DateTime get lastReadAt;
  @override
  String? get cachedEpubPath;
  @override
  @JsonKey(ignore: true)
  _$$ReadingProgressModelImplCopyWith<_$ReadingProgressModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
