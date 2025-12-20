// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'book_tour_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$BooktourState {
  List<BookExcerpt> get bookExcerpts => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;
  String get currentChip => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $BooktourStateCopyWith<BooktourState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BooktourStateCopyWith<$Res> {
  factory $BooktourStateCopyWith(
          BooktourState value, $Res Function(BooktourState) then) =
      _$BooktourStateCopyWithImpl<$Res, BooktourState>;
  @useResult
  $Res call(
      {List<BookExcerpt> bookExcerpts,
      bool isLoading,
      String? error,
      String currentChip});
}

/// @nodoc
class _$BooktourStateCopyWithImpl<$Res, $Val extends BooktourState>
    implements $BooktourStateCopyWith<$Res> {
  _$BooktourStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? bookExcerpts = null,
    Object? isLoading = null,
    Object? error = freezed,
    Object? currentChip = null,
  }) {
    return _then(_value.copyWith(
      bookExcerpts: null == bookExcerpts
          ? _value.bookExcerpts
          : bookExcerpts // ignore: cast_nullable_to_non_nullable
              as List<BookExcerpt>,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
      currentChip: null == currentChip
          ? _value.currentChip
          : currentChip // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BooktourStateImplCopyWith<$Res>
    implements $BooktourStateCopyWith<$Res> {
  factory _$$BooktourStateImplCopyWith(
          _$BooktourStateImpl value, $Res Function(_$BooktourStateImpl) then) =
      __$$BooktourStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<BookExcerpt> bookExcerpts,
      bool isLoading,
      String? error,
      String currentChip});
}

/// @nodoc
class __$$BooktourStateImplCopyWithImpl<$Res>
    extends _$BooktourStateCopyWithImpl<$Res, _$BooktourStateImpl>
    implements _$$BooktourStateImplCopyWith<$Res> {
  __$$BooktourStateImplCopyWithImpl(
      _$BooktourStateImpl _value, $Res Function(_$BooktourStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? bookExcerpts = null,
    Object? isLoading = null,
    Object? error = freezed,
    Object? currentChip = null,
  }) {
    return _then(_$BooktourStateImpl(
      bookExcerpts: null == bookExcerpts
          ? _value._bookExcerpts
          : bookExcerpts // ignore: cast_nullable_to_non_nullable
              as List<BookExcerpt>,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
      currentChip: null == currentChip
          ? _value.currentChip
          : currentChip // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$BooktourStateImpl implements _BooktourState {
  const _$BooktourStateImpl(
      {final List<BookExcerpt> bookExcerpts = const [],
      this.isLoading = false,
      this.error,
      this.currentChip = 'همه'})
      : _bookExcerpts = bookExcerpts;

  final List<BookExcerpt> _bookExcerpts;
  @override
  @JsonKey()
  List<BookExcerpt> get bookExcerpts {
    if (_bookExcerpts is EqualUnmodifiableListView) return _bookExcerpts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_bookExcerpts);
  }

  @override
  @JsonKey()
  final bool isLoading;
  @override
  final String? error;
  @override
  @JsonKey()
  final String currentChip;

  @override
  String toString() {
    return 'BooktourState(bookExcerpts: $bookExcerpts, isLoading: $isLoading, error: $error, currentChip: $currentChip)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BooktourStateImpl &&
            const DeepCollectionEquality()
                .equals(other._bookExcerpts, _bookExcerpts) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.currentChip, currentChip) ||
                other.currentChip == currentChip));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_bookExcerpts),
      isLoading,
      error,
      currentChip);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BooktourStateImplCopyWith<_$BooktourStateImpl> get copyWith =>
      __$$BooktourStateImplCopyWithImpl<_$BooktourStateImpl>(this, _$identity);
}

abstract class _BooktourState implements BooktourState {
  const factory _BooktourState(
      {final List<BookExcerpt> bookExcerpts,
      final bool isLoading,
      final String? error,
      final String currentChip}) = _$BooktourStateImpl;

  @override
  List<BookExcerpt> get bookExcerpts;
  @override
  bool get isLoading;
  @override
  String? get error;
  @override
  String get currentChip;
  @override
  @JsonKey(ignore: true)
  _$$BooktourStateImplCopyWith<_$BooktourStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$BooktourEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() fetchBookExcerpts,
    required TResult Function(String chip) onChipTap,
    required TResult Function(int bookExcerptId) toggleLike,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? fetchBookExcerpts,
    TResult? Function(String chip)? onChipTap,
    TResult? Function(int bookExcerptId)? toggleLike,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? fetchBookExcerpts,
    TResult Function(String chip)? onChipTap,
    TResult Function(int bookExcerptId)? toggleLike,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_FetchBookExcerpts value) fetchBookExcerpts,
    required TResult Function(_OnChipTap value) onChipTap,
    required TResult Function(_ToggleLike value) toggleLike,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_FetchBookExcerpts value)? fetchBookExcerpts,
    TResult? Function(_OnChipTap value)? onChipTap,
    TResult? Function(_ToggleLike value)? toggleLike,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_FetchBookExcerpts value)? fetchBookExcerpts,
    TResult Function(_OnChipTap value)? onChipTap,
    TResult Function(_ToggleLike value)? toggleLike,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BooktourEventCopyWith<$Res> {
  factory $BooktourEventCopyWith(
          BooktourEvent value, $Res Function(BooktourEvent) then) =
      _$BooktourEventCopyWithImpl<$Res, BooktourEvent>;
}

