import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:academic/core/helper/ui_extention.dart';
import 'package:academic/core/theme/const.dart';

class MainButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final Color? textColor;
  final bool isLoading;
  final double? radius;
  final double? textSize;
  final double? height;

  const MainButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.backgroundColor,
    this.textColor,
    this.isLoading = false,
    this.radius,
    this.textSize,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    final borderRadius = radius ?? AppRadius.corner10;
    return SizedBox(
      width: double.infinity,
      height: height,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? context.colorScheme.primary,
          foregroundColor: textColor ?? context.colorScheme.onPrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        child: isLoading
            ? SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    textColor ?? context.colorScheme.onPrimary,
                  ),
                ),
              )
            : Text(
                text,
                style: context.textTheme.titleSmall?.copyWith(
                  color: textColor ?? context.colorScheme.onPrimary,
                  fontWeight: FontWeight.w600,
                  fontSize: textSize,
                ),
              ),
      ),
    );
  }
}
