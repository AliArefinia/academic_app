// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'gift_card_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$GiftcardState {
  bool get isContinued => throw _privateConstructorUsedError;
  bool get isPaymentSuccessful => throw _privateConstructorUsedError;
  bool get isProcessingPayment => throw _privateConstructorUsedError;
  int get index => throw _privateConstructorUsedError;
  int get amountOfCharge => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $GiftcardStateCopyWith<GiftcardState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GiftcardStateCopyWith<$Res> {
  factory $GiftcardStateCopyWith(
          GiftcardState value, $Res Function(GiftcardState) then) =
      _$GiftcardStateCopyWithImpl<$Res, GiftcardState>;
  @useResult
  $Res call(
      {bool isContinued,
      bool isPaymentSuccessful,
      bool isProcessingPayment,
      int index,
      int amountOfCharge,
      String? error});
}

/// @nodoc
class _$GiftcardStateCopyWithImpl<$Res, $Val extends GiftcardState>
    implements $GiftcardStateCopyWith<$Res> {
  _$GiftcardStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isContinued = null,
    Object? isPaymentSuccessful = null,
    Object? isProcessingPayment = null,
    Object? index = null,
    Object? amountOfCharge = null,
    Object? error = freezed,
  }) {
    return _then(_value.copyWith(
      isContinued: null == isContinued
          ? _value.isContinued
          : isContinued // ignore: cast_nullable_to_non_nullable
              as bool,
      isPaymentSuccessful: null == isPaymentSuccessful
          ? _value.isPaymentSuccessful
          : isPaymentSuccessful // ignore: cast_nullable_to_non_nullable
              as bool,
      isProcessingPayment: null == isProcessingPayment
          ? _value.isProcessingPayment
          : isProcessingPayment // ignore: cast_nullable_to_non_nullable
              as bool,
      index: null == index
          ? _value.index
          : index // ignore: cast_nullable_to_non_nullable
              as int,
      amountOfCharge: null == amountOfCharge
          ? _value.amountOfCharge
          : amountOfCharge // ignore: cast_nullable_to_non_nullable
              as int,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GiftcardStateImplCopyWith<$Res>
    implements $GiftcardStateCopyWith<$Res> {
  factory _$$GiftcardStateImplCopyWith(
          _$GiftcardStateImpl value, $Res Function(_$GiftcardStateImpl) then) =
      __$$GiftcardStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isContinued,
      bool isPaymentSuccessful,
      bool isProcessingPayment,
      int index,
      int amountOfCharge,
      String? error});
}

/// @nodoc
class __$$GiftcardStateImplCopyWithImpl<$Res>
    extends _$GiftcardStateCopyWithImpl<$Res, _$GiftcardStateImpl>
    implements _$$GiftcardStateImplCopyWith<$Res> {
  __$$GiftcardStateImplCopyWithImpl(
      _$GiftcardStateImpl _value, $Res Function(_$GiftcardStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isContinued = null,
    Object? isPaymentSuccessful = null,
    Object? isProcessingPayment = null,
    Object? index = null,
    Object? amountOfCharge = null,
    Object? error = freezed,
  }) {
    return _then(_$GiftcardStateImpl(
      isContinued: null == isContinued
          ? _value.isContinued
          : isContinued // ignore: cast_nullable_to_non_nullable
              as bool,
      isPaymentSuccessful: null == isPaymentSuccessful
          ? _value.isPaymentSuccessful
          : isPaymentSuccessful // ignore: cast_nullable_to_non_nullable
              as bool,
      isProcessingPayment: null == isProcessingPayment
          ? _value.isProcessingPayment
          : isProcessingPayment // ignore: cast_nullable_to_non_nullable
              as bool,
      index: null == index
          ? _value.index
          : index // ignore: cast_nullable_to_non_nullable
              as int,
      amountOfCharge: null == amountOfCharge
          ? _value.amountOfCharge
          : amountOfCharge // ignore: cast_nullable_to_non_nullable
              as int,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$GiftcardStateImpl implements _GiftcardState {
  const _$GiftcardStateImpl(
      {this.isContinued = false,
      this.isPaymentSuccessful = false,
      this.isProcessingPayment = false,
      this.index = 1,
      this.amountOfCharge = 0,
      this.error});

  @override
  @JsonKey()
  final bool isContinued;
  @override
  @JsonKey()
  final bool isPaymentSuccessful;
  @override
  @JsonKey()
  final bool isProcessingPayment;
  @override
  @JsonKey()
  final int index;
  @override
  @JsonKey()
  final int amountOfCharge;
  @override
  final String? error;

  @override
  String toString() {
    return 'GiftcardState(isContinued: $isContinued, isPaymentSuccessful: $isPaymentSuccessful, isProcessingPayment: $isProcessingPayment, index: $index, amountOfCharge: $amountOfCharge, error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GiftcardStateImpl &&
            (identical(other.isContinued, isContinued) ||
                other.isContinued == isContinued) &&
            (identical(other.isPaymentSuccessful, isPaymentSuccessful) ||
                other.isPaymentSuccessful == isPaymentSuccessful) &&
            (identical(other.isProcessingPayment, isProcessingPayment) ||
                other.isProcessingPayment == isProcessingPayment) &&
            (identical(other.index, index) || other.index == index) &&
            (identical(other.amountOfCharge, amountOfCharge) ||
                other.amountOfCharge == amountOfCharge) &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isContinued, isPaymentSuccessful,
      isProcessingPayment, index, amountOfCharge, error);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GiftcardStateImplCopyWith<_$GiftcardStateImpl> get copyWith =>
      __$$GiftcardStateImplCopyWithImpl<_$GiftcardStateImpl>(this, _$identity);
}

abstract class _GiftcardState implements GiftcardState {
  const factory _GiftcardState(
      {final bool isContinued,
      final bool isPaymentSuccessful,
      final bool isProcessingPayment,
      final int index,
      final int amountOfCharge,
      final String? error}) = _$GiftcardStateImpl;

  @override
  bool get isContinued;
  @override
  bool get isPaymentSuccessful;
  @override
  bool get isProcessingPayment;
  @override
  int get index;
  @override
  int get amountOfCharge;
  @override
  String? get error;
  @override
  @JsonKey(ignore: true)
  _$$GiftcardStateImplCopyWith<_$GiftcardStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$GiftcardEvent {
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
  $GiftcardEventCopyWith<GiftcardEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GiftcardEventCopyWith<$Res> {
  factory $GiftcardEventCopyWith(
          GiftcardEvent value, $Res Function(GiftcardEvent) then) =
      _$GiftcardEventCopyWithImpl<$Res, GiftcardEvent>;
  @useResult
  $Res call({String selectedLanguage});
}

/// @nodoc
class _$GiftcardEventCopyWithImpl<$Res, $Val extends GiftcardEvent>
    implements $GiftcardEventCopyWith<$Res> {
  _$GiftcardEventCopyWithImpl(this._value, this._then);

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
    implements $GiftcardEventCopyWith<$Res> {
  factory _$$ChangeLanguageImplCopyWith(_$ChangeLanguageImpl value,
          $Res Function(_$ChangeLanguageImpl) then) =
      __$$ChangeLanguageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String selectedLanguage});
}

/// @nodoc
class __$$ChangeLanguageImplCopyWithImpl<$Res>
    extends _$GiftcardEventCopyWithImpl<$Res, _$ChangeLanguageImpl>
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
    return 'GiftcardEvent.changeLanguage(selectedLanguage: $selectedLanguage)';
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

abstract class ChangeLanguage implements GiftcardEvent {
  const factory ChangeLanguage({required final String selectedLanguage}) =
      _$ChangeLanguageImpl;

  @override
  String get selectedLanguage;
  @override
  @JsonKey(ignore: true)
  _$$ChangeLanguageImplCopyWith<_$ChangeLanguageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