/// @nodoc
class _$BooktourEventCopyWithImpl<$Res, $Val extends BooktourEvent>
    implements $BooktourEventCopyWith<$Res> {
  _$BooktourEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$FetchBookExcerptsImplCopyWith<$Res> {
  factory _$$FetchBookExcerptsImplCopyWith(_$FetchBookExcerptsImpl value,
          $Res Function(_$FetchBookExcerptsImpl) then) =
      __$$FetchBookExcerptsImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$FetchBookExcerptsImplCopyWithImpl<$Res>
    extends _$BooktourEventCopyWithImpl<$Res, _$FetchBookExcerptsImpl>
    implements _$$FetchBookExcerptsImplCopyWith<$Res> {
  __$$FetchBookExcerptsImplCopyWithImpl(_$FetchBookExcerptsImpl _value,
      $Res Function(_$FetchBookExcerptsImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$FetchBookExcerptsImpl implements _FetchBookExcerpts {
  const _$FetchBookExcerptsImpl();

  @override
  String toString() {
    return 'BooktourEvent.fetchBookExcerpts()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$FetchBookExcerptsImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() fetchBookExcerpts,
    required TResult Function(String chip) onChipTap,
    required TResult Function(int bookExcerptId) toggleLike,
  }) {
    return fetchBookExcerpts();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? fetchBookExcerpts,
    TResult? Function(String chip)? onChipTap,
    TResult? Function(int bookExcerptId)? toggleLike,
  }) {
    return fetchBookExcerpts?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? fetchBookExcerpts,
    TResult Function(String chip)? onChipTap,
    TResult Function(int bookExcerptId)? toggleLike,
    required TResult orElse(),
  }) {
    if (fetchBookExcerpts != null) {
      return fetchBookExcerpts();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_FetchBookExcerpts value) fetchBookExcerpts,
    required TResult Function(_OnChipTap value) onChipTap,
    required TResult Function(_ToggleLike value) toggleLike,
  }) {
    return fetchBookExcerpts(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_FetchBookExcerpts value)? fetchBookExcerpts,
    TResult? Function(_OnChipTap value)? onChipTap,
    TResult? Function(_ToggleLike value)? toggleLike,
  }) {
    return fetchBookExcerpts?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_FetchBookExcerpts value)? fetchBookExcerpts,
    TResult Function(_OnChipTap value)? onChipTap,
    TResult Function(_ToggleLike value)? toggleLike,
    required TResult orElse(),
  }) {
    if (fetchBookExcerpts != null) {
      return fetchBookExcerpts(this);
    }
    return orElse();
  }
}

abstract class _FetchBookExcerpts implements BooktourEvent {
  const factory _FetchBookExcerpts() = _$FetchBookExcerptsImpl;
}

/// @nodoc
abstract class _$$OnChipTapImplCopyWith<$Res> {
  factory _$$OnChipTapImplCopyWith(
          _$OnChipTapImpl value, $Res Function(_$OnChipTapImpl) then) =
      __$$OnChipTapImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String chip});
}

