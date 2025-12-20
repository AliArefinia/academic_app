// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'my_clippings_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$MyClippingsState {
  bool get isLoading => throw _privateConstructorUsedError;
  List<MyBookExcerpt> get myBookExcerpts => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;
  int get index => throw _privateConstructorUsedError;
  bool get isWhoLikeShow => throw _privateConstructorUsedError;
  bool get isPeopleCommentsShow => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $MyClippingsStateCopyWith<MyClippingsState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MyClippingsStateCopyWith<$Res> {
  factory $MyClippingsStateCopyWith(
          MyClippingsState value, $Res Function(MyClippingsState) then) =
      _$MyClippingsStateCopyWithImpl<$Res, MyClippingsState>;
  @useResult
  $Res call(
      {bool isLoading,
      List<MyBookExcerpt> myBookExcerpts,
      String? error,
      int index,
      bool isWhoLikeShow,
      bool isPeopleCommentsShow});
}

/// @nodoc
class _$MyClippingsStateCopyWithImpl<$Res, $Val extends MyClippingsState>
    implements $MyClippingsStateCopyWith<$Res> {
  _$MyClippingsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? myBookExcerpts = null,
    Object? error = freezed,
    Object? index = null,
    Object? isWhoLikeShow = null,
    Object? isPeopleCommentsShow = null,
  }) {
    return _then(_value.copyWith(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      myBookExcerpts: null == myBookExcerpts
          ? _value.myBookExcerpts
          : myBookExcerpts // ignore: cast_nullable_to_non_nullable
              as List<MyBookExcerpt>,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
      index: null == index
          ? _value.index
          : index // ignore: cast_nullable_to_non_nullable
              as int,
      isWhoLikeShow: null == isWhoLikeShow
          ? _value.isWhoLikeShow
          : isWhoLikeShow // ignore: cast_nullable_to_non_nullable
              as bool,
      isPeopleCommentsShow: null == isPeopleCommentsShow
          ? _value.isPeopleCommentsShow
          : isPeopleCommentsShow // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MyClippingsStateImplCopyWith<$Res>
    implements $MyClippingsStateCopyWith<$Res> {
  factory _$$MyClippingsStateImplCopyWith(_$MyClippingsStateImpl value,
          $Res Function(_$MyClippingsStateImpl) then) =
      __$$MyClippingsStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isLoading,
      List<MyBookExcerpt> myBookExcerpts,
      String? error,
      int index,
      bool isWhoLikeShow,
      bool isPeopleCommentsShow});
}

/// @nodoc
class __$$MyClippingsStateImplCopyWithImpl<$Res>
    extends _$MyClippingsStateCopyWithImpl<$Res, _$MyClippingsStateImpl>
    implements _$$MyClippingsStateImplCopyWith<$Res> {
  __$$MyClippingsStateImplCopyWithImpl(_$MyClippingsStateImpl _value,
      $Res Function(_$MyClippingsStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? myBookExcerpts = null,
    Object? error = freezed,
    Object? index = null,
    Object? isWhoLikeShow = null,
    Object? isPeopleCommentsShow = null,
  }) {
    return _then(_$MyClippingsStateImpl(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      myBookExcerpts: null == myBookExcerpts
          ? _value._myBookExcerpts
          : myBookExcerpts // ignore: cast_nullable_to_non_nullable
              as List<MyBookExcerpt>,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
      index: null == index
          ? _value.index
          : index // ignore: cast_nullable_to_non_nullable
              as int,
      isWhoLikeShow: null == isWhoLikeShow
          ? _value.isWhoLikeShow
          : isWhoLikeShow // ignore: cast_nullable_to_non_nullable
              as bool,
      isPeopleCommentsShow: null == isPeopleCommentsShow
          ? _value.isPeopleCommentsShow
          : isPeopleCommentsShow // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$MyClippingsStateImpl implements _MyClippingsState {
  const _$MyClippingsStateImpl(
      {this.isLoading = false,
      final List<MyBookExcerpt> myBookExcerpts = const [],
      this.error,
      this.index = 0,
      this.isWhoLikeShow = false,
      this.isPeopleCommentsShow = false})
      : _myBookExcerpts = myBookExcerpts;

  @override
  @JsonKey()
  final bool isLoading;
  final List<MyBookExcerpt> _myBookExcerpts;
  @override
  @JsonKey()
  List<MyBookExcerpt> get myBookExcerpts {
    if (_myBookExcerpts is EqualUnmodifiableListView) return _myBookExcerpts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_myBookExcerpts);
  }

  @override
  final String? error;
  @override
  @JsonKey()
  final int index;
  @override
  @JsonKey()
  final bool isWhoLikeShow;
  @override
  @JsonKey()
  final bool isPeopleCommentsShow;

  @override
  String toString() {
    return 'MyClippingsState(isLoading: $isLoading, myBookExcerpts: $myBookExcerpts, error: $error, index: $index, isWhoLikeShow: $isWhoLikeShow, isPeopleCommentsShow: $isPeopleCommentsShow)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MyClippingsStateImpl &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            const DeepCollectionEquality()
                .equals(other._myBookExcerpts, _myBookExcerpts) &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.index, index) || other.index == index) &&
            (identical(other.isWhoLikeShow, isWhoLikeShow) ||
                other.isWhoLikeShow == isWhoLikeShow) &&
            (identical(other.isPeopleCommentsShow, isPeopleCommentsShow) ||
                other.isPeopleCommentsShow == isPeopleCommentsShow));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      isLoading,
      const DeepCollectionEquality().hash(_myBookExcerpts),
      error,
      index,
      isWhoLikeShow,
      isPeopleCommentsShow);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MyClippingsStateImplCopyWith<_$MyClippingsStateImpl> get copyWith =>
      __$$MyClippingsStateImplCopyWithImpl<_$MyClippingsStateImpl>(
          this, _$identity);
}

