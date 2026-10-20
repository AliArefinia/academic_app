import 'package:flutter/material.dart';
import 'package:academic/core/theme/theme.dart';
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

  bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;

  // Theme-aware neutrals. Light-mode values are the colors the app used
  // before dark mode was supported, so the light UI is unchanged.

  /// Card / sheet background (white in light mode).
  Color get cardBackground =>
      isDarkMode ? AppTheme.darkSurfaceColor : Colors.white;

  /// Muted fill for placeholders and chips (grey 200 in light mode).
  Color get mutedFill =>
      isDarkMode ? AppTheme.darkSurfaceContainer : Colors.grey.shade200;

  /// Light border / divider (grey 300 in light mode).
  Color get subtleBorder =>
      isDarkMode ? AppTheme.darkOutlineColor : Colors.grey.shade300;

  /// Secondary text and icons (grey 600 in light mode).
  Color get secondaryText =>
      isDarkMode ? AppTheme.darkOnSurfaceVariant : Colors.grey.shade600;

  /// Strong text (black 87% in light mode).
  Color get strongText => isDarkMode ? AppTheme.darkTextColor : Colors.black87;

  // Padding values
  double get paddingTiny => 4.0;
  double get paddingSmall => 8.0;
  double get paddingDefault => 16.0;
  double get paddingLarge => 24.0;
  double get paddingExtraLarge => 32.0;
}
