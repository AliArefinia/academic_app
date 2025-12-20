// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'player_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$PlayerState {
  bool get isPlaying => throw _privateConstructorUsedError;
  bool get isBuffering => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  bool get isMiniPlayerVisible => throw _privateConstructorUsedError;
  Duration get position => throw _privateConstructorUsedError;
  Duration get duration => throw _privateConstructorUsedError;
  double get progress => throw _privateConstructorUsedError;
  double get playbackSpeed => throw _privateConstructorUsedError;
  int get currentTrackIndex => throw _privateConstructorUsedError;
  List<HeadlineModel> get playlist => throw _privateConstructorUsedError;
  String? get currentTitle => throw _privateConstructorUsedError;
  String? get currentCover => throw _privateConstructorUsedError;
  ProductModel? get currentProduct => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;
  Duration? get sleepTimerDuration => throw _privateConstructorUsedError;
  DateTime? get sleepTimerEndTime => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $PlayerStateCopyWith<PlayerState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PlayerStateCopyWith<$Res> {
  factory $PlayerStateCopyWith(
          PlayerState value, $Res Function(PlayerState) then) =
      _$PlayerStateCopyWithImpl<$Res, PlayerState>;
  @useResult
  $Res call(
      {bool isPlaying,
      bool isBuffering,
      bool isLoading,
      bool isMiniPlayerVisible,
      Duration position,
      Duration duration,
      double progress,
      double playbackSpeed,
      int currentTrackIndex,
      List<HeadlineModel> playlist,
      String? currentTitle,
      String? currentCover,
      ProductModel? currentProduct,
      String? error,
      Duration? sleepTimerDuration,
      DateTime? sleepTimerEndTime});
}

