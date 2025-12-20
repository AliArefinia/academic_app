import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:academic/core/helper/ui_extention.dart';
import '../../core/theme/const.dart';
import '../../gen/assets.gen.dart';
import 'logic/select_program_language_cubit.dart';

class SelectprogramlanguagePage extends StatelessWidget {
  const SelectprogramlanguagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SelectprogramlanguageCubit, SelectprogramlanguageState>(
      builder: (context, state) {
        final cubit = context.read<SelectprogramlanguageCubit>();
        return Scaffold(
          appBar: AppBar(
            title: const Text('انتخاب زبان برنامه'),
          ),
          body: Column(
            spacing: AppSpacing.s36,
            children: [
              const TopIconAndText(),
              TopLanguageContainer(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _TabButton(
                      tabName: 'فارسی',
                      isActive: state.currentLanguage == 'فارسی',
                      onTap: () => cubit.onLanguageTap('فارسی'),
                    ),
                    _TabButton(
                      tabName: 'انگلیسی',
                      isActive: state.currentLanguage == 'انگلیسی',
                      onTap: () => cubit.onLanguageTap('انگلیسی'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class TopIconAndText extends StatelessWidget {
  const TopIconAndText({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.s12),
      child: Center(
          child: Column(
        children: [
          SvgPicture.asset(Assets.icSelectLanguage),
          const Text('انتخاب زبان مورد نظر')
        ],
      )),
    );
  }
}

class _TabButton extends StatelessWidget {
  final String tabName;
  final bool isActive;
  final VoidCallback onTap;

  const _TabButton({
    required this.tabName,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.s4),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: isActive ? colorScheme.primary : Colors.transparent,
            borderRadius: BorderRadius.circular(AppRadius.corner6),
          ),
          height: AppSpacing.s48,
          width: context.fullWidth * 0.4,
          alignment: Alignment.center,
          child: Text(
            tabName,
            style: context.textTheme.headlineSmall?.copyWith(
              color: isActive ? colorScheme.onPrimary : colorScheme.secondary,
            ),
          ),
        ),
      ),
    );
  }
}

class TopLanguageContainer extends StatelessWidget {
  final Widget child;

  const TopLanguageContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s24),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(AppRadius.corner10),
          border: Border.all(
            color: context.colorScheme.outline,
            width: 1,
          ),
        ),
        width: double.infinity,
        child: child,
      ),
    );
  }
}
