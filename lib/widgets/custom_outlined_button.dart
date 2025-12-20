import 'package:flutter/material.dart';
import 'package:academic/core/helper/ui_extention.dart';
import 'package:academic/core/theme/const.dart';
import 'package:academic/core/theme/theme.dart';

class CustomOutlinedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const CustomOutlinedButton({
    Key? key,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: AppTheme.shadow),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.corner8),
          ),
        ),
        child: Text(
          text,
          style: context.textTheme.titleMedium
              ?.copyWith(fontWeight: FontWeight.w400, fontSize: 14),
        ),
      ),
    );
  }
}
