// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'my_comments_main_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$MycommentsmainState {
  String get currentTab => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  bool get isError => throw _privateConstructorUsedError;
  String get errorMessage => throw _privateConstructorUsedError;
  List<UserReviewModel> get reviews => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $MycommentsmainStateCopyWith<MycommentsmainState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MycommentsmainStateCopyWith<$Res> {
  factory $MycommentsmainStateCopyWith(
          MycommentsmainState value, $Res Function(MycommentsmainState) then) =
      _$MycommentsmainStateCopyWithImpl<$Res, MycommentsmainState>;
  @useResult
  $Res call(
      {String currentTab,
      bool isLoading,
      bool isError,
      String errorMessage,
      List<UserReviewModel> reviews});
}

/// @nodoc
class _$MycommentsmainStateCopyWithImpl<$Res, $Val extends MycommentsmainState>
    implements $MycommentsmainStateCopyWith<$Res> {
  _$MycommentsmainStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentTab = null,
    Object? isLoading = null,
    Object? isError = null,
    Object? errorMessage = null,
    Object? reviews = null,
  }) {
    return _then(_value.copyWith(
      currentTab: null == currentTab
          ? _value.currentTab
          : currentTab // ignore: cast_nullable_to_non_nullable
              as String,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isError: null == isError
          ? _value.isError
          : isError // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: null == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String,
      reviews: null == reviews
          ? _value.reviews
          : reviews // ignore: cast_nullable_to_non_nullable
              as List<UserReviewModel>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MycommentsmainStateImplCopyWith<$Res>
    implements $MycommentsmainStateCopyWith<$Res> {
  factory _$$MycommentsmainStateImplCopyWith(_$MycommentsmainStateImpl value,
          $Res Function(_$MycommentsmainStateImpl) then) =
      __$$MycommentsmainStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String currentTab,
      bool isLoading,
      bool isError,
      String errorMessage,
      List<UserReviewModel> reviews});
}

/// @nodoc
class __$$MycommentsmainStateImplCopyWithImpl<$Res>
    extends _$MycommentsmainStateCopyWithImpl<$Res, _$MycommentsmainStateImpl>
    implements _$$MycommentsmainStateImplCopyWith<$Res> {
  __$$MycommentsmainStateImplCopyWithImpl(_$MycommentsmainStateImpl _value,
      $Res Function(_$MycommentsmainStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentTab = null,
    Object? isLoading = null,
    Object? isError = null,
    Object? errorMessage = null,
    Object? reviews = null,
  }) {
    return _then(_$MycommentsmainStateImpl(
      currentTab: null == currentTab
          ? _value.currentTab
          : currentTab // ignore: cast_nullable_to_non_nullable
              as String,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isError: null == isError
          ? _value.isError
          : isError // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: null == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String,
      reviews: null == reviews
          ? _value._reviews
          : reviews // ignore: cast_nullable_to_non_nullable
              as List<UserReviewModel>,
    ));
  }
}

/// @nodoc

class _$MycommentsmainStateImpl implements _MycommentsmainState {
  const _$MycommentsmainStateImpl(
      {this.currentTab = 'ثبت نظر جدید',
      this.isLoading = false,
      this.isError = false,
      this.errorMessage = '',
      final List<UserReviewModel> reviews = const []})
      : _reviews = reviews;

  @override
  @JsonKey()
  final String currentTab;
  @override
  @JsonKey()
  final bool isLoading;
  @override
  @JsonKey()
  final bool isError;
  @override
  @JsonKey()
  final String errorMessage;
  final List<UserReviewModel> _reviews;
  @override
  @JsonKey()
  List<UserReviewModel> get reviews {
    if (_reviews is EqualUnmodifiableListView) return _reviews;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_reviews);
  }

  @override
  String toString() {
    return 'MycommentsmainState(currentTab: $currentTab, isLoading: $isLoading, isError: $isError, errorMessage: $errorMessage, reviews: $reviews)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MycommentsmainStateImpl &&
            (identical(other.currentTab, currentTab) ||
                other.currentTab == currentTab) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.isError, isError) || other.isError == isError) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            const DeepCollectionEquality().equals(other._reviews, _reviews));
  }

  @override
  int get hashCode => Object.hash(runtimeType, currentTab, isLoading, isError,
      errorMessage, const DeepCollectionEquality().hash(_reviews));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MycommentsmainStateImplCopyWith<_$MycommentsmainStateImpl> get copyWith =>
      __$$MycommentsmainStateImplCopyWithImpl<_$MycommentsmainStateImpl>(
          this, _$identity);
}

abstract class _MycommentsmainState implements MycommentsmainState {
  const factory _MycommentsmainState(
      {final String currentTab,
      final bool isLoading,
      final bool isError,
      final String errorMessage,
      final List<UserReviewModel> reviews}) = _$MycommentsmainStateImpl;

  @override
  String get currentTab;
  @override
  bool get isLoading;
  @override
  bool get isError;
  @override
  String get errorMessage;
  @override
  List<UserReviewModel> get reviews;
  @override
  @JsonKey(ignore: true)
  _$$MycommentsmainStateImplCopyWith<_$MycommentsmainStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$MycommentsmainEvent {
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
  $MycommentsmainEventCopyWith<MycommentsmainEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MycommentsmainEventCopyWith<$Res> {
  factory $MycommentsmainEventCopyWith(
          MycommentsmainEvent value, $Res Function(MycommentsmainEvent) then) =
      _$MycommentsmainEventCopyWithImpl<$Res, MycommentsmainEvent>;
  @useResult
  $Res call({String selectedLanguage});
}

/// @nodoc
class _$MycommentsmainEventCopyWithImpl<$Res, $Val extends MycommentsmainEvent>
    implements $MycommentsmainEventCopyWith<$Res> {
  _$MycommentsmainEventCopyWithImpl(this._value, this._then);

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
    implements $MycommentsmainEventCopyWith<$Res> {
  factory _$$ChangeLanguageImplCopyWith(_$ChangeLanguageImpl value,
          $Res Function(_$ChangeLanguageImpl) then) =
      __$$ChangeLanguageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String selectedLanguage});
}

/// @nodoc
class __$$ChangeLanguageImplCopyWithImpl<$Res>
    extends _$MycommentsmainEventCopyWithImpl<$Res, _$ChangeLanguageImpl>
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
    return 'MycommentsmainEvent.changeLanguage(selectedLanguage: $selectedLanguage)';
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

abstract class ChangeLanguage implements MycommentsmainEvent {
  const factory ChangeLanguage({required final String selectedLanguage}) =
      _$ChangeLanguageImpl;

  @override
  String get selectedLanguage;
  @override
  @JsonKey(ignore: true)
  _$$ChangeLanguageImplCopyWith<_$ChangeLanguageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
