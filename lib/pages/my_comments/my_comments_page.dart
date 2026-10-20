import 'package:academic/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:academic/core/helper/ui_extention.dart';
import 'package:academic/core/router/router.dart';
import 'package:academic/data/model/registered_comments_model.dart';
import 'package:academic/pages/gift_card/gift_card_page.dart';
import 'package:academic/widgets/main_button.dart';
import 'package:academic/widgets/fade_in_image.dart';
import '../../core/helper/app_helper.dart';
import '../../core/theme/const.dart';
import '../../gen/assets.gen.dart';
import 'logic/my_comments_cubit.dart';
import 'package:academic/core/storage/local_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:academic/data/repository/product_repository.dart';
import 'package:academic/widgets/custom_button.dart';
import 'package:academic/widgets/custom_app_bar.dart';
import 'package:academic/data/api/home/model/book_model.dart';

class MycommentsPage extends StatefulWidget {
  final String bookName;
  final String bookImage;
  final int rate;
  final int productId;

  const MycommentsPage({
    super.key,
    required this.bookName,
    required this.bookImage,
    required this.rate,
    required this.productId,
  });

  @override
  State<MycommentsPage> createState() => _MycommentsPageState();
}

class _MycommentsPageState extends State<MycommentsPage> {
  late TextEditingController commentController;

  @override
  void initState() {
    super.initState();
    commentController = TextEditingController();
    commentController.addListener(() {
      setState(() {});
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MycommentsCubit>().rateAction(widget.rate);
    });
  }

  @override
  void dispose() {
    commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('RATE in MycommentsPage: [34m${widget.rate}[0m');
    final user = GetIt.I<LocalStorage>().getUser();
    final phoneOrName = (user?.name.isNotEmpty ?? false) ? user!.name : user?.phone ?? '';
    final cubit = context.read<MycommentsCubit>();

    return BlocConsumer<MycommentsCubit, MycommentsState>(
      listener: (context, state) {
        if (state.success) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(l10n.commentSubmittedSuccessfully),
              backgroundColor: Colors.green,
            ),
          );
          Future.delayed(const Duration(milliseconds: 300), () {
            ProductRoute(BookModel(id: widget.productId.toString())).replace(context);
          });
        }
        if (state.error != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error!), backgroundColor: Colors.red),
          );
        }
      },
      builder: (context, state) {
        return GestureDetector(
          onTap: () => MyAppHelper().hideKeyboard(context),
          child: Scaffold(
            appBar: CustomAppBar(
              title: l10n.myComments,
              icon: Icons.comment_rounded,
            ),
            body: state.isContinued
                ? SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s20),
                      child: Column(
                        spacing: AppSpacing.s20,
                        children: [
                          if (phoneOrName.isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.only(top: 16, bottom: 8),
                              child: Text(phoneOrName, style: context.textTheme.titleMedium),
                            ),
                          TopContainer(
                            bookImage: widget.bookImage,
                            bookName: widget.bookName,
                            rate: state.rate,
                            opinion: state.opinion,
                            onRateChanged: (rating) => cubit.rateAction(rating),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(AppRadius.corner10),
                              color: context.colorScheme.surface,
                              border: Border.all(
                                color: state.showCommentError ? context.colorScheme.error : Colors.transparent,
                                width: 1,
                              ),
                            ),
                            width: double.infinity,
                            height: context.fullHeight * 0.25,
                            child: TextField(
                              controller: commentController,
                              maxLines: null,
                              keyboardType: TextInputType.multiline,
                              style: context.textTheme.bodyMedium,
                              onChanged: (value) {
                                if (state.showCommentError && value.isNotEmpty) {
                                  cubit.emit(state.copyWith(showCommentError: false));
                                }
                              },
                              decoration: InputDecoration(
                                hintText: l10n.yourComment,
                                hintStyle: context.textTheme.bodyMedium,
                                border: const OutlineInputBorder(borderSide: BorderSide.none),
                                errorText: state.showCommentError ? l10n.pleaseEnterComment : null,
                                errorStyle: context.textTheme.bodySmall?.copyWith(
                                  color: context.colorScheme.error,
                                ),
                              ),
                            ),
                          ),
                          Column(
                            children: [
                              Builder(
                                builder: (context) => CustomButton(
                                  onPressed: () async {
                                    if (state.rate == 0) {
                                      cubit.emit(state.copyWith(showRateError: true));
                                      return;
                                    }
                                    if (commentController.text.trim().isEmpty) {
                                      cubit.emit(state.copyWith(showCommentError: true));
                                      return;
                                    }
                                    await cubit.submitReview(
                                      productId: widget.productId,
                                      comment: commentController.text,
                                      rate: state.rate,
                                      recommendation: state.opinion == l10n.yes
                                          ? 1
                                          : state.opinion == l10n.no
                                              ? -1
                                              : 0,
                                    );
                                  },
                                  child: Text(
                                    state.isLoading ? l10n.sending : l10n.submitComment,
                                    style: context.textTheme.headlineMedium?.copyWith(
                                      color: context.colorScheme.secondary,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s20),
                    child: Column(
                      spacing: AppSpacing.s30,
                      children: [
                        MainContainer(
                          bookImage: widget.bookImage,
                          personRate: state.rate,
                          onRateChanged: (rating) => cubit.rateAction(rating),
                        ),
                        MainButton(
                          textColor: context.colorScheme.secondary,
                          text: l10n.continueLabel,
                          backgroundColor: context.colorScheme.primary,
                          onPressed: () {
                            cubit.changePageStatus();
                          },
                        )
                      ],
                    ),
                  ),
          ),
        );
      },
    );
  }
}

class MainContainer extends StatelessWidget {
  final String bookImage;
  final int personRate;
  final ValueChanged<int> onRateChanged;

  const MainContainer({
    super.key,
    required this.bookImage,
    required this.personRate,
    required this.onRateChanged,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<MycommentsCubit>();
    final state = context.watch<MycommentsCubit>().state;

    final stars = List.generate(5, (index) {
      final starIndex = index + 1;
      return GestureDetector(
        onTap: () => onRateChanged(starIndex),
        child: SvgPicture.asset(
          personRate >= starIndex
              ? Assets.icBigStarYellow
              : Assets.icBigStarTransparent,
        ),
      );
    });

    return Container(
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: BorderRadius.circular(AppRadius.corner10),
      ),
      width: double.infinity,
      height: context.fullHeight * 0.6,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          FadeInNetworkImage(
            imageUrl: bookImage,
            fit: BoxFit.fill,
            height: context.fullHeight * 0.25,
          ),
          Text(
            l10n.howWasYourReadingExperience,
            style: context.textTheme.titleLarge,
            textAlign: TextAlign.center,
          ),
          Text(
            l10n.helpOthersReadBetter,
            style: context.textTheme.bodySmall,
          ),
          Row(
            spacing: AppSpacing.s4,
            mainAxisAlignment: MainAxisAlignment.center,
            children: stars,
          ),
          Text(
            l10n.doYouRecommendBook,
            style: context.textTheme.bodySmall,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              OpinionContainer(
                text: l10n.yes,
                isSelected: state.opinion == l10n.yes,
                onTap: () => cubit.selectOpinion(l10n.yes),
              ),
              OpinionContainer(
                text: l10n.notSure,
                isSelected: state.opinion == l10n.notSure,
                onTap: () => cubit.selectOpinion(l10n.notSure),
              ),
              OpinionContainer(
                text: l10n.no,
                isSelected: state.opinion == l10n.no,
                onTap: () => cubit.selectOpinion(l10n.no),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class OpinionContainer extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onTap;

  const OpinionContainer({
    super.key,
    required this.text,
    required this.onTap,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? context.colorScheme.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(AppRadius.corner8),
          border: Border.all(color: context.colorScheme.primary, width: 1),
        ),
        height: context.fullHeight * 0.035,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s20),
            child: Text(text, style: context.textTheme.bodySmall),
          ),
        ),
      ),
    );
  }
}

