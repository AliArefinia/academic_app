import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:academic/core/helper/ui_extention.dart';
import 'package:academic/core/router/router.dart';
import 'package:academic/core/theme/const.dart';
import 'package:academic/data/model/book_excerpt.dart';
import 'package:academic/gen/assets.gen.dart';
import 'package:academic/widgets/error_state_widget.dart';
import 'package:academic/widgets/empty_state_widget.dart';
import 'package:readmore/readmore.dart';
import 'package:universal_image_flutter/universal_image_flutter.dart';
import '../../core/helper/image_ur_handler.dart';
import 'logic/book_tour_cubit.dart';
import 'package:share_plus/share_plus.dart';

class BooktourPage extends StatefulWidget {
  const BooktourPage({super.key});

  @override
  State<BooktourPage> createState() => _BooktourPageState();
}

class _BooktourPageState extends State<BooktourPage> {
  // Helper function to create share text from BookExcerpt
  String _createShareTextForExcerpt(BookExcerpt excerpt) {
    final buffer = StringBuffer();

    // Add book title
    buffer.writeln('📚 ${excerpt.book.name ?? ''}');

    // Add excerpt text
    if (excerpt.text?.isNotEmpty ?? false) {
      String cleanContent = excerpt.text!
          .replaceAll(RegExp(r'<[^>]*>'), '')
          .replaceAll('&laquo;', '"')
          .replaceAll('&raquo;', '"')
          .replaceAll('&quot;', '"')
          .replaceAll('&amp;', '&')
          .replaceAll('&lt;', '<')
          .replaceAll('&gt;', '>')
          .replaceAll('&nbsp;', ' ')
          .trim();

      // Use the full clean content
      buffer.writeln('\n📝 $cleanContent');
    }

    // Add marketing message and link
    buffer.writeln(
        '\n📱 برای مطالعه این کتاب و هزاران کتاب دیگر، اپلیکیشن حلال بوکس را نصب کنید:');
    // Using app deep link instead of website link
    buffer.writeln('academic://excerpt?id=${excerpt.id ?? ''}');

    return buffer.toString();
  }

