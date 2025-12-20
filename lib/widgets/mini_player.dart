import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:academic/core/helper/ui_extention.dart';
import 'package:academic/core/theme/const.dart';
import 'package:universal_image_flutter/universal_image_flutter.dart';
import 'package:academic/pages/player/logic/player_cubit.dart';
import 'package:academic/pages/player/logic/player_state.dart';

class MiniPlayer extends StatelessWidget {
  final String cover;
  final String title;
  final VoidCallback onTap;

  const MiniPlayer({
    super.key,
    required this.cover,
    required this.title,
    required this.onTap,
  });

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlayerCubit, PlayerState>(
      builder: (context, state) {
        // Hide if not visible or no audio is loaded (duration is zero)
        if (!state.isMiniPlayerVisible || state.duration == Duration.zero) {
          return const SizedBox.shrink();
        }
        
        return GestureDetector(
          onTap: onTap,
          child: Container(
            height: 72,
            decoration: BoxDecoration(
              color: context.colorScheme.surface,
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).colorScheme.shadow.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s16),
                child: Row(
                  children: [
                    // Cover
                    ClipRRect(
                      borderRadius: BorderRadius.circular(AppRadius.corner8),
                      child: UniversalImageLoader(
                        path: cover,
                        option: UniversalImageLoaderOption(
                          width: 48,
                          height: 48,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.s12),
                    // Title and progress
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: context.textTheme.titleSmall,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          LinearProgressIndicator(
                            value: state.duration.inMilliseconds > 0
                                ? state.position.inMilliseconds / state.duration.inMilliseconds
                                : 0.0,
                            backgroundColor: context.colorScheme.surfaceVariant,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              context.colorScheme.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: AppSpacing.s12),
                    // Play/Pause button
                    IconButton(
                      icon: Icon(
                        state.isPlaying ? Icons.pause : Icons.play_arrow,
                        color: context.colorScheme.primary,
                      ),
                      onPressed: () {
                        if (state.isPlaying) {
                          context.read<PlayerCubit>().pause();
                        } else {
                          context.read<PlayerCubit>().play();
                        }
                      },
                    ),
                    // Close button
                    IconButton(
                      icon: Icon(
                        Icons.close,
                        color: context.colorScheme.primary,
                      ),
                      onPressed: () {
                        final cubit = context.read<PlayerCubit>();
                        cubit.stop(); // This will also hide the mini player
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
} 