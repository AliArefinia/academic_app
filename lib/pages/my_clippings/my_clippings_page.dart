import 'package:academic/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:academic/core/helper/ui_extention.dart';
import 'package:academic/core/router/router.dart';
import 'package:academic/core/theme/const.dart';
import 'package:academic/data/model/members_liked_clippings.dart';
import 'package:academic/data/model/people_comments.dart';
import 'package:academic/data/model/my_book_excerpt.dart';
import 'package:academic/widgets/error_state_widget.dart';
import 'package:academic/widgets/custom_app_bar.dart';
import 'package:academic/widgets/empty_state_widget.dart';
import 'package:readmore/readmore.dart';
import 'package:universal_image_flutter/universal_image_flutter.dart';
import '../../gen/assets.gen.dart';
import '../../core/helper/image_ur_handler.dart';
import 'logic/my_clippings_cubit.dart';

class MyClippingsPage extends StatelessWidget {
  const MyClippingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyClippingsCubit, MyClippingsState>(
      builder: (context, state) {
        return Scaffold(
          appBar: CustomAppBar(
            title: l10n.myClippings,
            icon: Icons.content_copy_rounded,
          ),
          body: state.isLoading
              ? const Center(child: CircularProgressIndicator())
              : state.error != null
                  ? ErrorStateWidget(
                      error: state.error,
                      onRetry: () => context.read<MyClippingsCubit>().fetchMyBookExcerpts(),
                    )
                  : state.myBookExcerpts.isEmpty
                      ? EmptyStateWidget(
                          title: l10n.noClippings,
                          message: l10n.noClippingsSavedYet,
                          iconAsset: Assets.icBooks,
                        )
                      : ListView.builder(
                          itemCount: state.myBookExcerpts.length,
                          itemBuilder: (context, index) {
                            final excerpt = state.myBookExcerpts[index];
                            return BookExcerptWidget(excerpt: excerpt);
                          },
                        ),
        );
      },
    );
  }
}

class BookExcerptWidget extends StatelessWidget {
  final MyBookExcerpt excerpt;

