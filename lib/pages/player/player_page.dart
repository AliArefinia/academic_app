import 'package:academic/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:academic/core/helper/ui_extention.dart';
import 'package:academic/core/player/global_player.dart';
import 'package:academic/core/theme/const.dart';
import 'package:academic/core/theme/theme.dart';
import 'package:academic/gen/assets.gen.dart';
import 'package:academic/data/api/product/model/product_model.dart';
import 'logic/player_cubit.dart';
import 'logic/player_state.dart';
import 'playlist_sheet.dart';
import 'driving_mode_sheet.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:universal_image_flutter/universal_image_flutter.dart';
import 'package:academic/core/services/reading_progress_service.dart';

class PlayerPage extends StatefulWidget {
  final String cover;
  final String title;
  final String publisher;
  final String subject;
  final String category;
  final String? audioUrl;
  final ProductModel? product;

  const PlayerPage({
    super.key,
    required this.cover,
    required this.title,
    required this.publisher,
    required this.subject,
    required this.category,
    this.audioUrl,
    this.product,
  });

  @override
  State<PlayerPage> createState() => _PlayerPageState();
}

class _PlayerPageState extends State<PlayerPage> {
  bool _initialized = false;
  GlobalPlayer? _globalPlayer;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _globalPlayer = GlobalPlayer.of(context);
    _initializePlayer();
  }

  Future<void> _initializePlayer() async {
    if (_initialized) return;
    
    if (_globalPlayer == null) return;

    // Check if this audio is already loaded (even if paused)
    if (widget.audioUrl != null && 
        _globalPlayer!.playerCubit.state.currentTitle == widget.title) {
      _initialized = true;
      return;
    }

    // Check if this playlist is already loaded (even if paused)
    if (widget.product?.headlines != null && 
        widget.product!.headlines!.isNotEmpty &&
        _globalPlayer!.playerCubit.state.playlist.isNotEmpty &&
        _globalPlayer!.playerCubit.state.playlist.first.file == widget.product!.headlines!.first.file) {
      _initialized = true;
      return;
    }

    _initialized = true;
    
    print('[PlayerPage] Initializing player with audioUrl: ${widget.audioUrl}');
    print('[PlayerPage] Has playlist: ${widget.product?.headlines != null && widget.product!.headlines!.isNotEmpty}');
    
    try {
      // Get saved progress if available
      final prefs = await SharedPreferences.getInstance();
      final progressService = ReadingProgressService(prefs);
      final savedProgress = widget.product != null && widget.product!.id != null ? 
          await progressService.getProgress(widget.product!.id!) : null;
      
      print('[PlayerPage] Found saved progress: ${savedProgress != null}');
      if (savedProgress != null) {
        print('[PlayerPage] Saved position: ${savedProgress.lastPosition}ms');
      }

      // If this is a sample audio (audioUrl is provided), prioritize playing the sample
      if (widget.audioUrl != null && widget.audioUrl!.isNotEmpty) {
        await _globalPlayer!.playerCubit.initPlayer(
          widget.audioUrl!, 
          title: widget.title, 
          cover: widget.cover,
          product: widget.product,
          initialPosition: savedProgress?.lastPosition,
        );
      } 
      // Otherwise, if we have a playlist of headlines, play those
      else if (widget.product?.headlines != null && widget.product!.headlines!.isNotEmpty) {
        await _globalPlayer!.playerCubit.initPlaylist(
          widget.product!.headlines!, 
          0,
          initialPosition: savedProgress?.lastPosition,
        );
      } else {
        print('[PlayerPage] No audio source available');
      }
    } catch (e) {
      print('[PlayerPage] Error initializing player: $e');
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error initializing player: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return hours == '00' ? '$minutes:$seconds' : '$hours:$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    if (_globalPlayer == null) return const SizedBox.shrink();

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: ClipRRect(
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(20),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
          ),
          child: Stack(
        children: [
          // Top grey background
          Container(
            height: MediaQuery.of(context).size.height * 0.32,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                ),
          ),
          // Main content
              Container(
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                ),
                child: SingleChildScrollView(
            child: Column(
              children: [
                // Back arrow
                Padding(
                  padding: const EdgeInsets.only(top: 20, right: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                              icon: Icon(Icons.keyboard_arrow_down, size: 32, color: Theme.of(context).colorScheme.onSurface),
                              onPressed: () {
                                _globalPlayer!.playerCubit.setMiniPlayerVisible(true);
                                Navigator.pop(context);
                              },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                // Book cover
                Center(
                  child: Container(
                    width: 220,
                    height: 300,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      color: Theme.of(context).colorScheme.surface,
                      boxShadow: [
                        BoxShadow(
                          color: Theme.of(context).colorScheme.shadow.withOpacity(0.08),
                          blurRadius: 16,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: UniversalImageLoader(
                      path: widget.cover,
                      option: UniversalImageLoaderOption(
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                // Book info
                Padding(
                  padding: const EdgeInsets.only(top: 24, left: 24, right: 24),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.title,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                              textAlign: TextAlign.right,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              widget.publisher,
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 15,
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                              textAlign: TextAlign.right,
                            ),
                            const SizedBox(height: 18),
                            Text(
                              l10n.subjectWithValue(widget.subject.toString()),
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.onSurfaceVariant,
                                fontSize: 13,
                              ),
                              textAlign: TextAlign.right,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              l10n.bookClassificationWithValue(widget.category.toString()),
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.onSurfaceVariant,
                                fontSize: 13,
                              ),
                              textAlign: TextAlign.right,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      Icon(Icons.download_rounded, size: 32, color: Theme.of(context).colorScheme.onSurfaceVariant),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                // Row of icons
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                            BlocBuilder<PlayerCubit, PlayerState>(
                              builder: (context, state) {
                                return Stack(
                                  children: [
                                    IconButton(
                                      icon: Icon(Icons.timer_outlined, size: 28, color: Theme.of(context).colorScheme.onSurface),
                                      onPressed: () {
                                        showModalBottomSheet(
                                          context: context,
                                          isScrollControlled: true,
                                          backgroundColor: Colors.transparent,
                                          builder: (context) => Container(
                                            decoration: BoxDecoration(
                                              color: Theme.of(context).scaffoldBackgroundColor,
                                              borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                                            ),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                const SizedBox(height: 12),
                                                // Handle bar and close button
                                                Padding(
                                                  padding: const EdgeInsets.symmetric(horizontal: 20),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      IconButton(
                                                        icon: Icon(Icons.close, size: 24, color: Theme.of(context).colorScheme.onSurface),
                                                        onPressed: () => Navigator.pop(context),
                                                      ),
                                                      Container(
                                                        width: 40,
                                                        height: 4,
                                                        decoration: BoxDecoration(
                                                          color: Theme.of(context).colorScheme.outline,
                                                          borderRadius: BorderRadius.circular(2),
                                                        ),
                                                      ),
                                                      const SizedBox(width: 40), // For symmetry
                                                    ],
                                                  ),
                                                ),
                                                const SizedBox(height: 8),
                                                Text(
                                                  l10n.stopPlaybackAfter,
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                    color: Theme.of(context).colorScheme.onSurface,
                                                  ),
                                                ),
                                                const SizedBox(height: 16),
                                                // Timer options
                                                BlocBuilder<PlayerCubit, PlayerState>(
                                                  builder: (context, state) {
                                                    return Column(
                                                      children: [
                                                        _buildTimerOptionNew(context, l10n.oneMinuteTest, const Duration(minutes: 1), state.sleepTimerDuration),
                                                        _buildTimerOptionNew(context, l10n.fifteenMinutes, const Duration(minutes: 15), state.sleepTimerDuration),
                                                        _buildTimerOptionNew(context, l10n.twentyMinutes, const Duration(minutes: 20), state.sleepTimerDuration),
                                                        _buildTimerOptionNew(context, l10n.thirtyMinutes, const Duration(minutes: 30), state.sleepTimerDuration),
                                                        _buildTimerOptionNew(context, l10n.fortyFiveMinutes, const Duration(minutes: 45), state.sleepTimerDuration),
                                                        _buildTimerOptionNew(context, l10n.oneHour, const Duration(hours: 1), state.sleepTimerDuration),
                                                        _buildTimerOptionNew(context, l10n.endOfThisSection, null, state.sleepTimerDuration),
                                                      ],
                                                    );
                                                  },
                                                ),
                                                const SizedBox(height: 16),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                    if (state.hasSleepTimer)
                                      Positioned(
                                        right: 8,
                                        top: 8,
                                        child: Container(
                                          width: 8,
                                          height: 8,
                                          decoration: BoxDecoration(
                                            color: Colors.blue,
                                            shape: BoxShape.circle,
                                          ),
                                        ),
                                      ),
                                  ],
                                );
                              },
                            ),
                      GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            builder: (context) => Container(
                              decoration: BoxDecoration(
                                color: context.cardBackground,
                                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                              ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                        const SizedBox(height: 12),
                                        // Handle bar and close button
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 20),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              IconButton(
                                                icon: const Icon(Icons.close, size: 24),
                                                onPressed: () => Navigator.pop(context),
                                              ),
                                              Container(
                                                width: 40,
                                                height: 4,
                                                decoration: BoxDecoration(
                                                  color: context.subtleBorder,
                                                  borderRadius: BorderRadius.circular(2),
                                                ),
                                              ),
                                              const SizedBox(width: 40), // For symmetry
                                            ],
                                          ),
                                        ),
                                    Text(
                                      l10n.playbackSpeed,
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 32),
                                    BlocBuilder<PlayerCubit, PlayerState>(
                                      builder: (context, state) {
                                        return Column(
                                          children: [
                                            Text(
                                              '${state.playbackSpeed}X',
                                              style: const TextStyle(
                                                fontSize: 24,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(height: 16),
                                                Padding(
                                                  padding: const EdgeInsets.symmetric(horizontal: 24),
                                                  child: SliderTheme(
                                              data: SliderTheme.of(context).copyWith(
                                                activeTrackColor: Theme.of(context).colorScheme.primary,
                                                inactiveTrackColor: Theme.of(context).colorScheme.outline,
                                                thumbColor: Theme.of(context).colorScheme.primary,
                                                trackHeight: 2,
                                              ),
                                              child: Slider(
                                                min: 0.5,
                                                max: 1.75,
                                                value: state.playbackSpeed,
                                                divisions: 25,
                                                onChanged: (value) {
                                                  final roundedValue = (value * 20).round() / 20;
                                                        _globalPlayer!.playerCubit.setPlaybackSpeed(roundedValue);
                                                },
                                                    ),
                                              ),
                                            ),
                                            const SizedBox(height: 24),
                                                SingleChildScrollView(
                                                  scrollDirection: Axis.horizontal,
                                                  child: Padding(
                                                    padding: const EdgeInsets.symmetric(horizontal: 24),
                                                    child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                _buildSpeedButton(context, 0.5, state.playbackSpeed),
                                                _buildSpeedButton(context, 0.75, state.playbackSpeed),
                                                _buildSpeedButton(context, 1.0, state.playbackSpeed, isNormal: true),
                                                _buildSpeedButton(context, 1.25, state.playbackSpeed),
                                                _buildSpeedButton(context, 1.5, state.playbackSpeed),
                                                _buildSpeedButton(context, 1.75, state.playbackSpeed),
                                              ],
                                            ),
                                                  ),
                                                ),
                                                const SizedBox(height: 24),
                                          ],
                                        );
                                      },
                                    ),
                                  ],
                              ),
                            ),
                          );
                        },
                        child: BlocBuilder<PlayerCubit, PlayerState>(
                          builder: (context, state) {
                            if (state.playbackSpeed == 1.0) {
                              return Text(
                                '1x',
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.onSurface,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              );
                            } else {
                              return Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(color: Theme.of(context).colorScheme.primary.withOpacity(0.3)),
                                ),
                                child: Text(
                                  '${state.playbackSpeed}x',
                                  style: TextStyle(
                                    color: Theme.of(context).colorScheme.primary,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              );
                            }
                          },
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.directions_car, size: 28, color: Theme.of(context).colorScheme.onSurface),
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            builder: (_) => DrivingModeSheet(
                              cover: widget.cover,
                              title: widget.title,
                            ),
                          );
                        },
                      ),
                      Icon(Icons.share, size: 28, color: Theme.of(context).colorScheme.onSurface),
                      IconButton(
                        icon: Icon(Icons.list, size: 28, color: Theme.of(context).colorScheme.onSurface),
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            builder: (_) => PlaylistSheet(
                              cover: widget.cover,
                              title: widget.title,
                              publisher: widget.publisher,
                              subject: widget.subject,
                              category: widget.category,
                              headlines: widget.product?.headlines ?? [],
                                    progress: _globalPlayer!.playerCubit.state.position.inMilliseconds / 
                                             ( _globalPlayer!.playerCubit.state.duration.inMilliseconds == 0 ? 1 : _globalPlayer!.playerCubit.state.duration.inMilliseconds),
                                    totalDuration: _formatDuration(_globalPlayer!.playerCubit.state.duration),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                // Progress bar and time
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: BlocConsumer<PlayerCubit, PlayerState>(
                    listener: (context, state) {},
                    builder: (context, state) {
                      return Column(
                        children: [
                          SliderTheme(
                            data: SliderTheme.of(context).copyWith(
                              trackHeight: 4,
                              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 8),
                              overlayShape: const RoundSliderOverlayShape(overlayRadius: 16),
                              activeTrackColor: Theme.of(context).colorScheme.primary,
                              inactiveTrackColor: Theme.of(context).colorScheme.outline,
                              thumbColor: Theme.of(context).colorScheme.primary,
                            ),
                            child: Slider(
                              value: state.duration.inMilliseconds > 0
                                  ? state.position.inMilliseconds / state.duration.inMilliseconds
                                  : 0.0,
                              onChanged: (value) {
                                if (state.duration > Duration.zero) {
                                  final position = Duration(milliseconds: (value * state.duration.inMilliseconds).round());
                                        _globalPlayer!.playerCubit.seekTo(position);
                                }
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  _formatDuration(state.position),
                                  style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: 13),
                                ),
                                Text(
                                  _formatDuration(state.duration),
                                  style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: 13),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                const SizedBox(height: 32),
                // Playback controls
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0.0),
                  child: BlocConsumer<PlayerCubit, PlayerState>(
                    listener: (context, state) {},
                    builder: (context, state) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.skip_next,
                              color: state.canPlayPrevious && !state.isLoading ? Theme.of(context).colorScheme.onSurface : Theme.of(context).colorScheme.outline,
                            ),
                            iconSize: 36,
                            onPressed: state.canPlayPrevious && !state.isLoading
                                      ? () => _globalPlayer!.playerCubit.playPrevious()
                                : null,
                          ),
                          IconButton(
                            icon: Icon(Icons.replay_10, color: !state.isLoading ? Theme.of(context).colorScheme.onSurface : Theme.of(context).colorScheme.outline),
                            iconSize: 36,
                            onPressed: !state.isLoading
                                  ? () => _globalPlayer!.playerCubit.skipBackward(const Duration(seconds: 10))
                                  : null,
                          ),
                          Container(
                            width: 72,
                            height: 72,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            child: state.isLoading
                              ? Center(child: CircularProgressIndicator(color: Theme.of(context).colorScheme.onPrimary, strokeWidth: 2))
                              : IconButton(
                                  icon: Icon(
                                    state.isPlaying ? Icons.pause : Icons.play_arrow,
                                    color: Theme.of(context).colorScheme.onPrimary,
                                  ),
                                  iconSize: 40,
                                  onPressed: () {
                                    if (state.isPlaying) {
                                      _globalPlayer!.playerCubit.pause();
                                    } else {
                                      _globalPlayer!.playerCubit.play();
                                    }
                                  },
                                ),
                          ),
                          IconButton(
                            icon: Icon(Icons.forward_10, color: !state.isLoading ? Theme.of(context).colorScheme.onSurface : Theme.of(context).colorScheme.outline),
                            iconSize: 36,
                            onPressed: !state.isLoading
                                  ? () => _globalPlayer!.playerCubit.skipForward(const Duration(seconds: 10))
                                  : null,
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.skip_previous,
                              color: state.canPlayNext && !state.isLoading ? Theme.of(context).colorScheme.onSurface : Theme.of(context).colorScheme.outline,
                            ),
                            iconSize: 36,
                            onPressed: state.canPlayNext && !state.isLoading
                                      ? () => _globalPlayer!.playerCubit.playNext()
                                : null,
                          ),
                        ],
                      );
                    },
                  ),
                ),
                const SizedBox(height: 24),
              ],
                  ),
            ),
          ),
        ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    // Hide mini player when this page opens
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_globalPlayer != null) {
        _globalPlayer!.playerCubit.setMiniPlayerVisible(false);
      }
    });
  }

  @override
  void dispose() {
    // Show mini player when this page closes
    if (_globalPlayer != null) {
      _globalPlayer!.playerCubit.setMiniPlayerVisible(true);
    }
    super.dispose();
  }

  Widget _buildSpeedButton(BuildContext context, double speed, double currentSpeed, {bool isNormal = false}) {
    final isSelected = speed == currentSpeed;
    final text = isNormal ? l10n.normalSpeed(speed.toString()) : '${speed}X';
    
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 100),
      child: OutlinedButton(
        onPressed: () {
            if (_globalPlayer != null) {
              _globalPlayer!.playerCubit.setPlaybackSpeed(speed);
          }
        },
        style: OutlinedButton.styleFrom(
          backgroundColor: isSelected ? Theme.of(context).colorScheme.primary : Colors.transparent,
          side: BorderSide(color: isSelected ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.outline),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isSelected ? Theme.of(context).colorScheme.onPrimary : Theme.of(context).colorScheme.onSurface,
              fontSize: 13,
            fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }

  Widget _buildTimerOptionNew(BuildContext context, String label, Duration? duration, Duration? currentDuration) {
    final isSelected = duration == currentDuration;
    
    return InkWell(
      onTap: () {
        if (_globalPlayer != null) {
          if (duration != null) {
            _globalPlayer!.playerCubit.setSleepTimer(duration);
          } else {
            _globalPlayer!.playerCubit.clearSleepTimer();
          }
        }
        Navigator.pop(context);
      },
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Theme.of(context).colorScheme.outline,
              width: 1,
            ),
          ),
        ),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (isSelected)
              Icon(Icons.check, color: Theme.of(context).colorScheme.primary, size: 20)
            else
              const SizedBox(width: 20),
            Text(
              label,
              style: TextStyle(
                fontSize: 16,
                color: Theme.of(context).colorScheme.onSurface,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AnimatedSpeedIcon extends StatefulWidget {
  final double speed;
  final VoidCallback onTap;
  const AnimatedSpeedIcon({required this.speed, required this.onTap, Key? key}) : super(key: key);
  @override
  State<AnimatedSpeedIcon> createState() => _AnimatedSpeedIconState();
}

class _AnimatedSpeedIconState extends State<AnimatedSpeedIcon> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void didUpdateWidget(covariant AnimatedSpeedIcon oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.speed != widget.speed) {
      _controller.forward(from: 0);
    }
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Color color;
    if (widget.speed == 1.0) {
      color = context.isDarkMode ? Colors.grey[300]! : Colors.grey[800]!;
    } else if (widget.speed == 1.5) {
      color = Colors.blue[700]!;
    } else {
      color = Colors.red[700]!;
    }
    return GestureDetector(
      onTap: widget.onTap,
      child: Stack(
        alignment: Alignment.center,
        children: [
          RotationTransition(
            turns: Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut)),
            child: Icon(Icons.speed, size: 28, color: color),
          ),
          Positioned(
            bottom: 4,
            child: Text(
              '${widget.speed}x',
              style: TextStyle(
                fontSize: 10,
                color: color,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
} 