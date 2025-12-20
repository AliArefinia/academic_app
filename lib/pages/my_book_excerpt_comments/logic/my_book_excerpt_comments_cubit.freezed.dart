// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'my_book_excerpt_comments_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$MyBookExcerptCommentsState {
  bool get isLoading => throw _privateConstructorUsedError;
  List<MyBookExcerptComment> get comments => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $MyBookExcerptCommentsStateCopyWith<MyBookExcerptCommentsState>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MyBookExcerptCommentsStateCopyWith<$Res> {
  factory $MyBookExcerptCommentsStateCopyWith(MyBookExcerptCommentsState value,
          $Res Function(MyBookExcerptCommentsState) then) =
      _$MyBookExcerptCommentsStateCopyWithImpl<$Res,
          MyBookExcerptCommentsState>;
  @useResult
  $Res call(
      {bool isLoading, List<MyBookExcerptComment> comments, String? error});
}

/// @nodoc
class _$MyBookExcerptCommentsStateCopyWithImpl<$Res,
        $Val extends MyBookExcerptCommentsState>
    implements $MyBookExcerptCommentsStateCopyWith<$Res> {
  _$MyBookExcerptCommentsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? comments = null,
    Object? error = freezed,
  }) {
    return _then(_value.copyWith(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      comments: null == comments
          ? _value.comments
          : comments // ignore: cast_nullable_to_non_nullable
              as List<MyBookExcerptComment>,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MyBookExcerptCommentsStateImplCopyWith<$Res>
    implements $MyBookExcerptCommentsStateCopyWith<$Res> {
  factory _$$MyBookExcerptCommentsStateImplCopyWith(
          _$MyBookExcerptCommentsStateImpl value,
          $Res Function(_$MyBookExcerptCommentsStateImpl) then) =
      __$$MyBookExcerptCommentsStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isLoading, List<MyBookExcerptComment> comments, String? error});
}

/// @nodoc
class __$$MyBookExcerptCommentsStateImplCopyWithImpl<$Res>
    extends _$MyBookExcerptCommentsStateCopyWithImpl<$Res,
        _$MyBookExcerptCommentsStateImpl>
    implements _$$MyBookExcerptCommentsStateImplCopyWith<$Res> {
  __$$MyBookExcerptCommentsStateImplCopyWithImpl(
      _$MyBookExcerptCommentsStateImpl _value,
      $Res Function(_$MyBookExcerptCommentsStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? comments = null,
    Object? error = freezed,
  }) {
    return _then(_$MyBookExcerptCommentsStateImpl(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      comments: null == comments
          ? _value._comments
          : comments // ignore: cast_nullable_to_non_nullable
              as List<MyBookExcerptComment>,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$MyBookExcerptCommentsStateImpl implements _MyBookExcerptCommentsState {
  const _$MyBookExcerptCommentsStateImpl(
      {this.isLoading = false,
      final List<MyBookExcerptComment> comments = const [],
      this.error})
      : _comments = comments;

  @override
  @JsonKey()
  final bool isLoading;
  final List<MyBookExcerptComment> _comments;
  @override
  @JsonKey()
  List<MyBookExcerptComment> get comments {
    if (_comments is EqualUnmodifiableListView) return _comments;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_comments);
  }

  @override
  final String? error;

  @override
  String toString() {
    return 'MyBookExcerptCommentsState(isLoading: $isLoading, comments: $comments, error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MyBookExcerptCommentsStateImpl &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            const DeepCollectionEquality().equals(other._comments, _comments) &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isLoading,
      const DeepCollectionEquality().hash(_comments), error);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MyBookExcerptCommentsStateImplCopyWith<_$MyBookExcerptCommentsStateImpl>
      get copyWith => __$$MyBookExcerptCommentsStateImplCopyWithImpl<
          _$MyBookExcerptCommentsStateImpl>(this, _$identity);
}

abstract class _MyBookExcerptCommentsState
    implements MyBookExcerptCommentsState {
  const factory _MyBookExcerptCommentsState(
      {final bool isLoading,
      final List<MyBookExcerptComment> comments,
      final String? error}) = _$MyBookExcerptCommentsStateImpl;

  @override
  bool get isLoading;
  @override
  List<MyBookExcerptComment> get comments;
  @override
  String? get error;
  @override
  @JsonKey(ignore: true)
  _$$MyBookExcerptCommentsStateImplCopyWith<_$MyBookExcerptCommentsStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
