import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:academic/core/theme/const.dart';
import 'package:academic/core/helper/ui_extention.dart';

/// A beautiful empty state widget with animations
class EmptyStateWidget extends StatefulWidget {
  /// The title to display
  final String title;
  
  /// The description message
  final String message;
  
  /// Icon asset path (SVG)
  final String? iconAsset;
  
  /// Action button text (optional)
  final String? actionButtonText;
  
  /// Action button callback (optional)
  final VoidCallback? onActionPressed;
  
  /// Whether to use compact layout
  final bool compact;
  
  /// Custom icon color
  final Color? iconColor;

  const EmptyStateWidget({
    super.key,
    required this.title,
    required this.message,
    this.iconAsset,
    this.actionButtonText,
    this.onActionPressed,
    this.compact = false,
    this.iconColor,
  });

  @override
  State<EmptyStateWidget> createState() => _EmptyStateWidgetState();
}

class _EmptyStateWidgetState extends State<EmptyStateWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
    ));

    _scaleAnimation = Tween<double>(
      begin: 0.7,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.7, curve: Curves.elasticOut),
    ));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.3, 1.0, curve: Curves.easeOut),
    ));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = context.colorScheme.primary;
    final iconColor = widget.iconColor ?? primaryColor;
    
    return Center(
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(
            horizontal: widget.compact ? AppSpacing.s24 : AppSpacing.s32,
            vertical: widget.compact ? AppSpacing.s16 : AppSpacing.s24,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              ScaleTransition(
                scale: _scaleAnimation,
                child: _buildIconContainer(context, iconColor),
              ),
              SizedBox(height: widget.compact ? AppSpacing.s24 : AppSpacing.s32),
              SlideTransition(
                position: _slideAnimation,
                child: Column(
                  children: [
                    _buildTitle(context),
                    SizedBox(height: widget.compact ? AppSpacing.s8 : AppSpacing.s12),
                    _buildMessage(context),
                    if (widget.actionButtonText != null && widget.onActionPressed != null) ...[
                      SizedBox(height: widget.compact ? AppSpacing.s24 : AppSpacing.s32),
                      _buildActionButton(context),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIconContainer(BuildContext context, Color iconColor) {
    final size = widget.compact ? 120.0 : 160.0;
    final iconSize = widget.compact ? 60.0 : 80.0;
    
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 2000),
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, -5 * (0.5 - (value % 1.0 - 0.5).abs())),
          child: Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: iconColor.withOpacity(0.1),
              boxShadow: [
                BoxShadow(
                  color: iconColor.withOpacity(0.15),
                  blurRadius: 40,
                  offset: const Offset(0, 15),
                ),
              ],
            ),
            child: Center(
              child: Container(
                width: size * 0.65,
                height: size * 0.65,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: iconColor.withOpacity(0.15),
                ),
                child: Center(
                  child: widget.iconAsset != null
                      ? SvgPicture.asset(
                          widget.iconAsset!,
                          width: iconSize,
                          height: iconSize,
                          colorFilter: ColorFilter.mode(
                            iconColor,
                            BlendMode.srcIn,
                          ),
                        )
                      : Icon(
                          Icons.inbox_outlined,
                          size: iconSize,
                          color: iconColor,
                        ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Text(
      widget.title,
      style: context.textTheme.headlineSmall?.copyWith(
        fontWeight: FontWeight.bold,
        color: context.colorScheme.onSurface,
        height: 1.2,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildMessage(BuildContext context) {
    return Text(
      widget.message,
      style: context.textTheme.bodyLarge?.copyWith(
        color: context.colorScheme.onSurface.withOpacity(0.6),
        height: 1.5,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildActionButton(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 800),
      curve: Curves.elasticOut,
      builder: (context, value, child) {
        return Transform.scale(
          scale: value,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppRadius.corner16),
              boxShadow: [
                BoxShadow(
                  color: context.colorScheme.primary.withOpacity(0.3),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: ElevatedButton.icon(
              onPressed: widget.onActionPressed,
              icon: const Icon(Icons.add_rounded, size: 24),
              label: Text(
                widget.actionButtonText!,
                style: context.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: context.colorScheme.primary,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(
                  horizontal: widget.compact ? AppSpacing.s28 : AppSpacing.s36,
                  vertical: widget.compact ? AppSpacing.s12 : AppSpacing.s16,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppRadius.corner16),
                ),
                elevation: 0,
              ),
            ),
          ),
        );
      },
    );
  }
}

