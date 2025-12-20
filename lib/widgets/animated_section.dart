import 'package:flutter/material.dart';

class AnimatedSection extends StatelessWidget {
  final Widget child;
  final Duration duration;
  final Curve curve;
  final double offset;
  final bool isVisible;

  const AnimatedSection({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 800),
    this.curve = Curves.easeOutCubic,
    this.offset = 30,
    this.isVisible = true,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: duration,
      curve: curve,
      opacity: isVisible ? 1.0 : 0.0,
      child: AnimatedSlide(
        duration: duration,
        curve: curve,
        offset: isVisible ? Offset.zero : Offset(0, offset / 100),
        child: child,
      ),
    );
  }
} 