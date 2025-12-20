import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:just_audio/just_audio.dart' as just_audio;
import 'dart:async';
import 'package:academic/data/api/product/model/product_model.dart';
import 'package:academic/core/services/reading_progress_service.dart';
import 'package:academic/data/api/home/model/reading_progress_model.dart';
import 'player_state.dart';


class PlayerCubit extends Cubit<PlayerState> implements StateStreamable<PlayerState> {
  just_audio.AudioPlayer? _player;
  StreamSubscription<Duration>? _positionSub;
  StreamSubscription<Duration?>? _durationSub;
  StreamSubscription<just_audio.PlayerState>? _audioStateSub;
  StreamSubscription<int?>? _sequenceStateSub;
  Timer? _sleepTimer;
  Timer? _progressSaveTimer;
  final ReadingProgressService _progressService;

  PlayerCubit(this._progressService) : super(const PlayerState());

  @override
  Stream<PlayerState> get stream => super.stream;

  void setMiniPlayerVisible(bool visible) {
    emit(state.copyWith(isMiniPlayerVisible: visible));
  }

  Future<void> _cleanupCurrentPlayer({bool preserveState = false}) async {
    print('[PlayerCubit] Cleaning up current player (preserveState: $preserveState)');
    
    // Save progress before cleanup
    if (state.currentProduct != null) {
      print('[PlayerCubit] Saving progress before cleanup');
      await _saveProgress();
    }
    
    await _positionSub?.cancel();
    await _durationSub?.cancel();
    await _audioStateSub?.cancel();
    await _sequenceStateSub?.cancel();
    await _player?.stop();
    await _player?.dispose();
    _player = null;
    
    // Reset state if not preserving
    if (!preserveState) {
      emit(const PlayerState());
    }
  }

  Future<void> _saveProgress() async {
    if (state.currentProduct == null) {
      print('[PlayerCubit] Cannot save progress: currentProduct is null');
      return;
    }

    if (_player == null) {
      print('[PlayerCubit] Cannot save progress: player is null');
      return;
    }
    
    try {
      // Get current position from player
      final currentPosition = _player!.position.inMilliseconds;
      final totalDuration = _player!.duration?.inMilliseconds ?? 0;
      
      print('[PlayerCubit] Current position from player: $currentPosition ms');
      print('[PlayerCubit] Total duration from player: $totalDuration ms');
      
      final progress = totalDuration > 0 ? currentPosition / totalDuration : 0.0;
      
      print('[PlayerCubit] Calculated progress: $progress');
      
      final progressModel = ReadingProgressModel(
        product: state.currentProduct!,
        progress: progress,
        lastPosition: currentPosition,
        lastReadAt: DateTime.now(),
      );
      
      print('[PlayerCubit] Saving progress for: ${state.currentProduct?.name}');
      print('[PlayerCubit] Progress: $progress, Position: $currentPosition');
      
      await _progressService.saveProgress(progressModel);
    } catch (e) {
      print('[PlayerCubit] Error saving progress: $e');
    }
  }

  String _fixStorageUrl(String url) {
    // Remove duplicate /storage/ in path if exists
    if (url.contains('/storage/storage/')) {
      return url.replaceFirst('/storage/storage/', '/storage/');
    }
    return url;
  }

  Future<void> initPlaylist(List<HeadlineModel> headlines, int initialIndex, {int? initialPosition}) async {
    print('[PlayerCubit] Initializing playlist with ${headlines.length} tracks, starting at index $initialIndex');
    print('[PlayerCubit] Initial position: ${initialPosition ?? 'not set'}');
    
    if (headlines.isEmpty) {
      print('[PlayerCubit] Error: Empty playlist');
      emit(state.copyWith(error: 'No tracks available in playlist'));
      return;
    }

    try {
      emit(state.copyWith(isLoading: true));
      
      // Cleanup but preserve some state
      await _cleanupCurrentPlayer(preserveState: true);
      _player = just_audio.AudioPlayer();

      // Create playlist items
      final playlist = just_audio.ConcatenatingAudioSource(
        children: headlines.map((headline) {
          // Fix the URL by removing duplicate /storage/ if present
          final fixedUrl = headline.file.replaceFirst('/storage/storage/', '/storage/');
          print('[PlayerCubit] Adding track: ${headline.title} with URL: $fixedUrl');
          return just_audio.AudioSource.uri(
            Uri.parse(fixedUrl),
            tag: {
              'title': headline.title,
              'duration': headline.time,
            },
          );
        }).toList(),
      );

      // Set audio source and wait for it to be ready
      print('[PlayerCubit] Setting audio source with initial index: $initialIndex');
      await _player!.setAudioSource(playlist, initialIndex: initialIndex);
      
      // Set up listeners
      _setupListeners();

      // Update state with new playlist
      emit(state.copyWith(
        playlist: headlines,
        currentTrackIndex: initialIndex,
        currentTitle: headlines[initialIndex].title,
        isLoading: false,
        error: null,
      ));

      // Seek to initial position if provided
      if (initialPosition != null) {
        print('[PlayerCubit] Seeking to initial position: $initialPosition ms');
        await _player!.seek(Duration(milliseconds: initialPosition));
      }

      // Start playback
      await _player!.play();
      print('[PlayerCubit] Playback started');
    } catch (e) {
      print('[PlayerCubit] Error initializing playlist: $e');
      emit(state.copyWith(
        isLoading: false,
        error: 'Error playing playlist: ${e.toString()}',
        isPlaying: false,
      ));
    }
  }

