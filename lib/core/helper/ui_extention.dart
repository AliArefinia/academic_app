import 'package:flutter/material.dart';
import 'package:academic/l10n/app_localizations.dart';

extension VerticalSpacing on Widget {
  Widget addVerticalSpacing(double height) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        this,
        SizedBox(height: height),
      ],
    );
  }
}

extension HorizontalSpacing on Widget {
  Widget addHorizontalSpacing(double width) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        this,
        SizedBox(width: width),
      ],
    );
  }
}

extension MyThemeExtension on BuildContext {
  ThemeData get theme => Theme.of(this);

  TextTheme get textTheme => Theme.of(this).textTheme;

  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  MediaQueryData get mediaQuery => MediaQuery.of(this);

  double get fullHeight => MediaQuery.of(this).size.height;

  double get fullWidth => MediaQuery.of(this).size.width;

  AppLocalizations? get appTranslate => AppLocalizations.of(this);

  // Padding values
  double get paddingTiny => 4.0;
  double get paddingSmall => 8.0;
  double get paddingDefault => 16.0;
  double get paddingLarge => 24.0;
  double get paddingExtraLarge => 32.0;
}
