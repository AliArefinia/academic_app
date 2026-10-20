import 'package:academic/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:academic/core/helper/app_helper.dart';
import 'package:academic/core/helper/ui_extention.dart';
import 'package:academic/core/router/router.dart';
import 'package:academic/core/theme/const.dart';
import 'package:academic/widgets/custom_list_view.dart';
import 'package:academic/widgets/custom_app_bar.dart';
import '../../generated/assets.dart';
import 'logic/author_book_cubit.dart';

class AuthorbookPage extends StatelessWidget {
  const AuthorbookPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthorbookCubit, AuthorbookState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () => MyAppHelper().hideKeyboard(context),
          child: Scaffold(
            appBar: CustomAppBar(
              title: l10n.author,
              icon: Icons.person_outline_rounded,
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s20),
              child: Column(
                children: [
                  Container(
                    height: context.fullHeight * 0.0625,
                    padding:
                        const EdgeInsets.symmetric(horizontal: AppSpacing.s12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(AppRadius.corner12),
                      border: Border.all(color: context.colorScheme.shadow),
                      color: context.colorScheme.onPrimary,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: l10n.searchAuthorTranslatorNarrator,
                              hintStyle: context.textTheme.bodyMedium,
                              border: InputBorder.none,
                            ),
                            style: context.textTheme.labelLarge,
                            textDirection: TextDirection.rtl,
                          ),
                        ),
                        SvgPicture.asset(
                          Assets.assetsIcSearch,
                          width: AppSpacing.s20,
                          height: AppSpacing.s20,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: AppSpacing.s12),
                  CustomListView(
                    items: mainCategories.map((cat) => {
                      ...cat,
                      'action': (BuildContext context) {
                        Navigator.pop(context, cat['title']);
                      }
                    }).toList(),
                    showIcon: false,
                    leadingWidget: SvgPicture.asset(Assets.assetsIcRectangle),
                    ixExpanded: true,
                  ),
                  FilterButtons()
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

final List<Map<String, String>> mainCategories = [
  {"title": "دارن هاردی"},
  {"title": "دارن هاردی"},
  {"title": "دارن هاردی"},
  {"title": "دارن هاردی"},
  {"title": "دارن هاردی"},
  {"title": "دارن هاردی"},
  {"title": "دارن هاردی"},
  {"title": "دارن هاردی"},
  {"title": "دارن هاردی"},
  {"title": "دارن هاردی"},
  {"title": "دارن هاردی"},
  {"title": "دارن هاردی"},
  {"title": "دارن هاردی"},
  {"title": "دارن هاردی"},
  {"title": "دارن هاردی"},
  {"title": "دارن هاردی"},
  {"title": "دارن هاردی"},
  {"title": "دارن هاردی"},
  {"title": "دارن هاردی"},
  {"title": "دارن هاردی"},
  {"title": "دارن هاردی"},
];

class FilterButtons extends StatelessWidget {
  const FilterButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        height: context.fullHeight * 0.1,
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: context.colorScheme.primary,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppRadius.corner12),
                  ),
                ),
                child: Text(
                  l10n.filter,
                  style: context.textTheme.headlineSmall?.copyWith(
                    color: context.colorScheme.onPrimary,
                  ),
                ),
              ),
            ),
            const SizedBox(width: AppSpacing.s16),
            Expanded(
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: context.colorScheme.secondary,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppRadius.corner12),
                  ),
                ),
                child: Text(
                  l10n.clearFilter,
                  style: context.textTheme.headlineSmall?.copyWith(
                    color: context.colorScheme.onPrimary,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
