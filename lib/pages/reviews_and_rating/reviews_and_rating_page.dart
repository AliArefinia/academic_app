import 'package:academic/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:academic/core/helper/ui_extention.dart';
import '../../core/theme/const.dart';
import '../../data/model/book_reviews_and_ratings.dart';
import '../../gen/assets.gen.dart';
import '../bottom_navigation/bottom_navigation.dart';
import '../../widgets/custom_app_bar.dart';
import 'logic/reviews_and_rating_cubit.dart';

class ReviewsandratingPage extends StatelessWidget {
  const ReviewsandratingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReviewsandratingCubit, ReviewsandratingState>(
      builder: (context, state) {
        final cubit = context.read<ReviewsandratingCubit>();
        return Scaffold(
          body: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            slivers: [
              SliverToBoxAdapter(
                child: CustomAppBar(
                  title: l10n.reviewsAndRatings,
                  icon: Icons.star_rate_rounded,
                  leading: IconButton(
                    onPressed: () {
                      context.pop();
                    },
                    icon: const Icon(Icons.arrow_back),
                  ),
                  centerTitle: true,
                ),
              ),
              SliverAnimatedList(
                  initialItemCount: fakeBookReviewsAndRatingsList.length,
                  itemBuilder: (context, index, animation) {
                    return SizeTransition(
                      sizeFactor: animation,
                      child: BookReviewsAndRatingsWidget(
                        bookReviewsAndRatingsModel:
                            fakeBookReviewsAndRatingsList[index],
                      ),
                    );
                  })
            ],
          ),
        );
      },
    );
  }
}

class BookReviewsAndRatingsWidget extends StatelessWidget {
  final BookReviewsAndRatingsModel bookReviewsAndRatingsModel;

  const BookReviewsAndRatingsWidget(
      {super.key, required this.bookReviewsAndRatingsModel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.s30, vertical: AppSpacing.s10),
      child: Container(
        decoration: BoxDecoration(
            color: context.colorScheme.surface,
            borderRadius:
                const BorderRadius.all(Radius.circular(AppRadius.corner10))),
        width: context.fullWidth * 0.9,
        height: context.fullHeight * 0.17,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const SizedBox(),
            Image.asset(
              fit: BoxFit.contain,
              Assets.book.path,
            ),
            // Name of the book, author, publisher, rating
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: AppSpacing.s8,
              children: [
                // Name of the book
                Text(
                  bookReviewsAndRatingsModel.bookName,
                  style: context.textTheme.labelLarge
                      ?.copyWith(fontWeight: FontWeight.w700),
                ),

                // Book's author and book's publisher
                Text(
                  "${bookReviewsAndRatingsModel.bookAuthor} | ${bookReviewsAndRatingsModel.bookPublisher}",
                  style: context.textTheme.labelSmall
                ),

                // Category of the book
                Container(
                  decoration: BoxDecoration(
                      color: context.colorScheme.primary,
                      borderRadius: BorderRadius.circular(AppRadius.corner6)),
                  width: context.fullWidth * 0.2,
                  height: context.fullHeight * 0.025,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.volume_up_outlined,
                        color: Colors.white,
                        size: 17,
                      ),
                      Text(
                        bookReviewsAndRatingsModel.category,
                        style: context.textTheme.labelSmall?.copyWith(
                            color: context.colorScheme.onPrimary,),
                      ),
                    ],
                  ),
                ),

                // rating and number of comments
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      color: context.colorScheme.secondary,
                      Icons.star,
                      size: 15,
                    ),
                    Text(
                      "${bookReviewsAndRatingsModel.rate} (${bookReviewsAndRatingsModel.numOfComments})",
                      style: context.textTheme.labelSmall

                    ),
                  ],
                )
              ],
            ),
            // Record reviews and points button
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: AppSpacing.s16, horizontal: AppSpacing.s10),
                child: SubmitButton(
                  onTap: () {},
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SubmitButton extends StatelessWidget {
  final VoidCallback onTap;

  const SubmitButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.transparent,
            borderRadius:
                const BorderRadius.all(Radius.circular(AppRadius.corner4)),
            border: Border.all(
              color: context.colorScheme.onSurface,
              width: 1,
            )),
        width: context.fullWidth * 0.20,
        height: context.fullHeight * 0.03,
        child: Center(
          child: Text(
            l10n.submitReviewAndRating,
            style: context.textTheme.labelSmall
          ),
        ),
      ),
    );
  }
}
