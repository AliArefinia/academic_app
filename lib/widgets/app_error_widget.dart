import 'package:academic/core/theme/theme.dart';
import 'package:academic/core/helper/ui_extention.dart';
import 'package:academic/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:academic/core/error/error_message_mapper.dart';
import 'package:academic/core/theme/const.dart';
import 'package:academic/generated/assets.dart';

class AppErrorWidget extends StatelessWidget {
  final String? message;
  final VoidCallback? onRetry;

  const AppErrorWidget({Key? key, this.message, this.onRetry}) : super(key: key);

  String getDisplayMessage() {
    return ErrorMessageMapper.mapError(message);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.s32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              Assets.assetsIcSearch,
              width: 120,
              height: 120,
            ),
            const SizedBox(height: AppSpacing.s24),
            Text(
              getDisplayMessage(),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(color: context.isDarkMode ? AppTheme.darkOnSurfaceVariant : Colors.grey[700]),
            ),
            const SizedBox(height: AppSpacing.s24),
            if (onRetry != null)
              ElevatedButton.icon(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh),
                label: Text(l10n.retry),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
          ],
        ),
      ),
    );
  }
} 