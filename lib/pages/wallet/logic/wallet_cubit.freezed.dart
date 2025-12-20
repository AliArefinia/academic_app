// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'wallet_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$WalletState {
  int get index => throw _privateConstructorUsedError;
  int get currentMoney => throw _privateConstructorUsedError;
  int get amountOfCharge => throw _privateConstructorUsedError;
  bool get isProcessingPayment => throw _privateConstructorUsedError;
  bool get isPaymentSuccessful => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $WalletStateCopyWith<WalletState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WalletStateCopyWith<$Res> {
  factory $WalletStateCopyWith(
          WalletState value, $Res Function(WalletState) then) =
      _$WalletStateCopyWithImpl<$Res, WalletState>;
  @useResult
  $Res call(
      {int index,
      int currentMoney,
      int amountOfCharge,
      bool isProcessingPayment,
      bool isPaymentSuccessful,
      String? error});
}

/// @nodoc
class _$WalletStateCopyWithImpl<$Res, $Val extends WalletState>
    implements $WalletStateCopyWith<$Res> {
  _$WalletStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? index = null,
    Object? currentMoney = null,
    Object? amountOfCharge = null,
    Object? isProcessingPayment = null,
    Object? isPaymentSuccessful = null,
    Object? error = freezed,
  }) {
    return _then(_value.copyWith(
      index: null == index
          ? _value.index
          : index // ignore: cast_nullable_to_non_nullable
              as int,
      currentMoney: null == currentMoney
          ? _value.currentMoney
          : currentMoney // ignore: cast_nullable_to_non_nullable
              as int,
      amountOfCharge: null == amountOfCharge
          ? _value.amountOfCharge
          : amountOfCharge // ignore: cast_nullable_to_non_nullable
              as int,
      isProcessingPayment: null == isProcessingPayment
          ? _value.isProcessingPayment
          : isProcessingPayment // ignore: cast_nullable_to_non_nullable
              as bool,
      isPaymentSuccessful: null == isPaymentSuccessful
          ? _value.isPaymentSuccessful
          : isPaymentSuccessful // ignore: cast_nullable_to_non_nullable
              as bool,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WalletStateImplCopyWith<$Res>
    implements $WalletStateCopyWith<$Res> {
  factory _$$WalletStateImplCopyWith(
          _$WalletStateImpl value, $Res Function(_$WalletStateImpl) then) =
      __$$WalletStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int index,
      int currentMoney,
      int amountOfCharge,
      bool isProcessingPayment,
      bool isPaymentSuccessful,
      String? error});
}

/// @nodoc
class __$$WalletStateImplCopyWithImpl<$Res>
    extends _$WalletStateCopyWithImpl<$Res, _$WalletStateImpl>
    implements _$$WalletStateImplCopyWith<$Res> {
  __$$WalletStateImplCopyWithImpl(
      _$WalletStateImpl _value, $Res Function(_$WalletStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? index = null,
    Object? currentMoney = null,
    Object? amountOfCharge = null,
    Object? isProcessingPayment = null,
    Object? isPaymentSuccessful = null,
    Object? error = freezed,
  }) {
    return _then(_$WalletStateImpl(
      index: null == index
          ? _value.index
          : index // ignore: cast_nullable_to_non_nullable
              as int,
      currentMoney: null == currentMoney
          ? _value.currentMoney
          : currentMoney // ignore: cast_nullable_to_non_nullable
              as int,
      amountOfCharge: null == amountOfCharge
          ? _value.amountOfCharge
          : amountOfCharge // ignore: cast_nullable_to_non_nullable
              as int,
      isProcessingPayment: null == isProcessingPayment
          ? _value.isProcessingPayment
          : isProcessingPayment // ignore: cast_nullable_to_non_nullable
              as bool,
      isPaymentSuccessful: null == isPaymentSuccessful
          ? _value.isPaymentSuccessful
          : isPaymentSuccessful // ignore: cast_nullable_to_non_nullable
              as bool,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$WalletStateImpl implements _WalletState {
  const _$WalletStateImpl(
      {this.index = 1,
      this.currentMoney = 0,
      this.amountOfCharge = 0,
      this.isProcessingPayment = false,
      this.isPaymentSuccessful = false,
      this.error});

  @override
  @JsonKey()
  final int index;
  @override
  @JsonKey()
  final int currentMoney;
  @override
  @JsonKey()
  final int amountOfCharge;
  @override
  @JsonKey()
  final bool isProcessingPayment;
  @override
  @JsonKey()
  final bool isPaymentSuccessful;
  @override
  final String? error;

  @override
  String toString() {
    return 'WalletState(index: $index, currentMoney: $currentMoney, amountOfCharge: $amountOfCharge, isProcessingPayment: $isProcessingPayment, isPaymentSuccessful: $isPaymentSuccessful, error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WalletStateImpl &&
            (identical(other.index, index) || other.index == index) &&
            (identical(other.currentMoney, currentMoney) ||
                other.currentMoney == currentMoney) &&
            (identical(other.amountOfCharge, amountOfCharge) ||
                other.amountOfCharge == amountOfCharge) &&
            (identical(other.isProcessingPayment, isProcessingPayment) ||
                other.isProcessingPayment == isProcessingPayment) &&
            (identical(other.isPaymentSuccessful, isPaymentSuccessful) ||
                other.isPaymentSuccessful == isPaymentSuccessful) &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(runtimeType, index, currentMoney,
      amountOfCharge, isProcessingPayment, isPaymentSuccessful, error);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$WalletStateImplCopyWith<_$WalletStateImpl> get copyWith =>
      __$$WalletStateImplCopyWithImpl<_$WalletStateImpl>(this, _$identity);
}

abstract class _WalletState implements WalletState {
  const factory _WalletState(
      {final int index,
      final int currentMoney,
      final int amountOfCharge,
      final bool isProcessingPayment,
      final bool isPaymentSuccessful,
      final String? error}) = _$WalletStateImpl;

  @override
  int get index;
  @override
  int get currentMoney;
  @override
  int get amountOfCharge;
  @override
  bool get isProcessingPayment;
  @override
  bool get isPaymentSuccessful;
  @override
  String? get error;
  @override
  @JsonKey(ignore: true)
  _$$WalletStateImplCopyWith<_$WalletStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$WalletEvent {
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
  $WalletEventCopyWith<WalletEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WalletEventCopyWith<$Res> {
  factory $WalletEventCopyWith(
          WalletEvent value, $Res Function(WalletEvent) then) =
      _$WalletEventCopyWithImpl<$Res, WalletEvent>;
  @useResult
  $Res call({String selectedLanguage});
}

/// @nodoc
class _$WalletEventCopyWithImpl<$Res, $Val extends WalletEvent>
    implements $WalletEventCopyWith<$Res> {
  _$WalletEventCopyWithImpl(this._value, this._then);

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
    implements $WalletEventCopyWith<$Res> {
  factory _$$ChangeLanguageImplCopyWith(_$ChangeLanguageImpl value,
          $Res Function(_$ChangeLanguageImpl) then) =
      __$$ChangeLanguageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String selectedLanguage});
}

/// @nodoc
class __$$ChangeLanguageImplCopyWithImpl<$Res>
    extends _$WalletEventCopyWithImpl<$Res, _$ChangeLanguageImpl>
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
    return 'WalletEvent.changeLanguage(selectedLanguage: $selectedLanguage)';
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

abstract class ChangeLanguage implements WalletEvent {
  const factory ChangeLanguage({required final String selectedLanguage}) =
      _$ChangeLanguageImpl;

  @override
  String get selectedLanguage;
  @override
  @JsonKey(ignore: true)
  _$$ChangeLanguageImplCopyWith<_$ChangeLanguageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