class TopContainer extends StatelessWidget {
  final String bookImage;
  final String bookName;
  final int rate;
  final String opinion;
  final ValueChanged<int> onRateChanged;

  const TopContainer(
      {super.key,
      required this.bookImage,
      required this.bookName,
      required this.rate,
      required this.opinion,
      required this.onRateChanged});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<MycommentsCubit>().state;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppRadius.corner10),
        color: context.colorScheme.surface,
        shape: BoxShape.rectangle,
      ),
      height: context.fullHeight * 0.15,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.s12),
        child: Row(
          spacing: AppSpacing.s12,
          children: [
            FadeInNetworkImage(
              imageUrl: bookImage,
              height: context.fullHeight * 0.15,
              width: context.fullWidth * 0.2,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.bookWithName(bookName.toString()),
                  style: context.textTheme.labelLarge
                      ?.copyWith(fontWeight: FontWeight.w700),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      spacing: AppSpacing.s4,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(5, (index) {
                        final starIndex = index + 1;
                        return GestureDetector(
                          onTap: () => onRateChanged(starIndex),
                          child: rate >= starIndex
                              ? SvgPicture.asset(Assets.icSmallStarYellow)
                              : SvgPicture.asset(Assets.icSmallStarTransparent),
                        );
                      }),
                    ),
                    if (state.showRateError)
                      Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Text(
                          l10n.pleaseEnterRating,
                          style: context.textTheme.bodySmall?.copyWith(
                            color: context.colorScheme.error,
                          ),
                        ),
                      ),
                  ],
                ),
                Container(
                  decoration: BoxDecoration(
                      color: context.colorScheme.primary,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(AppRadius.corner4),
                      border: Border.all(
                        color: context.colorScheme.secondary,
                        width: 1,
                      )),
                  width: context.fullWidth * 0.27,
                  height: AppSpacing.s20,
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(AppSpacing.s2),
                        child: CircleAvatar(
                          backgroundColor: context.colorScheme.secondary,
                          radius: AppRadius.corner10,
                        ),
                      ),
                      Text(
                        opinion == l10n.yes
                            ? l10n.iRecommend
                            : opinion == l10n.notSure
                                ? l10n.notSure
                                : opinion == l10n.no
                                    ? l10n.iDontRecommend
                                    : '',
                        style: context.textTheme.labelSmall,
                      )
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class TextFieldContainer extends StatelessWidget {
  const TextFieldContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppRadius.corner10),
        color: context.colorScheme.surface,
      ),
      width: double.infinity,
      height: context.fullHeight * 0.45,
      child: TextField(
        maxLines: null,
        keyboardType: TextInputType.multiline,
        style: context.textTheme.bodyMedium,
        decoration: InputDecoration(
          hintText: l10n.yourComment,
          hintStyle: context.textTheme.bodyMedium,
          border: const OutlineInputBorder(borderSide: BorderSide.none),
        ),
      ),
    );
  }
}
