import 'package:flutter/material.dart';
import 'package:academic/core/helper/ui_extention.dart';
import 'package:academic/core/settings/app_settings.dart';
import 'package:academic/core/theme/const.dart';
import 'package:academic/l10n/l10n.dart';
import 'package:academic/widgets/custom_app_bar.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = AppSettings.instance;
    return ListenableBuilder(
      listenable: settings,
      builder: (context, _) {
        return Scaffold(
          appBar: CustomAppBar(
            title: l10n.settings,
            icon: Icons.settings_rounded,
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(vertical: AppSpacing.s24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _SectionTitle(title: l10n.appTheme),
                _OptionsContainer(
                  children: [
                    _OptionButton(
                      label: l10n.themeSystem,
                      isActive: settings.themeMode == ThemeMode.system,
                      onTap: () => settings.setThemeMode(ThemeMode.system),
                    ),
                    _OptionButton(
                      label: l10n.themeLight,
                      isActive: settings.themeMode == ThemeMode.light,
                      onTap: () => settings.setThemeMode(ThemeMode.light),
                    ),
                    _OptionButton(
                      label: l10n.themeDark,
                      isActive: settings.themeMode == ThemeMode.dark,
                      onTap: () => settings.setThemeMode(ThemeMode.dark),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.s32),
                _SectionTitle(title: l10n.appLanguage),
                _OptionsContainer(
                  children: [
                    _OptionButton(
                      label: l10n.persian,
                      isActive: settings.locale == AppSettings.persianLocale,
                      onTap: () => settings.setLocale(AppSettings.persianLocale),
                    ),
                    _OptionButton(
                      label: l10n.english,
                      isActive: settings.locale == AppSettings.englishLocale,
                      onTap: () => settings.setLocale(AppSettings.englishLocale),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;

  const _SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
          AppSpacing.s24, 0, AppSpacing.s24, AppSpacing.s12),
      child: Text(title, style: context.textTheme.titleMedium),
    );
  }
}

class _OptionsContainer extends StatelessWidget {
  final List<Widget> children;

  const _OptionsContainer({required this.children});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s24),
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.s4),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(AppRadius.corner10),
          border: Border.all(color: context.colorScheme.outline, width: 1),
        ),
        child: Row(
          children: [
            for (final child in children) Expanded(child: child),
          ],
        ),
      ),
    );
  }
}

class _OptionButton extends StatelessWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _OptionButton({
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: AppDuration.standardDuration,
        height: AppSpacing.s48,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isActive ? colorScheme.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(AppRadius.corner6),
        ),
        child: Text(
          label,
          style: context.textTheme.headlineSmall?.copyWith(
            color: isActive ? colorScheme.onPrimary : colorScheme.onSurface,
          ),
        ),
      ),
    );
  }
}
