import 'package:academic/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:academic/core/helper/ui_extention.dart';
import 'package:academic/core/router/router.dart';
import 'package:academic/data/model/book_tour_model.dart';
import '../../core/theme/const.dart';
import '../../data/model/members_liked_clippings.dart';
import '../../data/model/people_comments.dart';
import '../../gen/assets.gen.dart';
import 'logic/share_view_cubit.dart';

class ShareviewPage extends StatelessWidget {
  final String userNameAndFamily;
  final String userImage;
  final String date;
  final String userDescription;
  final String opinion;
  final String personNameAndFamily;
  final String todayDate;
  final int? numOfLike;
  final int? numOfComment;

  const ShareviewPage(
      {super.key,
      required this.userNameAndFamily,
      required this.userImage,
      required this.date,
      required this.opinion,
      this.numOfLike,
      this.numOfComment,
      required this.userDescription,
      required this.personNameAndFamily,
      required this.todayDate});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShareviewCubit, ShareviewState>(
      builder: (context, state) {
        final cubit = context.read<ShareviewCubit>();
        return Scaffold(
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                leading: IconButton(
                  onPressed: () {
                    final bookTour = fakeBookTourList.firstWhere(
                      (book) =>
                          '${book.userName} ${book.userFamily}' ==
                              userNameAndFamily &&
                          book.date == date &&
                          book.description == userDescription,
                    );

                    if (bookTour != null) {
                      bookTour.numOfLike++;
                      bookTour.numOfPeopleComments++;
                    }
                    const BooktourRoute().pushReplacement(context);
                  },
                  icon: const Icon(Icons.arrow_back_outlined),
                ),
                title: Text(
                  l10n.shareOpinion,
                ),
              ),
              SliverToBoxAdapter(
                child: CommentWidget(
                  text: userDescription,
                  userNameAndFamily: userNameAndFamily,
                  date: date,
                  onShareTap: () {},
                  userImage: userImage,
                  numOfComment: (numOfComment ?? 0) + 1,
                  numOfLike: (numOfLike ?? 0) + 1,
                ),
              ),
              SliverToBoxAdapter(
                child: PersonComment(
                  date: todayDate,
                  opinion: opinion,
                  personNameAndFamily: personNameAndFamily,
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

class CommentWidget extends StatelessWidget {
  final String text;
  final String userNameAndFamily;
  final String userImage;
  final String date;
  final VoidCallback onShareTap;
  final int? numOfComment;
  final int? numOfLike;

  const CommentWidget({
    super.key,
    required this.text,
    required this.userNameAndFamily,
    required this.date,
    required this.onShareTap,
    required this.userImage,
    this.numOfComment,
    this.numOfLike,
  });

  @override
  Widget build(BuildContext context) {
    // this is the main container
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.s24, vertical: AppSpacing.s10),
      child: Container(
        decoration: BoxDecoration(
          color: context.colorScheme.background,
          borderRadius: BorderRadius.circular(AppRadius.corner20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 0,
              blurRadius: 40,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        width: double.infinity,
        child: Column(
          spacing: AppSpacing.s16,
          mainAxisSize: MainAxisSize.min,
          children: [
            // these are widgets in main container
            const SizedBox(),
            // this for dividers
            Row(
              children: [
                const Expanded(
                  flex: 1,
                  child: Padding(
                    padding: EdgeInsets.only(right: AppSpacing.s12),
                    child: Divider(
                      color: Color(0xff558219),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: AppSpacing.s16),
                  child: SvgPicture.asset(Assets.icComma),
                ),
                const Expanded(
                  flex: 1,
                  child: Padding(
                    padding: EdgeInsets.only(left: AppSpacing.s12),
                    child: Divider(
                      color: Color(0xff558219),
                    ),
                  ),
                ),
              ],
            ),
            // this for the main clipper(main text)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s8),
              child: Text(
                text,
                style: context.textTheme.bodyLarge
                    ?.copyWith(color: context.colorScheme.outline),
                textAlign: TextAlign.center,
              ),
            ),
            // this only for space
            const SizedBox(),
            // this for comment icon, heart icon, share icon, person profile and who liked the clipper(comment)
            Padding(
              padding: const EdgeInsets.only(
                  left: AppSpacing.s16,
                  right: AppSpacing.s16,
                  bottom: AppSpacing.s20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ProfileSection(
                      image: userImage,
                      userNameAndFamily: userNameAndFamily,
                      date: date),
                  const Spacer(),
                  ActionRowIcons(
                      onSharePressed: onShareTap,
                      onLikePressed: () {},
                      onCommentPressed: () {},
                      numOfLike: numOfLike,
                      numOfPeopleComments: numOfComment)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ActionRowIcons extends StatelessWidget {
  final VoidCallback onSharePressed;
  final VoidCallback onLikePressed;
  final VoidCallback onCommentPressed;
  final int? numOfLike;
  final int? numOfPeopleComments;
  final bool? isLiked;
  final bool? isBookmarked;

  const ActionRowIcons({
    super.key,
    required this.onSharePressed,
    required this.onLikePressed,
    required this.onCommentPressed,
    this.numOfLike,
    this.numOfPeopleComments,
    this.isLiked,
    this.isBookmarked,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
            onPressed: onSharePressed,
            icon: SvgPicture.asset(Assets.icShareMyclippings)),
        IconButton(
            onPressed: onLikePressed,
            icon: Row(
              spacing: AppSpacing.s4,
              children: [
                SvgPicture.asset(
                  isLiked == true
                      ? Assets.icLoveFillRed
                      : Assets.icLikeMyclippings,
                ),
                if ((numOfLike ?? 0) > 0)
                  Text(
                    (numOfLike ?? 0).toString(),
                    style: context.textTheme.labelLarge?.copyWith(
                      color: isLiked == true ? Colors.red : null,
                    ),
                  ),
              ],
            )),
        IconButton(
            onPressed: onCommentPressed,
            icon: Row(
              spacing: AppSpacing.s4,
              children: [
                SvgPicture.asset(Assets.icMessageMyclippings),
                if ((numOfPeopleComments ?? 0) > 0)
                  Text(
                    (numOfPeopleComments ?? 0).toString(),
                    style: context.textTheme.labelLarge,
                  ),
              ],
            )),
      ],
    );
  }
}

class ProfileSection extends StatelessWidget {
  final String image;
  final String userNameAndFamily;
  final String date;

  const ProfileSection(
      {super.key,
      required this.image,
      required this.userNameAndFamily,
      required this.date});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: AppSpacing.s8,
      children: [
        Container(
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 0,
              blurRadius: 20,
              offset: const Offset(0, 10),
            )
          ]),
          child: CircleAvatar(
            radius: AppRadius.corner30,
            backgroundColor: context.colorScheme.background,
            child: CircleAvatar(
              radius: AppRadius.corner25,
              child: Image.asset(image),
            ),
          ),
        ),
        Column(
          spacing: AppSpacing.s4,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              userNameAndFamily,
              style: context.textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.w700,
                color: const Color(0xff558219),
              ),
            ),
            Text(
              date,
              style: context.textTheme.labelMedium,
            )
          ],
        )
      ],
    );
  }
}

class PersonComment extends StatelessWidget {
  final String personNameAndFamily;
  final String date;
  final String opinion;
  final String? personPicture;

  const PersonComment({
    super.key,
    required this.personNameAndFamily,
    required this.date,
    required this.opinion,
    this.personPicture,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          vertical: AppSpacing.s10, horizontal: AppSpacing.s24),
      child: Container(
        decoration: BoxDecoration(
          color: context.theme.colorScheme.background,
          borderRadius: BorderRadius.circular(AppRadius.corner20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 0,
              blurRadius: 40,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        width: double.infinity,
        child: Column(
          spacing: AppSpacing.s16,
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s16),
              child: Row(
                spacing: AppSpacing.s8,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          offset: const Offset(0, 10),
                          blurRadius: 20,
                        ),
                      ],
                    ),
                    child: CircleAvatar(
                      radius: AppRadius.corner30,
                      backgroundColor: context.colorScheme.background,
                      child: CircleAvatar(
                        backgroundColor: context.colorScheme.surfaceContainer,
                        radius: AppRadius.corner25,
                        child: personPicture != null
                            ? Image.asset(personPicture!)
                            : const Icon(
                                Icons.person,
                                size: 35,
                              ),
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            personNameAndFamily,
                            style: context.textTheme.labelLarge
                                ?.copyWith(fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                      Text(
                        date,
                        style: context.textTheme.labelMedium
                            ?.copyWith(fontWeight: FontWeight.w400),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s16),
              child: Text(
                opinion,
                style: context.textTheme.bodyMedium,
                textAlign: TextAlign.start,
              ),
            ),
            const SizedBox(
              height: AppSpacing.s8,
            ),
          ],
        ),
      ),
    );
  }
}