  Future<void> initPlayer(String audioUrl, {String? title, String? cover, ProductModel? product, int? initialPosition}) async {
    print('[PlayerCubit] Initializing single track player with URL: $audioUrl');
    print('[PlayerCubit] Initial position: ${initialPosition ?? 'not set'}');
    
    try {
      emit(state.copyWith(isLoading: true));
      
      // Store current playlist state
      final currentPlaylist = state.playlist;
      
      // Cleanup but preserve state
      await _cleanupCurrentPlayer(preserveState: true);
      _player = just_audio.AudioPlayer();

      // Create a single track source
      final audioSource = just_audio.AudioSource.uri(
        Uri.parse(audioUrl),
        tag: {
          'title': title,
          'cover': cover,
        },
      );

      // Set audio source and wait for it to be ready
      await _player!.setAudioSource(audioSource);
      
      // Set up listeners
      _setupListeners();

      emit(state.copyWith(
        isLoading: false,
        playlist: currentPlaylist, // Preserve the playlist
        currentTitle: title,
        currentCover: cover,
        currentProduct: product, // Set the current product
        error: null,
      ));

      // Seek to initial position if provided
      if (initialPosition != null) {
        print('[PlayerCubit] Seeking to initial position: $initialPosition ms');
        await _player!.seek(Duration(milliseconds: initialPosition));
      }

      // Start playback
      await _player!.play();
    } catch (e) {
      print('[PlayerCubit] Error initializing player: $e');
      emit(state.copyWith(
        isLoading: false, 
        error: 'Error playing audio: ${e.toString()}',
        isPlaying: false,
      ));
    }
  }

  void _setupListeners() {
    // Cancel existing subscriptions
    _positionSub?.cancel();
    _durationSub?.cancel();
    _audioStateSub?.cancel();
    _sequenceStateSub?.cancel();
    _progressSaveTimer?.cancel();

    // Position listener
    _positionSub = _player!.positionStream.listen((position) {
      if (!state.isLoading) {  // Only update position if not loading
        emit(state.copyWith(
          position: position,
          progress: _player!.duration?.inMilliseconds != null && _player!.duration!.inMilliseconds > 0
              ? position.inMilliseconds / _player!.duration!.inMilliseconds
              : 0.0,
        ));
      }
    });

    // Duration listener
    _durationSub = _player!.durationStream.listen((duration) {
      if (duration != null && !state.isLoading) {  // Only update duration if not loading
        emit(state.copyWith(duration: duration));
      }
    });

    // Player state listener
    _audioStateSub = _player!.playerStateStream.listen((audioState) {
      print('[PlayerCubit] Player state changed: ${audioState.processingState} - playing: ${audioState.playing}');
      
      if (!state.isLoading) {  // Only update player state if not loading
        emit(state.copyWith(
          isPlaying: audioState.playing,
          isBuffering: audioState.processingState == just_audio.ProcessingState.buffering,
        ));
      }

      // Handle completion
      if (audioState.processingState == just_audio.ProcessingState.completed) {
        if (state.canPlayNext) {
          playNext();
        }
      }
    });

    // Current track listener
    _sequenceStateSub = _player!.currentIndexStream.listen((index) {
      if (index != null && index != state.currentTrackIndex && index < state.playlist.length && !state.isLoading) {
        print('[PlayerCubit] Current track changed to index: $index');
        emit(state.copyWith(
          currentTrackIndex: index,
          currentTitle: state.playlist[index].title,
        ));
      }
    });

    // Save progress every 30 seconds
    _progressSaveTimer = Timer.periodic(const Duration(seconds: 30), (timer) {
      if (state.isPlaying) {
        _saveProgress();
      }
    });
  }

  Future<void> playTrack(int index) async {
    print('[PlayerCubit] Attempting to play track at index: $index');
    if (!state.hasPlaylist || index < 0 || index >= state.playlist.length) {
      print('[PlayerCubit] Invalid track index or no playlist');
      return;
    }

    try {
      emit(state.copyWith(isLoading: true));

      // فقط به ترک مورد نظر seek کن
      await _player?.seek(Duration.zero, index: index);

      emit(state.copyWith(
        currentTrackIndex: index,
        currentTitle: state.playlist[index].title,
        isLoading: false,
      ));

      print('[PlayerCubit] Starting playback of new track');
      await play();
    } catch (e) {
      print('[PlayerCubit] Error playing track: $e');
      emit(state.copyWith(
        error: 'Error playing track: ${e.toString()}',
        isLoading: false,
      ));
    }
  }

  Future<void> play() async {
    print('[PlayerCubit] Play requested');
    try {
      await _player?.play();
      print('[PlayerCubit] Play command sent to player');
    } catch (e) {
      print('[PlayerCubit] Error playing: $e');
      emit(state.copyWith(error: e.toString()));
    }
  }

