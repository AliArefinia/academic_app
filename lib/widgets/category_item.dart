import 'package:flutter/material.dart';
import 'package:academic/core/helper/ui_extention.dart';
import 'package:academic/core/theme/const.dart';
import 'package:academic/widgets/fade_in_image.dart';

class CategoryItem extends StatelessWidget {
  final String iconPath;
  final String title;
  final VoidCallback? onTap;

  const CategoryItem({
    super.key,
    required this.iconPath,
    required this.title,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: context.colorScheme.primary,
          borderRadius: BorderRadius.circular(AppRadius.corner8),
        ),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: AppSpacing.s4),
              FadeInNetworkImage(
                imageUrl: iconPath,
              height: 20,
              width: 20,
              ),
              const SizedBox(height: AppSpacing.s12),
              Text(
                title,
                textAlign: TextAlign.center,
                style: context.textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: context.colorScheme.onPrimary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
