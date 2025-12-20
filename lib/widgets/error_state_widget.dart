import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:academic/core/error/error_message_mapper.dart';
import 'package:academic/core/error/error_type.dart';
import 'package:academic/core/theme/const.dart';
import 'package:academic/core/helper/ui_extention.dart';

/// A professional and beautiful error state widget with animations
class ErrorStateWidget extends StatefulWidget {
  /// The error message or exception
  final dynamic error;
  
  /// Callback when retry button is pressed
  final VoidCallback? onRetry;
  
  /// Custom title (optional)
  final String? title;
  
  /// Custom message (optional, overrides error mapping)
  final String? message;
  
  /// Whether to show the retry button
  final bool showRetryButton;
  
  /// Custom retry button text
  final String? retryButtonText;
  
  /// Whether to use compact layout (for smaller spaces)
  final bool compact;

  const ErrorStateWidget({
    super.key,
    this.error,
    this.onRetry,
    this.title,
    this.message,
    this.showRetryButton = true,
    this.retryButtonText,
    this.compact = false,
  });

  @override
  State<ErrorStateWidget> createState() => _ErrorStateWidgetState();
}

class _ErrorStateWidgetState extends State<ErrorStateWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
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
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.6, curve: Curves.easeOutBack),
    ));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
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

  ErrorType get _errorType => ErrorTypeDetector.detect(widget.error);

  String get _displayMessage {
    if (widget.message != null) return widget.message!;
    return ErrorMessageMapper.mapError(widget.error);
  }

  String get _displayTitle {
    if (widget.title != null) return widget.title!;
    
    switch (_errorType) {
      case ErrorType.network:
        return 'مشکل در اتصال';
      case ErrorType.server:
        return 'خطای سرور';
      case ErrorType.timeout:
        return 'زمان اتصال تمام شد';
      case ErrorType.notFound:
        return 'یافت نشد';
      case ErrorType.unauthorized:
        return 'دسترسی غیرمجاز';
      case ErrorType.forbidden:
        return 'دسترسی ممنوع';
      case ErrorType.validation:
        return 'اطلاعات نامعتبر';
      case ErrorType.parse:
        return 'خطا در پردازش';
      case ErrorType.unknown:
        return 'خطا رخ داده است';
    }
  }

  Color get _iconColor {
    switch (_errorType) {
      case ErrorType.network:
        return const Color(0xFFF59E0B); // Amber
      case ErrorType.server:
      case ErrorType.timeout:
        return const Color(0xFFEF4444); // Red
      case ErrorType.notFound:
        return const Color(0xFF6B7280); // Gray
      case ErrorType.unauthorized:
      case ErrorType.forbidden:
        return const Color(0xFFDC2626); // Dark Red
      case ErrorType.validation:
      case ErrorType.parse:
        return const Color(0xFFF97316); // Orange
      case ErrorType.unknown:
        return const Color(0xFF8B5CF6); // Purple
    }
  }

  Color get _backgroundColor {
    return _iconColor.withOpacity(0.1);
  }

  @override
  Widget build(BuildContext context) {
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
                child: _buildIconContainer(context),
              ),
              SizedBox(height: widget.compact ? AppSpacing.s20 : AppSpacing.s32),
              SlideTransition(
                position: _slideAnimation,
                child: Column(
                  children: [
                    _buildTitle(context),
                    SizedBox(height: widget.compact ? AppSpacing.s8 : AppSpacing.s12),
                    _buildMessage(context),
                    if (widget.showRetryButton && widget.onRetry != null) ...[
                      SizedBox(height: widget.compact ? AppSpacing.s24 : AppSpacing.s32),
                      _buildRetryButton(context),
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

  Widget _buildIconContainer(BuildContext context) {
    final size = widget.compact ? 100.0 : 140.0;
    final iconSize = widget.compact ? 50.0 : 70.0;
    
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 1200),
      builder: (context, value, child) {
        return Transform.rotate(
          angle: value * 0.1 - 0.05,
          child: Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _backgroundColor,
              boxShadow: [
                BoxShadow(
                  color: _iconColor.withOpacity(0.2),
                  blurRadius: 30,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Center(
              child: Container(
                width: size * 0.7,
                height: size * 0.7,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _iconColor.withOpacity(0.15),
                ),
                child: Center(
                  child: SvgPicture.asset(
                    _errorType.iconAsset,
                    width: iconSize,
                    height: iconSize,
                    colorFilter: ColorFilter.mode(
                      _iconColor,
                      BlendMode.srcIn,
                    ),
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
      _displayTitle,
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
      _displayMessage,
      style: context.textTheme.bodyLarge?.copyWith(
        color: context.colorScheme.onSurface.withOpacity(0.7),
        height: 1.5,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildRetryButton(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeOutBack,
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
              onPressed: widget.onRetry,
              icon: const Icon(Icons.refresh_rounded, size: 24),
              label: Text(
                widget.retryButtonText ?? 'تلاش مجدد',
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

