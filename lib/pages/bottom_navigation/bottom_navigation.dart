import 'package:academic/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:academic/core/helper/ui_extention.dart';

class BottomNavigationWidget extends StatelessWidget {
  const BottomNavigationWidget(
      {super.key, this.onTap, required this.currentIndex});

  final ValueChanged<int>? onTap;
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      selectedIconTheme: IconThemeData(
        color: context.theme.colorScheme.primary,
      ),
      unselectedIconTheme: IconThemeData(
        color: context.theme.colorScheme.secondary,
      ),
      currentIndex: currentIndex,
      enableFeedback: false,
      useLegacyColorScheme: false,
      selectedLabelStyle: context.textTheme.labelMedium
          ?.copyWith(color: context.theme.colorScheme.onSurface),
      unselectedLabelStyle: context.textTheme.labelSmall,
      type: BottomNavigationBarType.fixed,
      showUnselectedLabels: true,
      showSelectedLabels: true,
      onTap: onTap,
      selectedItemColor: context.colorScheme.primary,
      unselectedItemColor: context.theme.colorScheme.outlineVariant,
      items: [
        BottomNavigationBarItem(
          activeIcon: Icon(
            Icons.home,
            color: context.theme.colorScheme.primary,
          ),
          icon: Icon(
            Icons.home_outlined,
            color: context.theme.colorScheme.outlineVariant,
          ),
          label: l10n.home,
        ),
        BottomNavigationBarItem(
          activeIcon: Icon(
            Icons.person,
            color: context.theme.colorScheme.primary,
          ),
          icon: Icon(
            Icons.person_outline,
            color: context.theme.colorScheme.outlineVariant,
          ),
          label: l10n.profile,
        ),
        BottomNavigationBarItem(
          activeIcon: Icon(
            Icons.shopping_bag,
            color: context.theme.colorScheme.primary,
          ),
          icon: Icon(
            Icons.shopping_bag_outlined,
            color: context.theme.colorScheme.outlineVariant,
          ),
          label: l10n.marketplace,
        ),
        BottomNavigationBarItem(
          activeIcon: Icon(
            Icons.category,
            color: context.theme.colorScheme.primary,
          ),
          icon: Icon(
            Icons.category_outlined,
            color: context.theme.colorScheme.outlineVariant,
          ),
          label: l10n.categoriesTab,
        ),
        BottomNavigationBarItem(
          activeIcon: Icon(
            Icons.book,
            color: context.theme.colorScheme.primary,
          ),
          icon: Icon(
            Icons.book_outlined,
            color: context.theme.colorScheme.outlineVariant,
          ),
          label: l10n.myBooks,
        ),
      ],
    );
  }
}
