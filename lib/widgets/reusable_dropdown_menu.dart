import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:academic/core/helper/ui_extention.dart';
import 'package:academic/core/theme/const.dart';

class ReusableDropdownMenu extends StatelessWidget {
  final String text;
  final String iconPath;
  final bool? isIconDifference;
  final VoidCallback? onTap;

  const ReusableDropdownMenu({
    Key? key,
    required this.text,
    required this.iconPath,
    this.onTap, this.isIconDifference,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.s8),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: context.fullWidth * (50 / context.fullWidth),
          padding: EdgeInsets.symmetric(
              vertical: AppSpacing.s12, horizontal: AppSpacing.s16),
          decoration: BoxDecoration(
            color: context.colorScheme.surface,
            borderRadius: BorderRadius.circular(AppRadius.corner8),
          ),
          child: Row(
            children: [
              _buildIcon(context),
              SizedBox(width: AppSpacing.s12),
              Expanded(
                child: Text(
                  text,
                  style: context.textTheme.titleMedium
                      ?.copyWith(fontWeight: FontWeight.w400),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Icon(
                Icons.keyboard_arrow_left,
                color: context.colorScheme.secondary,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIcon(BuildContext context) {
    if (iconPath.endsWith('.svg')) {
      return SvgPicture.asset(
        iconPath,
        width: AppSpacing.s20,
        height: AppSpacing.s20,
        colorFilter: ColorFilter.mode(
          context.colorScheme.onSurface, // Use onSurface instead of secondary for better visibility
          BlendMode.srcIn,
        ),
        fit: isIconDifference != null ? BoxFit.contain : BoxFit.contain,
        placeholderBuilder: (context) => Icon(
          Icons.image,
          size: AppSpacing.s20,
          color: context.colorScheme.onSurface,
        ),
      );
    } else {
      return Image.asset(
        iconPath,
        width: AppSpacing.s20,
        height: AppSpacing.s20,
        color: context.colorScheme.onSurface, // Use onSurface instead of secondary for better visibility
        fit: isIconDifference != null ? BoxFit.contain : BoxFit.contain,
        errorBuilder: (context, error, stackTrace) => Icon(
          Icons.image,
          size: AppSpacing.s20,
          color: context.colorScheme.onSurface,
        ),
      );
    }
  }
}

// در حالت باز شونده
// ReusableDropdownMenu(
// text: "پروفایل",
// iconPath: Assets.assetsicprofile,
// dropdownContent: Center(
// child: Text(
// "محتوای منوی پروفایل",
// style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
// ),
// ),
// ),

// ReusableDropdownMenu(
// text: "تنظیمات",
// iconPath: Assets.assetsicsettings,
// onTap: () {
// Navigator.push(
// context,
// MaterialPageRoute(builder: (context) => SettingsPage()),
// );
// },
// ),