  Future<void> pause() async {
    print('[PlayerCubit] Pause requested');
    try {
      await _player?.pause();
      print('[PlayerCubit] Pause command sent to player');
    } catch (e) {
      print('[PlayerCubit] Error pausing: $e');
      emit(state.copyWith(error: e.toString()));
    }
  }

  Future<void> playNext() async {
    print('[PlayerCubit] Attempting to play next track');
    
    // If we're playing a single track (sample), ignore
    if (!state.hasPlaylist) {
      print('[PlayerCubit] No playlist available for next track');
      return;
    }

    // Check if we can play next
    if (state.currentTrackIndex < state.playlist.length - 1) {
      try {
        final nextIndex = state.currentTrackIndex + 1;
        print('[PlayerCubit] Playing next track at index: $nextIndex');
        await playTrack(nextIndex);
      } catch (e) {
        print('[PlayerCubit] Error playing next track: $e');
        emit(state.copyWith(error: 'Error playing next track: ${e.toString()}'));
      }
    } else {
      print('[PlayerCubit] Already at last track');
    }
  }

  Future<void> playPrevious() async {
    print('[PlayerCubit] Attempting to play previous track');
    
    // If we're playing a single track (sample), ignore
    if (!state.hasPlaylist) {
      print('[PlayerCubit] No playlist available for previous track');
      return;
    }

    // Check if we can play previous
    if (state.currentTrackIndex > 0) {
      try {
        final previousIndex = state.currentTrackIndex - 1;
        print('[PlayerCubit] Playing previous track at index: $previousIndex');
        await playTrack(previousIndex);
      } catch (e) {
        print('[PlayerCubit] Error playing previous track: $e');
        emit(state.copyWith(error: 'Error playing previous track: ${e.toString()}'));
      }
    } else {
      print('[PlayerCubit] Already at first track');
    }
  }

  Future<void> seekTo(Duration position) async {
    try {
      await _player?.seek(position);
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    }
  }

  Future<void> setPlaybackSpeed(double speed) async {
    try {
      await _player?.setSpeed(speed);
      emit(state.copyWith(playbackSpeed: speed));
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    }
  }

  Future<void> skipForward(Duration duration) async {
    try {
      final newPosition = (state.position + duration);
      if (state.duration != Duration.zero && newPosition <= state.duration) {
        await seekTo(newPosition);
      }
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    }
  }

  Future<void> skipBackward(Duration duration) async {
    try {
      final newPosition = (state.position - duration);
      if (newPosition >= Duration.zero) {
        await seekTo(newPosition);
      }
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    }
  }

  Future<void> setSleepTimer(Duration duration) async {
    print('[PlayerCubit] Setting sleep timer for ${duration.inMinutes} minutes');
    
    // Cancel any existing timer
    _sleepTimer?.cancel();
    
    // Calculate end time
    final endTime = DateTime.now().add(duration);
    
    // Set up new timer
    _sleepTimer = Timer(duration, () {
      print('[PlayerCubit] Sleep timer triggered - pausing playback');
      pause();
      clearSleepTimer();
    });
    
    // Update state
    emit(state.copyWith(
      sleepTimerDuration: duration,
      sleepTimerEndTime: endTime,
    ));
  }

  void clearSleepTimer() {
    print('[PlayerCubit] Clearing sleep timer');
    _sleepTimer?.cancel();
    _sleepTimer = null;
    emit(state.copyWith(
      sleepTimerDuration: null,
      sleepTimerEndTime: null,
    ));
  }

  Future<void> stop() async {
    print('[PlayerCubit] Stop requested');
    try {
      // Save progress before stopping
      if (state.currentProduct != null) {
        print('[PlayerCubit] Saving progress before stopping');
        await _saveProgress();
      }
      
      await _player?.stop();
      await _cleanupCurrentPlayer();
      // Reset state completely
      emit(const PlayerState(
        isMiniPlayerVisible: false,
        duration: Duration.zero,
        position: Duration.zero,
        isPlaying: false,
        playlist: [],
        currentTrackIndex: 0,
      ));
      print('[PlayerCubit] Player stopped and cleaned up');
    } catch (e) {
      print('[PlayerCubit] Error stopping: $e');
      emit(state.copyWith(error: e.toString()));
    }
  }

  Future<void> playFromSource(Uri uri) async {
    try {
      emit(state.copyWith(isLoading: true));
      if (_player == null) {
        _player = just_audio.AudioPlayer();
        _setupListeners();
      }
      await _player!.setAudioSource(just_audio.AudioSource.uri(uri));
      emit(state.copyWith(isLoading: false));
      await play();
    } catch (e) {
      print('[PlayerCubit] Error in playFromSource: $e');
      emit(state.copyWith(isLoading: false, error: 'Error playing audio: ${e.toString()}'));
    }
  }

  @override
  Future<void> close() async {
    _sleepTimer?.cancel();
    _progressSaveTimer?.cancel();
    await _cleanupCurrentPlayer();
    return super.close();
  }
} 