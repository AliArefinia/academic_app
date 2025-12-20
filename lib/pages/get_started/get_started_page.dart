import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:academic/core/helper/ui_extention.dart';
import 'package:academic/core/router/router.dart';
import 'package:academic/core/theme/const.dart';
import 'package:academic/data/model/language_model.dart';
import 'package:academic/gen/assets.gen.dart';
import 'package:academic/pages/select_language_page/bloc/language_bloc.dart';
import 'package:universal_image_flutter/universal_image_flutter.dart';
import '../reviews_and_rating/logic/reviews_and_rating_cubit.dart';
import 'logic/get_started_cubit.dart';

class GetStartedPage extends StatelessWidget {
  const GetStartedPage({super.key});

  @override
  Widget build(BuildContext context) {
    var langController = context.read<LanguageBloc>();

    return BlocBuilder<GetStartedCubit, GetStartedState>(
      builder: (context, state) {
        return Directionality(
          textDirection: TextDirection.ltr,
          child: Scaffold(
            appBar: AppBar(backgroundColor: Colors.transparent,),
            backgroundColor: context.colorScheme.primary,
            body: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: AppSpacing.s24, horizontal: AppSpacing.s32),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  spacing: AppSpacing.s32,
                  children: [
                    const SizedBox(
                      height: AppSpacing.s16,
                    ),
                    UniversalImageLoader(
                      path: Assets.icLogo.path,
                      option: UniversalImageLoaderOption(
                        width: context.fullWidth / 5,
                        height: context.fullWidth / 5,
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(
                      height: AppSpacing.s16,
                    ),
                    Container(
                      constraints:
                          BoxConstraints(minHeight: context.fullHeight / 13),
                      child: Text(
                        context.appTranslate?.getStartedPageText ?? '',
                        textAlign: TextAlign.center,
                        style: context.textTheme.titleMedium
                            ?.copyWith(color: context.colorScheme.onPrimary),
                      ),
                    ),
                    UniversalImageLoader(
                      path: Assets.icPoints.path,
                    ),
                    const SizedBox(
                      height: AppSpacing.s16,
                    ),
                    Wrap(
                      spacing: AppSpacing.s16,
                      children: Language.languageList
                          .map(
                            (e) => GestureDetector(
                              onTap: () => langController.add(
                                  LanguageEvent.changeLanguage(
                                      selectedLanguage: e)),
                              child: Container(
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        color: e.locale.languageCode ==
                                                Localizations.localeOf(context)
                                                    .languageCode
                                            ? context.colorScheme.secondary
                                            : Colors.transparent)),
                                child: UniversalImageLoader(
                                  path: e.flag,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                    OutlinedButton(
                        onPressed: () {
                          const IntroRoute().go(context);
                        },
                        style: const ButtonStyle(
                            side: WidgetStatePropertyAll(
                                BorderSide(color: Colors.white)),
                            surfaceTintColor:
                                WidgetStatePropertyAll(Colors.white),
                            foregroundColor:
                                WidgetStatePropertyAll(Colors.white)),
                        child: Text('ورود به برنامه')),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