/// @nodoc
class _$PlayerStateCopyWithImpl<$Res, $Val extends PlayerState>
    implements $PlayerStateCopyWith<$Res> {
  _$PlayerStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isPlaying = null,
    Object? isBuffering = null,
    Object? isLoading = null,
    Object? isMiniPlayerVisible = null,
    Object? position = null,
    Object? duration = null,
    Object? progress = null,
    Object? playbackSpeed = null,
    Object? currentTrackIndex = null,
    Object? playlist = null,
    Object? currentTitle = freezed,
    Object? currentCover = freezed,
    Object? currentProduct = freezed,
    Object? error = freezed,
    Object? sleepTimerDuration = freezed,
    Object? sleepTimerEndTime = freezed,
  }) {
    return _then(_value.copyWith(
      isPlaying: null == isPlaying
          ? _value.isPlaying
          : isPlaying // ignore: cast_nullable_to_non_nullable
              as bool,
      isBuffering: null == isBuffering
          ? _value.isBuffering
          : isBuffering // ignore: cast_nullable_to_non_nullable
              as bool,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isMiniPlayerVisible: null == isMiniPlayerVisible
          ? _value.isMiniPlayerVisible
          : isMiniPlayerVisible // ignore: cast_nullable_to_non_nullable
              as bool,
      position: null == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as Duration,
      duration: null == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as Duration,
      progress: null == progress
          ? _value.progress
          : progress // ignore: cast_nullable_to_non_nullable
              as double,
      playbackSpeed: null == playbackSpeed
          ? _value.playbackSpeed
          : playbackSpeed // ignore: cast_nullable_to_non_nullable
              as double,
      currentTrackIndex: null == currentTrackIndex
          ? _value.currentTrackIndex
          : currentTrackIndex // ignore: cast_nullable_to_non_nullable
              as int,
      playlist: null == playlist
          ? _value.playlist
          : playlist // ignore: cast_nullable_to_non_nullable
              as List<HeadlineModel>,
      currentTitle: freezed == currentTitle
          ? _value.currentTitle
          : currentTitle // ignore: cast_nullable_to_non_nullable
              as String?,
      currentCover: freezed == currentCover
          ? _value.currentCover
          : currentCover // ignore: cast_nullable_to_non_nullable
              as String?,
      currentProduct: freezed == currentProduct
          ? _value.currentProduct
          : currentProduct // ignore: cast_nullable_to_non_nullable
              as ProductModel?,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
      sleepTimerDuration: freezed == sleepTimerDuration
          ? _value.sleepTimerDuration
          : sleepTimerDuration // ignore: cast_nullable_to_non_nullable
              as Duration?,
      sleepTimerEndTime: freezed == sleepTimerEndTime
          ? _value.sleepTimerEndTime
          : sleepTimerEndTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PlayerStateImplCopyWith<$Res>
    implements $PlayerStateCopyWith<$Res> {
  factory _$$PlayerStateImplCopyWith(
          _$PlayerStateImpl value, $Res Function(_$PlayerStateImpl) then) =
      __$$PlayerStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isPlaying,
      bool isBuffering,
      bool isLoading,
      bool isMiniPlayerVisible,
      Duration position,
      Duration duration,
      double progress,
      double playbackSpeed,
      int currentTrackIndex,
      List<HeadlineModel> playlist,
      String? currentTitle,
      String? currentCover,
      ProductModel? currentProduct,
      String? error,
      Duration? sleepTimerDuration,
      DateTime? sleepTimerEndTime});
}

/// @nodoc
class __$$PlayerStateImplCopyWithImpl<$Res>
    extends _$PlayerStateCopyWithImpl<$Res, _$PlayerStateImpl>
    implements _$$PlayerStateImplCopyWith<$Res> {
  __$$PlayerStateImplCopyWithImpl(
      _$PlayerStateImpl _value, $Res Function(_$PlayerStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isPlaying = null,
    Object? isBuffering = null,
    Object? isLoading = null,
    Object? isMiniPlayerVisible = null,
    Object? position = null,
    Object? duration = null,
    Object? progress = null,
    Object? playbackSpeed = null,
    Object? currentTrackIndex = null,
    Object? playlist = null,
    Object? currentTitle = freezed,
    Object? currentCover = freezed,
    Object? currentProduct = freezed,
    Object? error = freezed,
    Object? sleepTimerDuration = freezed,
    Object? sleepTimerEndTime = freezed,
  }) {
    return _then(_$PlayerStateImpl(
      isPlaying: null == isPlaying
          ? _value.isPlaying
          : isPlaying // ignore: cast_nullable_to_non_nullable
              as bool,
      isBuffering: null == isBuffering
          ? _value.isBuffering
          : isBuffering // ignore: cast_nullable_to_non_nullable
              as bool,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isMiniPlayerVisible: null == isMiniPlayerVisible
          ? _value.isMiniPlayerVisible
          : isMiniPlayerVisible // ignore: cast_nullable_to_non_nullable
              as bool,
      position: null == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as Duration,
      duration: null == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as Duration,
      progress: null == progress
          ? _value.progress
          : progress // ignore: cast_nullable_to_non_nullable
              as double,
      playbackSpeed: null == playbackSpeed
          ? _value.playbackSpeed
          : playbackSpeed // ignore: cast_nullable_to_non_nullable
              as double,
      currentTrackIndex: null == currentTrackIndex
          ? _value.currentTrackIndex
          : currentTrackIndex // ignore: cast_nullable_to_non_nullable
              as int,
      playlist: null == playlist
          ? _value._playlist
          : playlist // ignore: cast_nullable_to_non_nullable
              as List<HeadlineModel>,
      currentTitle: freezed == currentTitle
          ? _value.currentTitle
          : currentTitle // ignore: cast_nullable_to_non_nullable
              as String?,
      currentCover: freezed == currentCover
          ? _value.currentCover
          : currentCover // ignore: cast_nullable_to_non_nullable
              as String?,
      currentProduct: freezed == currentProduct
          ? _value.currentProduct
          : currentProduct // ignore: cast_nullable_to_non_nullable
              as ProductModel?,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
      sleepTimerDuration: freezed == sleepTimerDuration
          ? _value.sleepTimerDuration
          : sleepTimerDuration // ignore: cast_nullable_to_non_nullable
              as Duration?,
      sleepTimerEndTime: freezed == sleepTimerEndTime
          ? _value.sleepTimerEndTime
          : sleepTimerEndTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc

class _$PlayerStateImpl extends _PlayerState {
  const _$PlayerStateImpl(
      {this.isPlaying = false,
      this.isBuffering = false,
      this.isLoading = false,
      this.isMiniPlayerVisible = false,
      this.position = Duration.zero,
      this.duration = Duration.zero,
      this.progress = 0.0,
      this.playbackSpeed = 1.0,
      this.currentTrackIndex = 0,
      final List<HeadlineModel> playlist = const [],
      this.currentTitle,
      this.currentCover,
      this.currentProduct,
      this.error,
      this.sleepTimerDuration,
      this.sleepTimerEndTime})
      : _playlist = playlist,
        super._();

  @override
  @JsonKey()
  final bool isPlaying;
  @override
  @JsonKey()
  final bool isBuffering;
  @override
  @JsonKey()
  final bool isLoading;
  @override
  @JsonKey()
  final bool isMiniPlayerVisible;
  @override
  @JsonKey()
  final Duration position;
  @override
  @JsonKey()
  final Duration duration;
  @override
  @JsonKey()
  final double progress;
  @override
  @JsonKey()
  final double playbackSpeed;
  @override
  @JsonKey()
  final int currentTrackIndex;
  final List<HeadlineModel> _playlist;
  @override
  @JsonKey()
  List<HeadlineModel> get playlist {
    if (_playlist is EqualUnmodifiableListView) return _playlist;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_playlist);
  }

  @override
  final String? currentTitle;
  @override
  final String? currentCover;
  @override
  final ProductModel? currentProduct;
  @override
  final String? error;
  @override
  final Duration? sleepTimerDuration;
  @override
  final DateTime? sleepTimerEndTime;

  @override
  String toString() {
    return 'PlayerState(isPlaying: $isPlaying, isBuffering: $isBuffering, isLoading: $isLoading, isMiniPlayerVisible: $isMiniPlayerVisible, position: $position, duration: $duration, progress: $progress, playbackSpeed: $playbackSpeed, currentTrackIndex: $currentTrackIndex, playlist: $playlist, currentTitle: $currentTitle, currentCover: $currentCover, currentProduct: $currentProduct, error: $error, sleepTimerDuration: $sleepTimerDuration, sleepTimerEndTime: $sleepTimerEndTime)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PlayerStateImpl &&
            (identical(other.isPlaying, isPlaying) ||
                other.isPlaying == isPlaying) &&
            (identical(other.isBuffering, isBuffering) ||
                other.isBuffering == isBuffering) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.isMiniPlayerVisible, isMiniPlayerVisible) ||
                other.isMiniPlayerVisible == isMiniPlayerVisible) &&
            (identical(other.position, position) ||
                other.position == position) &&
            (identical(other.duration, duration) ||
                other.duration == duration) &&
            (identical(other.progress, progress) ||
                other.progress == progress) &&
            (identical(other.playbackSpeed, playbackSpeed) ||
                other.playbackSpeed == playbackSpeed) &&
            (identical(other.currentTrackIndex, currentTrackIndex) ||
                other.currentTrackIndex == currentTrackIndex) &&
            const DeepCollectionEquality().equals(other._playlist, _playlist) &&
            (identical(other.currentTitle, currentTitle) ||
                other.currentTitle == currentTitle) &&
            (identical(other.currentCover, currentCover) ||
                other.currentCover == currentCover) &&
            (identical(other.currentProduct, currentProduct) ||
                other.currentProduct == currentProduct) &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.sleepTimerDuration, sleepTimerDuration) ||
                other.sleepTimerDuration == sleepTimerDuration) &&
            (identical(other.sleepTimerEndTime, sleepTimerEndTime) ||
                other.sleepTimerEndTime == sleepTimerEndTime));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      isPlaying,
      isBuffering,
      isLoading,
      isMiniPlayerVisible,
      position,
      duration,
      progress,
      playbackSpeed,
      currentTrackIndex,
      const DeepCollectionEquality().hash(_playlist),
      currentTitle,
      currentCover,
      currentProduct,
      error,
      sleepTimerDuration,
      sleepTimerEndTime);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PlayerStateImplCopyWith<_$PlayerStateImpl> get copyWith =>
      __$$PlayerStateImplCopyWithImpl<_$PlayerStateImpl>(this, _$identity);
}

