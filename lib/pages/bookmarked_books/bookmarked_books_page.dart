import 'package:academic/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:academic/core/helper/ui_extention.dart';
import 'package:academic/core/router/router.dart';
import 'package:academic/core/theme/const.dart';
import 'package:universal_image_flutter/universal_image_flutter.dart';
import 'package:academic/widgets/custom_app_bar.dart';
import 'package:academic/widgets/empty_state_widget.dart';
import '../../core/helper/image_ur_handler.dart';
import '../../generated/assets.dart';
import '../../data/api/home/model/book_model.dart';
import 'logic/bookmarked_books_cubit.dart';

class BookmarkedBooksPage extends StatelessWidget {
  const BookmarkedBooksPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookmarkedBooksCubit, BookmarkedBooksState>(
      builder: (context, state) {
        return Scaffold(
          appBar: CustomAppBar(
            title: l10n.bookmarked,
            icon: Icons.bookmark_rounded,
          ),
          body: state.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (msg) => Center(child: Text(l10n.errorWithMessage(msg.toString()))),
            empty: () => EmptyStateWidget(
              title: l10n.noBookmarkedBooks,
              message: l10n.noBookmarkedBooksYet,
              iconAsset: Assets.assetsIcSave,
            ),
            success: (books) {
              return RefreshIndicator(
                onRefresh: () => context.read<BookmarkedBooksCubit>().refresh(),
                child: GridView.builder(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(AppSpacing.s20),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 0.55,
                  ),
                  itemCount: books.length,
                  itemBuilder: (context, index) {
                    final book = books[index];

                    if (book.id == null) {
                      return const SizedBox.shrink();
                    }

                    return GestureDetector(
                      onTap: () {
                        ProductRoute(book).push(context);
                      },
                      child: BookCard(
                        bookImagePath: buildImageUrl(book.image) ?? '',
                        bookTitle: book.name ?? l10n.untitled,
                      ),
                    );
                  },
                ),
              );
            },
          ),
        );
      },
    );
  }
}

class BookCard extends StatelessWidget {
  final String bookImagePath;
  final String bookTitle;

  const BookCard({
    super.key,
    required this.bookImagePath,
    required this.bookTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.s12),
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color ?? context.colorScheme.surface,
        borderRadius: BorderRadius.circular(AppRadius.corner12),
        boxShadow: [
          BoxShadow(
            color: context.colorScheme.shadow.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 5,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(AppRadius.corner12),
              child: bookImagePath.isNotEmpty
                  ? UniversalImageLoader(
                      path: bookImagePath,
                      option: UniversalImageLoaderOption(
                        fit: BoxFit.cover,
                      ),
                    )
                  : Center(
                      child: Icon(
                        Icons.image_not_supported,
                        size: 50,
                        color: context.colorScheme.shadow,
                      ),
                    ),
            ),
          ),
          const SizedBox(height: AppSpacing.s10),
          Expanded(
            flex: 2,
            child: Center(
              child: Text(
                bookTitle,
                style: context.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: context.colorScheme.onSurface,
                  fontSize: 13,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
