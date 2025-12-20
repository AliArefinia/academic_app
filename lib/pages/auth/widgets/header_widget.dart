import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:academic/core/helper/ui_extention.dart';
import 'package:universal_image_flutter/universal_image_loader.dart';

import '../../../core/helper/app_helper.dart';
import '../../../core/theme/const.dart';
import '../../../gen/assets.gen.dart';

Widget authHeaderWidget(BuildContext context) {
  return Center(
    child: AnimatedContainer(
      margin: EdgeInsets.only(
          top: MyAppHelper().isKeyboardVisible(context) ? AppSpacing.s32 : 0),
      duration: AppDuration.standardDuration,
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s24),
      height: MyAppHelper().isKeyboardVisible(context)
          ? 0
          : context.fullHeight / 4.5,
      width:
          MyAppHelper().isKeyboardVisible(context) ? 0 : context.fullWidth / 4,
      decoration: BoxDecoration(
          color: context.colorScheme.primary,
          borderRadius: const BorderRadius.only(
              bottomRight: Radius.circular(48),
              bottomLeft: Radius.circular(48))),
      child: Stack(
        children: [
          Positioned(
            bottom: AppSpacing.s32,
            left: 0,
            right: 0,
            child: UniversalImageLoader(
              path: Assets.icLogo.path,
              option: const UniversalImageLoaderOption(
                width: 70,
                height: 70,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ],
      ),
    ),
  ).addVerticalSpacing(AppSpacing.s32);
}