abstract class _MyClippingsState implements MyClippingsState {
  const factory _MyClippingsState(
      {final bool isLoading,
      final List<MyBookExcerpt> myBookExcerpts,
      final String? error,
      final int index,
      final bool isWhoLikeShow,
      final bool isPeopleCommentsShow}) = _$MyClippingsStateImpl;

  @override
  bool get isLoading;
  @override
  List<MyBookExcerpt> get myBookExcerpts;
  @override
  String? get error;
  @override
  int get index;
  @override
  bool get isWhoLikeShow;
  @override
  bool get isPeopleCommentsShow;
  @override
  @JsonKey(ignore: true)
  _$$MyClippingsStateImplCopyWith<_$MyClippingsStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$MyclippingsEvent {
  String get selectedLanguage => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String selectedLanguage) changeLanguage,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String selectedLanguage)? changeLanguage,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String selectedLanguage)? changeLanguage,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ChangeLanguage value) changeLanguage,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ChangeLanguage value)? changeLanguage,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ChangeLanguage value)? changeLanguage,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $MyclippingsEventCopyWith<MyclippingsEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MyclippingsEventCopyWith<$Res> {
  factory $MyclippingsEventCopyWith(
          MyclippingsEvent value, $Res Function(MyclippingsEvent) then) =
      _$MyclippingsEventCopyWithImpl<$Res, MyclippingsEvent>;
  @useResult
  $Res call({String selectedLanguage});
}

/// @nodoc
class _$MyclippingsEventCopyWithImpl<$Res, $Val extends MyclippingsEvent>
    implements $MyclippingsEventCopyWith<$Res> {
  _$MyclippingsEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectedLanguage = null,
  }) {
    return _then(_value.copyWith(
      selectedLanguage: null == selectedLanguage
          ? _value.selectedLanguage
          : selectedLanguage // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ChangeLanguageImplCopyWith<$Res>
    implements $MyclippingsEventCopyWith<$Res> {
  factory _$$ChangeLanguageImplCopyWith(_$ChangeLanguageImpl value,
          $Res Function(_$ChangeLanguageImpl) then) =
      __$$ChangeLanguageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String selectedLanguage});
}

/// @nodoc
class __$$ChangeLanguageImplCopyWithImpl<$Res>
    extends _$MyclippingsEventCopyWithImpl<$Res, _$ChangeLanguageImpl>
    implements _$$ChangeLanguageImplCopyWith<$Res> {
  __$$ChangeLanguageImplCopyWithImpl(
      _$ChangeLanguageImpl _value, $Res Function(_$ChangeLanguageImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectedLanguage = null,
  }) {
    return _then(_$ChangeLanguageImpl(
      selectedLanguage: null == selectedLanguage
          ? _value.selectedLanguage
          : selectedLanguage // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$ChangeLanguageImpl implements ChangeLanguage {
  const _$ChangeLanguageImpl({required this.selectedLanguage});

  @override
  final String selectedLanguage;

  @override
  String toString() {
    return 'MyclippingsEvent.changeLanguage(selectedLanguage: $selectedLanguage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChangeLanguageImpl &&
            (identical(other.selectedLanguage, selectedLanguage) ||
                other.selectedLanguage == selectedLanguage));
  }

  @override
  int get hashCode => Object.hash(runtimeType, selectedLanguage);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ChangeLanguageImplCopyWith<_$ChangeLanguageImpl> get copyWith =>
      __$$ChangeLanguageImplCopyWithImpl<_$ChangeLanguageImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String selectedLanguage) changeLanguage,
  }) {
    return changeLanguage(selectedLanguage);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String selectedLanguage)? changeLanguage,
  }) {
    return changeLanguage?.call(selectedLanguage);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String selectedLanguage)? changeLanguage,
    required TResult orElse(),
  }) {
    if (changeLanguage != null) {
      return changeLanguage(selectedLanguage);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ChangeLanguage value) changeLanguage,
  }) {
    return changeLanguage(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ChangeLanguage value)? changeLanguage,
  }) {
    return changeLanguage?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ChangeLanguage value)? changeLanguage,
    required TResult orElse(),
  }) {
    if (changeLanguage != null) {
      return changeLanguage(this);
    }
    return orElse();
  }
}

abstract class ChangeLanguage implements MyclippingsEvent {
  const factory ChangeLanguage({required final String selectedLanguage}) =
      _$ChangeLanguageImpl;

  @override
  String get selectedLanguage;
  @override
  @JsonKey(ignore: true)
  _$$ChangeLanguageImplCopyWith<_$ChangeLanguageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
