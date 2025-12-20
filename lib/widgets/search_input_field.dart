import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:academic/core/helper/ui_extention.dart';
import 'package:academic/core/theme/const.dart';
import '../../generated/assets.dart';

class SearchInputField extends StatelessWidget {
  final String Text;
  final TextEditingController? controller;
  final VoidCallback? onTap;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final VoidCallback? onEditingComplete;

  const SearchInputField({
    super.key,
    required this.Text,
    this.controller,
    this.onTap,
    this.onChanged,
    this.onSubmitted,
    this.onEditingComplete,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      height: context.fullHeight * 0.0625,
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppRadius.corner12),
        color: isDark 
            ? context.colorScheme.surfaceContainerHighest 
            : context.colorScheme.surface,
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              onTap: onTap,
              onChanged: onChanged,
              onSubmitted: onSubmitted,
              onEditingComplete: onEditingComplete,
              decoration: InputDecoration(
                hintText: Text,
                hintStyle: context.textTheme.bodyMedium,
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                focusedErrorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                contentPadding: EdgeInsets.zero,
              ),
              style: context.textTheme.labelLarge,
              textDirection: TextDirection.rtl,
            ),
          ),
          if (controller != null && controller!.text.isNotEmpty)
            GestureDetector(
              onTap: () {
                controller!.clear();
                if (onChanged != null) onChanged!("");
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: Icon(
                  Icons.close, 
                  size: AppSpacing.s20, 
                  color: context.colorScheme.onSurfaceVariant,
                ),
              ),
            )
          else
            SvgPicture.asset(
              Assets.assetsIcSearch,
              width: AppSpacing.s20,
              height: AppSpacing.s20,
              colorFilter: ColorFilter.mode(
                context.colorScheme.onSurfaceVariant,
                BlendMode.srcIn,
              ),
            ),
        ],
      ),
    );
  }
}
