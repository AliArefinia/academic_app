import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:academic/data/api/product/model/product_model.dart';

part 'player_state.freezed.dart';

@freezed
class PlayerState with _$PlayerState {
  const factory PlayerState({
    @Default(false) bool isPlaying,
    @Default(false) bool isBuffering,
    @Default(false) bool isLoading,
    @Default(false) bool isMiniPlayerVisible,
    @Default(Duration.zero) Duration position,
    @Default(Duration.zero) Duration duration,
    @Default(0.0) double progress,
    @Default(1.0) double playbackSpeed,
    @Default(0) int currentTrackIndex,
    @Default([]) List<HeadlineModel> playlist,
    String? currentTitle,
    String? currentCover,
    ProductModel? currentProduct,
    String? error,
    Duration? sleepTimerDuration,
    DateTime? sleepTimerEndTime,
  }) = _PlayerState;

  const PlayerState._();

  bool get hasError => error != null;
  bool get hasPlaylist => playlist.isNotEmpty;
  bool get canPlayNext => currentTrackIndex < playlist.length - 1;
  bool get canPlayPrevious => currentTrackIndex > 0;
  bool get hasSleepTimer => sleepTimerEndTime != null;
  String? get currentTrackTitle => hasPlaylist && currentTrackIndex >= 0 && currentTrackIndex < playlist.length 
    ? playlist[currentTrackIndex].title 
    : currentTitle;
} 