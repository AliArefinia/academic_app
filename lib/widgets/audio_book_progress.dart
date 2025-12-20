import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:academic/core/helper/ui_extention.dart';
import 'package:academic/core/theme/const.dart';
import 'package:universal_image_flutter/universal_image_flutter.dart';

import '../core/helper/image_ur_handler.dart';
import '../generated/assets.dart';

class AudioBookProgress extends StatelessWidget {
  final String bookTitle;
  final String bookDetails;
  final int progress;
  final String bookIcon;
  final VoidCallback? onTap;
  final String? bookType; // 'audio' or 'text' or null

  const AudioBookProgress({
    super.key,
    required this.bookTitle,
    required this.bookDetails,
    required this.progress,
    required this.bookIcon,
    this.onTap,
    this.bookType,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 300,
        height: 130,
        decoration: BoxDecoration(
          color: Theme.of(context).cardTheme.color ?? context.colorScheme.surface,
          borderRadius: BorderRadius.circular(AppRadius.corner12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              spreadRadius: 0,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.s12, vertical: AppSpacing.s12),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(AppRadius.corner8),
                child: UniversalImageLoader(
                  path: buildImageUrl(bookIcon) ?? '',
                  option: UniversalImageLoaderOption(
                    width: 60,
                    height: 90,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.s10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      bookTitle,
                      style: context.textTheme.labelLarge,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: AppSpacing.s2),
                    Text(
                      'نویسنده نا مشخص',
                      style: context.textTheme.labelSmall?.copyWith(fontSize: 9),
                    ),
                    const Spacer(),
                    LinearProgressIndicator(
                      value: progress / 100,
                      backgroundColor: context.colorScheme.shadow,
                      color: context.colorScheme.secondary,
                    ),
                    const SizedBox(height: AppSpacing.s8),
                    Row(
                      children: [
                        Text(
                          bookType == 'audio' 
                              ? '$progress٪ شنیده اید'
                              : '$progress٪ خوانده اید',
                          style: TextStyle(
                            fontSize: 10,
                            color: context.colorScheme.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const Spacer(),
                        SvgPicture.asset(
                          Assets.assetsIcDonn,
                          width: AppSpacing.s20,
                          height: AppSpacing.s16,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