/// @nodoc
class __$$OnChipTapImplCopyWithImpl<$Res>
    extends _$BooktourEventCopyWithImpl<$Res, _$OnChipTapImpl>
    implements _$$OnChipTapImplCopyWith<$Res> {
  __$$OnChipTapImplCopyWithImpl(
      _$OnChipTapImpl _value, $Res Function(_$OnChipTapImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? chip = null,
  }) {
    return _then(_$OnChipTapImpl(
      null == chip
          ? _value.chip
          : chip // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$OnChipTapImpl implements _OnChipTap {
  const _$OnChipTapImpl(this.chip);

  @override
  final String chip;

  @override
  String toString() {
    return 'BooktourEvent.onChipTap(chip: $chip)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OnChipTapImpl &&
            (identical(other.chip, chip) || other.chip == chip));
  }

  @override
  int get hashCode => Object.hash(runtimeType, chip);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$OnChipTapImplCopyWith<_$OnChipTapImpl> get copyWith =>
      __$$OnChipTapImplCopyWithImpl<_$OnChipTapImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() fetchBookExcerpts,
    required TResult Function(String chip) onChipTap,
    required TResult Function(int bookExcerptId) toggleLike,
  }) {
    return onChipTap(chip);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? fetchBookExcerpts,
    TResult? Function(String chip)? onChipTap,
    TResult? Function(int bookExcerptId)? toggleLike,
  }) {
    return onChipTap?.call(chip);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? fetchBookExcerpts,
    TResult Function(String chip)? onChipTap,
    TResult Function(int bookExcerptId)? toggleLike,
    required TResult orElse(),
  }) {
    if (onChipTap != null) {
      return onChipTap(chip);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_FetchBookExcerpts value) fetchBookExcerpts,
    required TResult Function(_OnChipTap value) onChipTap,
    required TResult Function(_ToggleLike value) toggleLike,
  }) {
    return onChipTap(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_FetchBookExcerpts value)? fetchBookExcerpts,
    TResult? Function(_OnChipTap value)? onChipTap,
    TResult? Function(_ToggleLike value)? toggleLike,
  }) {
    return onChipTap?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_FetchBookExcerpts value)? fetchBookExcerpts,
    TResult Function(_OnChipTap value)? onChipTap,
    TResult Function(_ToggleLike value)? toggleLike,
    required TResult orElse(),
  }) {
    if (onChipTap != null) {
      return onChipTap(this);
    }
    return orElse();
  }
}

abstract class _OnChipTap implements BooktourEvent {
  const factory _OnChipTap(final String chip) = _$OnChipTapImpl;

  String get chip;
  @JsonKey(ignore: true)
  _$$OnChipTapImplCopyWith<_$OnChipTapImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ToggleLikeImplCopyWith<$Res> {
  factory _$$ToggleLikeImplCopyWith(
          _$ToggleLikeImpl value, $Res Function(_$ToggleLikeImpl) then) =
      __$$ToggleLikeImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int bookExcerptId});
}

/// @nodoc
class __$$ToggleLikeImplCopyWithImpl<$Res>
    extends _$BooktourEventCopyWithImpl<$Res, _$ToggleLikeImpl>
    implements _$$ToggleLikeImplCopyWith<$Res> {
  __$$ToggleLikeImplCopyWithImpl(
      _$ToggleLikeImpl _value, $Res Function(_$ToggleLikeImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? bookExcerptId = null,
  }) {
    return _then(_$ToggleLikeImpl(
      null == bookExcerptId
          ? _value.bookExcerptId
          : bookExcerptId // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$ToggleLikeImpl implements _ToggleLike {
  const _$ToggleLikeImpl(this.bookExcerptId);

  @override
  final int bookExcerptId;

  @override
  String toString() {
    return 'BooktourEvent.toggleLike(bookExcerptId: $bookExcerptId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ToggleLikeImpl &&
            (identical(other.bookExcerptId, bookExcerptId) ||
                other.bookExcerptId == bookExcerptId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, bookExcerptId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ToggleLikeImplCopyWith<_$ToggleLikeImpl> get copyWith =>
      __$$ToggleLikeImplCopyWithImpl<_$ToggleLikeImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() fetchBookExcerpts,
    required TResult Function(String chip) onChipTap,
    required TResult Function(int bookExcerptId) toggleLike,
  }) {
    return toggleLike(bookExcerptId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? fetchBookExcerpts,
    TResult? Function(String chip)? onChipTap,
    TResult? Function(int bookExcerptId)? toggleLike,
  }) {
    return toggleLike?.call(bookExcerptId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? fetchBookExcerpts,
    TResult Function(String chip)? onChipTap,
    TResult Function(int bookExcerptId)? toggleLike,
    required TResult orElse(),
  }) {
    if (toggleLike != null) {
      return toggleLike(bookExcerptId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_FetchBookExcerpts value) fetchBookExcerpts,
    required TResult Function(_OnChipTap value) onChipTap,
    required TResult Function(_ToggleLike value) toggleLike,
  }) {
    return toggleLike(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_FetchBookExcerpts value)? fetchBookExcerpts,
    TResult? Function(_OnChipTap value)? onChipTap,
    TResult? Function(_ToggleLike value)? toggleLike,
  }) {
    return toggleLike?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_FetchBookExcerpts value)? fetchBookExcerpts,
    TResult Function(_OnChipTap value)? onChipTap,
    TResult Function(_ToggleLike value)? toggleLike,
    required TResult orElse(),
  }) {
    if (toggleLike != null) {
      return toggleLike(this);
    }
    return orElse();
  }
}

abstract class _ToggleLike implements BooktourEvent {
  const factory _ToggleLike(final int bookExcerptId) = _$ToggleLikeImpl;

  int get bookExcerptId;
  @JsonKey(ignore: true)
  _$$ToggleLikeImplCopyWith<_$ToggleLikeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
