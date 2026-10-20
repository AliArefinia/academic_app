import 'package:academic/l10n/l10n.dart';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:academic/core/helper/ui_extention.dart';
import 'package:universal_image_flutter/universal_image_flutter.dart';
import 'package:academic/core/player/global_player.dart';
import 'package:academic/pages/player/logic/player_cubit.dart';
import 'package:academic/pages/player/logic/player_state.dart';

class DrivingModeSheet extends StatelessWidget {
  final String cover;
  final String title;

  const DrivingModeSheet({
    super.key,
    required this.cover,
    required this.title,
  });

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$hours:$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    final globalPlayer = GlobalPlayer.of(context);
    if (globalPlayer == null) return const SizedBox.shrink();

    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          // Header with title
          Container(
            padding: const EdgeInsets.symmetric(vertical: 16),
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Theme.of(context).colorScheme.outline)),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Text(
                  l10n.drivingMode,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                Positioned(
                  left: 8,
                  child: IconButton(
                    icon: Icon(Icons.close, color: Theme.of(context).colorScheme.onSurface),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              ],
            ),
          ),

          // Cover image and title
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Cover image
                Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: UniversalImageLoader(
                      path: cover,
                      option: UniversalImageLoaderOption(
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                // Title
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(height: 32),
                // Time
                BlocBuilder<PlayerCubit, PlayerState>(
                  builder: (context, state) {
                    return Text(
                      _formatDuration(state.position),
                      style: const TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.w300,
                        letterSpacing: 2,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),

          // Controls
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 32),
            child: BlocBuilder<PlayerCubit, PlayerState>(
              builder: (context, state) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Backward 10 seconds button
                    IconButton(
                      iconSize: 64,
                      icon: const Icon(Icons.replay_10),
                      onPressed: () => globalPlayer.playerCubit.skipBackward(const Duration(seconds: 10)),
                    ),
                    // Play/Pause button
                    GestureDetector(
                      onTap: () {
                        if (state.isPlaying) {
                          globalPlayer.playerCubit.pause();
                        } else {
                          globalPlayer.playerCubit.play();
                        }
                      },
                      child: Container(
                        width: 80,
                        height: 80,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.black,
                        ),
                        child: Icon(
                          state.isPlaying ? Icons.pause : Icons.play_arrow,
                          color: Colors.white,
                          size: 48,
                        ),
                      ),
                    ),
                    // Forward 10 seconds button
                    IconButton(
                      iconSize: 64,
                      icon: const Icon(Icons.forward_10),
                      onPressed: () => globalPlayer.playerCubit.skipForward(const Duration(seconds: 10)),
                    ),
                  ],
                );
              },
            ),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildSpeedChip(BuildContext context, double speed, double currentSpeed) {
    final globalPlayer = GlobalPlayer.of(context);
    final isSelected = speed == currentSpeed;
    
    return ChoiceChip(
      label: Text(
        '${speed}x',
        style: TextStyle(
          color: isSelected ? Theme.of(context).colorScheme.onPrimary : Theme.of(context).colorScheme.onSurface,
          fontSize: 14,
        ),
      ),
      selected: isSelected,
      onSelected: (bool selected) {
        if (selected && globalPlayer != null) {
          globalPlayer.playerCubit.setPlaybackSpeed(speed);
        }
      },
      selectedColor: Theme.of(context).colorScheme.primary,
      backgroundColor: Theme.of(context).colorScheme.surface,
    );
  }
}

class CircularArrowPainter extends CustomPainter {
  final Color color;
  final bool isReverse;

  CircularArrowPainter({
    required this.color,
    required this.isReverse,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..strokeCap = StrokeCap.round;

    final center = Offset(size.width / 2, size.height / 2);
    const double radius = 24;
    
    if (isReverse) {
      // Draw counter-clockwise arc for reverse
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        -0.5, // Start from right
        -5.5, // Sweep counter-clockwise
        false,
        paint,
      );

      // Draw arrow head for reverse
      final endAngle = -0.5 - 5.5;
      final x = center.dx + radius * cos(endAngle);
      final y = center.dy + radius * sin(endAngle);
      
      final arrowPath = Path();
      arrowPath.moveTo(x, y);
      arrowPath.lineTo(x - 4, y - 6);
      arrowPath.moveTo(x, y);
      arrowPath.lineTo(x + 4, y - 6);
      
      canvas.drawPath(arrowPath, paint);
    } else {
      // Draw clockwise arc for forward
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        -0.5, // Start from right
        5.5, // Sweep clockwise
        false,
        paint,
      );

      // Draw arrow head for forward
      final endAngle = -0.5 + 5.5;
      final x = center.dx + radius * cos(endAngle);
      final y = center.dy + radius * sin(endAngle);
      
      final arrowPath = Path();
      arrowPath.moveTo(x, y);
      arrowPath.lineTo(x - 4, y + 6);
      arrowPath.moveTo(x, y);
      arrowPath.lineTo(x + 4, y + 6);
      
      canvas.drawPath(arrowPath, paint);
    }
  }

  @override
  bool shouldRepaint(CircularArrowPainter oldDelegate) => 
    color != oldDelegate.color || isReverse != oldDelegate.isReverse;
} 