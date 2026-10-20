import 'package:academic/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:academic/core/helper/ui_extention.dart';
import 'package:academic/core/router/router.dart';
import 'package:academic/data/api/product/model/product_model.dart';
import 'package:academic/data/api/user_reviews/model/user_review_model.dart';
import 'package:academic/widgets/error_state_widget.dart';
import 'package:academic/widgets/empty_state_widget.dart';
import '../../core/theme/const.dart';
import '../../gen/assets.gen.dart';
import 'logic/my_comments_main_cubit.dart';
import 'package:academic/widgets/custom_outlined_button.dart';
import 'package:academic/widgets/custom_app_bar.dart';
import 'package:universal_image_flutter/universal_image_flutter.dart';
import 'package:academic/core/helper/image_ur_handler.dart';
import 'package:academic/core/theme/theme.dart';

class MycommentsmainPage extends StatelessWidget {
  const MycommentsmainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MycommentsmainCubit, MycommentsmainState>(
      builder: (context, state) {
        return Scaffold(
          body: CustomScrollView(
            scrollDirection: Axis.vertical,
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(
                child: CustomAppBar(
                  title: l10n.myComments,
                  icon: Icons.comment_rounded,
                ),
              ),
              if (state.isLoading)
                const SliverFillRemaining(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              else if (state.isError)
                SliverFillRemaining(
                  child: ErrorStateWidget(
                    error: state.errorMessage,
                    onRetry: () => context.read<MycommentsmainCubit>().fetchUserReviews(),
                  ),
                )
              else if (state.reviews.isEmpty)
                SliverFillRemaining(
                  child: EmptyStateWidget(
                    title: l10n.noCommentSubmitted,
                    message: l10n.noCommentsForBooksYet,
                    iconAsset: Assets.icRegisterComment,
                  ),
                )
              else
                SliverList.builder(
                  itemCount: state.reviews.length,
                  itemBuilder: (context, index) {
                    final comment = state.reviews[index];
                    print('DEBUG: Comment data for item $index: ${comment.toJson()}');
                    return RegisteredCommentsWidget(
                      userReview: comment,
                    );
                  },
                ),
            ],
          ),
        );
      },
    );
  }
}

class RegisteredCommentsWidget extends StatelessWidget {
  final UserReviewModel userReview;

  const RegisteredCommentsWidget({super.key, required this.userReview});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s16, vertical: AppSpacing.s8),
      child: Container(
        decoration: BoxDecoration(
          color: context.colorScheme.surface,
          borderRadius: BorderRadius.circular(AppRadius.corner10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.s12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(AppRadius.corner6),
                child: userReview.image != null && userReview.image!.isNotEmpty
                    ? UniversalImageLoader(
                        path: buildImageUrl(userReview.image) ?? userReview.image!,
                        option: UniversalImageLoaderOption(
                          width: 60,
                          height: 80,
                          fit: BoxFit.cover,
                        ),
                      )
                    : Image.asset(
                        Assets.book.path,
                        width: 60,
                        height: 80,
                    fit: BoxFit.cover,
                  ),
                
              ),
              const SizedBox(width: AppSpacing.s12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      userReview.name ?? l10n.unknownBookName,
                      style: context.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700, fontSize: 16),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: AppSpacing.s4),
                    if ((userReview.authorNames != null && userReview.authorNames!.isNotEmpty) || userReview.publisherName != null)
                      Text(
                        '${userReview.authorNames != null && userReview.authorNames!.isNotEmpty ? userReview.authorNames!.join(', ') : ''}${((userReview.authorNames != null && userReview.authorNames!.isNotEmpty) && userReview.publisherName != null) ? ' | ' : ''}${userReview.publisherName ?? ''}',
                        style: context.textTheme.bodySmall?.copyWith(color: context.colorScheme.onSurfaceVariant),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    const SizedBox(height: AppSpacing.s8),
                    if (userReview.type != null)
                       Padding(
                         padding: const EdgeInsets.only(top: AppSpacing.s0),
                         child: Container(
                           padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s8, vertical: AppSpacing.s4),
                           decoration: BoxDecoration(
                             color: context.colorScheme.primary,
                             borderRadius: BorderRadius.circular(AppRadius.corner4),
                           ),
                           child: Row(
                             mainAxisSize: MainAxisSize.min,
                             children: [
                               Icon(Icons.volume_up, size: 16, color: context.colorScheme.onPrimary),
                               const SizedBox(width: AppSpacing.s4),
                               Text(
                                 userReview.type!,
                                 style: context.textTheme.labelSmall?.copyWith(color: context.colorScheme.onPrimary, fontWeight: FontWeight.w600),
                               ),
                             ],
                           ),
                         ),
                       ),
                    const SizedBox(height: AppSpacing.s8),
                    Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                           mainAxisSize: MainAxisSize.min,
                           children: [
                             Text(
                               userReview.rate?.toStringAsFixed(1) ?? '-',
                               style: context.textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w700),
                             ),
                             const SizedBox(width: AppSpacing.s4),
                             Icon(Icons.star, color: Colors.amber, size: 16),
                           ],
                         ),
                      ],
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
}
