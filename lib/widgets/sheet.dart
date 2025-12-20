import 'package:flutter/cupertino.dart';
import 'package:academic/core/router/router.dart';
import 'package:smooth_sheets/smooth_sheets.dart';

showCupertinoStyleSheet(BuildContext context, Widget page) {
  DefaultSheetController.maybeOf(context)
      ?.animateTo(const Extent.proportional(1));
  Navigator.push(
    context,
    CupertinoModalSheetRoute(
      swipeDismissible: true,
      builder: (context) => page,
    ),
  );
}