  // Helper function to perform the sharing action
  void _shareExcerpt(
      BuildContext context, BookExcerpt excerpt, String shareText) async {
    try {
      await Share.share(
        shareText,
        subject: 'بریده‌ای از کتاب ${excerpt.book.name ?? ''}',
      );
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('خطا در اشتراک‌گذاری: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  // Method to show the share dialog
  void _showShareDialogForExcerpt(BuildContext context, BookExcerpt excerpt) {
    final shareText = _createShareTextForExcerpt(excerpt);

    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: Container(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.9,
            maxHeight: MediaQuery.of(context).size.height * 0.8,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Icon(Icons.share, color: context.colorScheme.primary),
                    const SizedBox(width: 8),
                    Text('اشتراک‌گذاری بریده',
                        style: context.textTheme.titleLarge),
                  ],
                ),
              ),
              Flexible(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        shareText,
                        style: context.textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text('انصراف'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.pop(context);
                          _shareExcerpt(context, excerpt, shareText);
                        },
                        style: ButtonStyle(
                            padding: WidgetStatePropertyAll(
                                EdgeInsets.symmetric(horizontal: 12))),
                        icon: Icon(Icons.share),
                        label: Text('اشتراک‌گذاری'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BooktourCubit, BooktourState>(
      builder: (context, state) {
        final List<String> chipLabels = [
          'همه',
          'محبوبترین ها',
          '#موفقیت',
          '#روانشناسی'
        ];
        final cubit = context.read<BooktourCubit>();
        return Scaffold(
          body: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              const SliverAppBar(
                title: Text('کتاب گردی'),
              ),
              // SliverToBoxAdapter(
              //   child: Padding(
              //     padding: const EdgeInsets.symmetric(vertical: AppSpacing.s26),
              //     child: SingleChildScrollView(
              //       scrollDirection: Axis.horizontal,
              //       physics: const BouncingScrollPhysics(),
              //       child: Row(
              //         children: chipLabels
              //             .map((chip) => BuildChip(
              //                   label: chip,
              //                   isSelected: state.currentChip == chip,
              //                   onTap: () => cubit.onChipTap(chip),
              //                 ))
              //             .toList(),
              //       ),
              //     ),
              //   ),
              // ),
              if (state.isLoading)
                const SliverFillRemaining(
                  child: Center(child: CircularProgressIndicator()),
                )
              else if (state.error != null)
                SliverFillRemaining(
                  child: ErrorStateWidget(
                    error: state.error,
                    onRetry: () => cubit.fetchBookExcerpts(),
                  ),
                )
              else if (state.bookExcerpts.isEmpty)
                SliverFillRemaining(
                  child: EmptyStateWidget(
                    title: 'بریده‌ای وجود ندارد',
                    message: 'در حال حاضر بریده‌ای برای نمایش وجود ندارد',
                    iconAsset: Assets.icBooks,
                  ),
                )
              else
                SliverList.builder(
                  itemCount: state.bookExcerpts.length,
                  itemBuilder: (context, index) {
                    final excerpt = state.bookExcerpts[index];
                    return BookTourWidget(
                      bookExcerpt: excerpt,
                      onSharePressed: () =>
                          _showShareDialogForExcerpt(context, excerpt),
                      onLikePressed: () => cubit.toggleLike(excerpt.id),
                      onCommentPressed: () => ReplytobookclippingRoute(
                        numOfLike: excerpt.likesCount,
                        numOfComment: excerpt.commentsCount,
                        bookImage: excerpt.book.image,
                        userNameAndFamily: excerpt.author.name,
                        date: excerpt.date ?? 'تازه',
                        userImage: excerpt.author.avatar,
                        userDescription: excerpt.text,
                      ).push(context),
                    );
                  },
                )
            ],
          ),
        );
      },
    );
  }
}

class BuildChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const BuildChip({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    final textStyle = context.textTheme.bodyLarge;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadius.corner10),
        child: Container(
          decoration: BoxDecoration(
            color: isSelected ? colorScheme.primary : colorScheme.surface,
            borderRadius: BorderRadius.circular(AppRadius.corner10),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.s26,
            vertical: AppSpacing.s6,
          ),
          child: Text(
            label,
            style: textStyle?.copyWith(
              color: isSelected ? colorScheme.onPrimary : colorScheme.onSurface,
            ),
          ),
        ),
      ),
    );
  }
}

class BookTourWidget extends StatelessWidget {
  final BookExcerpt bookExcerpt;
  final VoidCallback onSharePressed;
  final VoidCallback onLikePressed;
  final VoidCallback onCommentPressed;

  const BookTourWidget({
    super.key,
    required this.bookExcerpt,
    required this.onSharePressed,
    required this.onLikePressed,
    required this.onCommentPressed,
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
                    path: buildImageUrl(bookExcerpt.book.image) ?? bookExcerpt.book.image,
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
                          "کتاب ${bookExcerpt.book.name}",
                          style: context.textTheme.headlineSmall,
                          softWrap: true,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              ReadMoreText(
                bookExcerpt.text,
                style: context.textTheme.bodyMedium
                    ?.copyWith(fontWeight: FontWeight.w400),
                trimMode: TrimMode.Line,
                trimLines: 4,
                trimCollapsedText: 'بیشتر',
                trimExpandedText: 'کمتر',
                moreStyle: context.textTheme.bodyMedium
                    ?.copyWith(fontWeight: FontWeight.w700),
              ),
              const Divider(),
              Row(
                children: [
                  ProfileSection(
                    image: bookExcerpt.author.avatar,
                    userName: bookExcerpt.author.name,
                    userFamily: '',
                    date: bookExcerpt.date ?? 'تازه',
                  ),
                  const Spacer(),
                  ActionRowIcons(
                    onCommentPressed: onCommentPressed,
                    onLikePressed: onLikePressed,
                    onSharePressed: onSharePressed,
                    numOfLike: bookExcerpt.likesCount,
                    numOfPeopleComments: bookExcerpt.commentsCount,
                    isLiked: bookExcerpt.isLiked,
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
                  path: buildImageUrl(image) ?? image,
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
  final int? numOfLike;
  final int? numOfPeopleComments;
  final bool? isLiked;

  const ActionRowIcons({
    super.key,
    required this.onSharePressed,
    required this.onLikePressed,
    required this.onCommentPressed,
    this.numOfLike,
    this.numOfPeopleComments,
    this.isLiked,
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