  const BookExcerptWidget({
    super.key,
    required this.excerpt,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.s24, vertical: AppSpacing.s12),
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
            ]),
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.s20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: AppSpacing.s12,
            children: [
              Row(
                spacing: AppSpacing.s8,
                children: [
                  UniversalImageLoader(
                    path: buildImageUrl(excerpt.book.image) ?? excerpt.book.image,
                    option: UniversalImageLoaderOption(
                      height: context.fullHeight * 0.2,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Expanded(
                    child: Column(
                      spacing: AppSpacing.s8,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          excerpt.book.name,
                          style: context.textTheme.headlineSmall,
                          softWrap: true,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              ReadMoreText(
                excerpt.text,
                style: context.textTheme.bodyMedium
                    ?.copyWith(fontWeight: FontWeight.w400),
                trimMode: TrimMode.Line,
                trimLines: 4,
                trimCollapsedText: l10n.more,
                trimExpandedText: l10n.less,
                moreStyle: context.textTheme.bodyMedium
                    ?.copyWith(fontWeight: FontWeight.w700),
              ),
              const Divider(),
              Row(
                children: [
                  ProfileSection(
                    image: excerpt.author.avatar,
                    userName: excerpt.author.name,
                    userFamily: '',
                    date: excerpt.date ?? l10n.newLabel,
                  ),
                  const Spacer(),
                  ActionRowIcons(
                    onCommentPressed: () => MyBookExcerptCommentsRoute(
                      excerptId: excerpt.id,
                      numOfLike: excerpt.likesCount,
                      numOfComment: excerpt.commentsCount,
                      bookImage: excerpt.book.image,
                      userNameAndFamily: excerpt.author.name,
                      date: excerpt.date ?? l10n.newLabel,
                      userImage: excerpt.author.avatar,
                      userDescription: excerpt.text,
                    ).push(context),
                    onLikePressed: () {},
                    onSharePressed: () {},
                    numOfPeopleComments: excerpt.commentsCount ?? 0,
                    numOfLike: excerpt.likesCount,
                    isLiked: excerpt.isLiked,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileSection extends StatelessWidget {
  final String image;
  final String userName;
  final String userFamily;
  final String date;

  const ProfileSection({
    super.key,
    required this.image,
    required this.userName,
    required this.userFamily,
    required this.date,
  });

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
            radius: AppRadius.corner25,
            backgroundColor: context.colorScheme.background,
            child: CircleAvatar(
              radius: AppRadius.corner20,
              child: ClipOval(
                child: UniversalImageLoader(
                  path: image,
                  option: UniversalImageLoaderOption(
                    width: AppRadius.corner20 * 2,
                    height: AppRadius.corner20 * 2,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
        ),
        Column(
          spacing: AppSpacing.s4,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "$userName $userFamily",
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

class ActionRowIcons extends StatelessWidget {
  final VoidCallback onSharePressed;
  final VoidCallback onLikePressed;
  final VoidCallback onCommentPressed;
  final int numOfLike;
  final int numOfPeopleComments;
  final bool? isLiked;

  const ActionRowIcons({
    super.key,
    required this.onSharePressed,
    required this.onLikePressed,
    required this.onCommentPressed,
    required this.numOfLike,
    required this.numOfPeopleComments,
    this.isLiked,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(onPressed: onSharePressed, icon: const Icon(Icons.share)),
        IconButton(
            onPressed: onLikePressed,
            icon: Row(
              spacing: AppSpacing.s4,
              children: [
                Icon(
                  isLiked == true ? Icons.favorite : Icons.favorite_border,
                  color: isLiked == true ? Colors.red : null,
                ),
                if (numOfLike > 0)
                  Text(
                    numOfLike.toString(),
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
                const Icon(Icons.comment),
                if (numOfPeopleComments > 0)
                  Text(
                    numOfPeopleComments.toString(),
                    style: context.textTheme.labelLarge,
                  ),
              ],
            )),
      ],
    );
  }
}

class CommentWidget extends StatelessWidget {
  final String text;
  final String name;
  final String family;
  final String date;
  final bool isWhoLikeShow;
  final bool isPeopleCommentsShow;
  final VoidCallback onShareTap;
  final VoidCallback onFavoritePressed;
  final VoidCallback onPeopleCommentsPressed;

  const CommentWidget({
    super.key,
    required this.text,
    required this.name,
    required this.family,
    required this.date,
    required this.onShareTap,
    required this.isWhoLikeShow,
    required this.isPeopleCommentsShow,
    required this.onFavoritePressed,
    required this.onPeopleCommentsPressed,
  });

  @override
  Widget build(BuildContext context) {
    // this is the main container
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.s24, vertical: AppSpacing.s10),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).cardTheme.color ?? context.colorScheme.surface,
          borderRadius: BorderRadius.circular(AppRadius.corner20),
          boxShadow: [
            BoxShadow(
              color: context.colorScheme.shadow.withOpacity(0.1),
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
                textAlign: TextAlign.center,
              ),
            ),
            // this only for space
            const SizedBox(),
            // this for comment icon, heart icon, share icon, person profile and who liked the clipper(comment)
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: AppSpacing.s16),
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
                          radius: AppRadius.corner29,
                          backgroundColor: context.colorScheme.background,
                          child: CircleAvatar(
                            backgroundColor:
                                context.colorScheme.surfaceContainer,
                            radius: AppRadius.corner25,
                            child: const Icon(
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
                              Text(name, style: context.textTheme.titleSmall),
                              Text(family, style: context.textTheme.titleSmall),
                            ],
                          ),
                          Text(date, style: context.textTheme.labelMedium),
                        ],
                      )
                    ],
                  ),
                ),
                const Spacer(),
                IconButton(
                  icon: Icon(
                    Icons.share_outlined,
                    size: 20,
                    color: context.colorScheme.surfaceContainer,
                  ),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Row(
                    children: [
                      const Icon(
                        Icons.favorite,
                        size: 20,
                        color: Colors.red,
                      ),
                      Text("${fakeMembersWhoLikedClippingsList.length}",
                          style: context.textTheme.labelLarge),
                    ],
                  ),
                  onPressed: onFavoritePressed,
                ),
                IconButton(
                  icon: Row(
                    children: [
                      Icon(
                        Icons.message_outlined,
                        size: 20,
                        color: context.colorScheme.surfaceContainer,
                      ),
                      Text("${fakePeopleCommentsList.length}",
                          style: context.textTheme.labelLarge)
                    ],
                  ),
                  onPressed: onPeopleCommentsPressed,
                ),
              ],
            ),
            isWhoLikeShow
                ? Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.s12),
                        child: Divider(
                          color: context.colorScheme.surfaceContainer,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: AppSpacing.s8),
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: fakeMembersWhoLikedClippingsList.length,
                          itemBuilder: (context, index) => MembersWhoLiked(
                            membersWhoLikedClippings:
                                fakeMembersWhoLikedClippingsList[index],
                          ),
                        ),
                      ),
                    ],
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}

class MembersWhoLiked extends StatelessWidget {
  final MembersWhoLikedClippingsModel membersWhoLikedClippings;

  const MembersWhoLiked({super.key, required this.membersWhoLikedClippings});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.s12, vertical: AppSpacing.s8),
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: context.colorScheme.surface,
          borderRadius: BorderRadius.circular(AppRadius.corner10),
        ),
        width: double.infinity,
        height: AppSpacing.s32,
        child: Row(
          spacing: AppSpacing.s4,
          children: [
            Text(l10n.likedByUser,
                style: context.textTheme.labelLarge
                    ?.copyWith(fontWeight: FontWeight.w600)),
            Text(
              "${membersWhoLikedClippings.name} ${membersWhoLikedClippings.family}",
              style: context.textTheme.titleSmall
                  ?.copyWith(color: Colors.red, fontWeight: FontWeight.w400),
            ),
          ],
        ),
      ),
    );
  }
}

class PeopleComments extends StatelessWidget {
  final PeopleCommentsModel peopleCommentsModel;

  const PeopleComments({
    super.key,
    required this.peopleCommentsModel,
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
                      radius: AppRadius.corner29,
                      backgroundColor: context.colorScheme.background,
                      child: CircleAvatar(
                        backgroundColor: context.colorScheme.surfaceContainer,
                        radius: AppRadius.corner25,
                        child: const Icon(
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
                            peopleCommentsModel.name,
                            style: context.textTheme.titleSmall
                                ?.copyWith(fontWeight: FontWeight.w700),
                          ),
                          Text(
                            peopleCommentsModel.family,
                            style: context.textTheme.titleSmall
                                ?.copyWith(fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                      Text(
                        peopleCommentsModel.date,
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
                peopleCommentsModel.commentContent,
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