abstract class _PlayerState extends PlayerState {
  const factory _PlayerState(
      {final bool isPlaying,
      final bool isBuffering,
      final bool isLoading,
      final bool isMiniPlayerVisible,
      final Duration position,
      final Duration duration,
      final double progress,
      final double playbackSpeed,
      final int currentTrackIndex,
      final List<HeadlineModel> playlist,
      final String? currentTitle,
      final String? currentCover,
      final ProductModel? currentProduct,
      final String? error,
      final Duration? sleepTimerDuration,
      final DateTime? sleepTimerEndTime}) = _$PlayerStateImpl;
  const _PlayerState._() : super._();

  @override
  bool get isPlaying;
  @override
  bool get isBuffering;
  @override
  bool get isLoading;
  @override
  bool get isMiniPlayerVisible;
  @override
  Duration get position;
  @override
  Duration get duration;
  @override
  double get progress;
  @override
  double get playbackSpeed;
  @override
  int get currentTrackIndex;
  @override
  List<HeadlineModel> get playlist;
  @override
  String? get currentTitle;
  @override
  String? get currentCover;
  @override
  ProductModel? get currentProduct;
  @override
  String? get error;
  @override
  Duration? get sleepTimerDuration;
  @override
  DateTime? get sleepTimerEndTime;
  @override
  @JsonKey(ignore: true)
  _$$PlayerStateImplCopyWith<_$PlayerStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
