import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:academic/core/helper/ui_extention.dart';

import '../core/theme/const.dart';

class MainButtonWithShadow extends StatelessWidget {
  final String text;
  final Color backgroundColor;
  final VoidCallback onPressed;
  final double? radius;
  final Color? textColor;

  const MainButtonWithShadow(
      {super.key,
        required this.text,
        required this.backgroundColor,
        required this.onPressed,
        this.radius, this.textColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
        boxShadow: [
          BoxShadow(
            color: context.colorScheme.shadow.withOpacity(0.1),
            spreadRadius: 0,
            blurRadius: 40,
            offset: const Offset(0, 4),
          ),
        ]
      ),
        width: double.infinity,
        height: AppSpacing.s52,
        child: FilledButton(
          style: ButtonStyle(
            shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular((radius ?? AppRadius.corner10).toDouble()),
              ),
            ),
            backgroundColor:
            WidgetStatePropertyAll(backgroundColor),
          ),
          onPressed: onPressed,
          child: Text(
            text,
            style: context.textTheme.bodyLarge
                ?.copyWith(color: textColor ?? context.colorScheme.onPrimary, fontWeight: FontWeight.w700),
          ),
        ));
  }
}
