import 'package:academic/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:academic/core/helper/ui_extention.dart';
import 'package:academic/core/router/router.dart';
import 'package:academic/core/theme/const.dart';
import 'package:universal_image_flutter/universal_image_flutter.dart';
import 'package:academic/widgets/custom_app_bar.dart';
import 'package:academic/widgets/empty_state_widget.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../../core/helper/image_ur_handler.dart';
import '../../generated/assets.dart';
import '../../data/api/home/model/book_model.dart';
import 'logic/my_books_cubit.dart';

class MybooksPage extends StatelessWidget {
  const MybooksPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyBooksCubit, MyBooksState>(
      builder: (context, state) {
        return Scaffold(
          appBar: CustomAppBar(
            title: l10n.myBooks,
            icon: Icons.book_rounded,
          ),
          body: state.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (msg) => Center(child: Text(l10n.errorWithMessage(msg.toString()))),
            empty: () => EmptyStateWidget(
              title: l10n.noBookFound,
              message: l10n.noBooksInLibraryYet,
              iconAsset: Assets.assetsIcBooks,
            ),
            success: (data, selectedCategory) {
              final allBooks = data.list ?? [];

              final filteredBooks = selectedCategory == 0
                  ? allBooks
                  : allBooks
                  .where((book) {
                    final bookType = book.type?.toLowerCase() ?? '';
                    if (selectedCategory == 1) {
                      // Electronic/Text books: everything except audio
                      return bookType != 'audio';
                    } else {
                      // Audio books
                      return bookType == 'audio';
                    }
                  })
                  .toList();

              return CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s20),
                    sliver: SliverList(
                      delegate: SliverChildListDelegate([
                        const SizedBox(height: AppSpacing.s16),
                        GestureDetector(
                          onTap: () => context.push(PathRoute.myShelvesRoute),
                          child: Container(
                            height: context.fullHeight * 0.0625,
                            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s12),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(AppRadius.corner12),
                              border: Border.all(color: context.colorScheme.shadow),
                              color: context.colorScheme.surface,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    SvgPicture.asset(
                                      Assets.assetsIcShelf,
                                      width: AppSpacing.s30,
                                      height: AppSpacing.s30,
                                      colorFilter: ColorFilter.mode(
                                        context.colorScheme.onSurface, 
                                        BlendMode.srcIn
                                      ),
                                    ),
                                    const SizedBox(width: AppSpacing.s12),
                                    Text(l10n.myShelves,
                                        style: context.textTheme.titleMedium
                                            ?.copyWith(
                                              fontWeight: FontWeight.w400,
                                              color: context.colorScheme.onSurface,
                                            )),
                                  ],
                                ),
                                Icon(Icons.keyboard_arrow_left,
                                    color: context.colorScheme.secondary),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: AppSpacing.s24),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s0),
                          child: Text(l10n.appShelves,
                              style: context.textTheme.titleLarge),
                        ),
                        const SizedBox(height: AppSpacing.s16),
                        BookShelvesSection(
                          selectedCategory: selectedCategory,
                          onShelfSelected: (index) {
                            context.read<MyBooksCubit>().selectCategory(index);
                          },
                        ),
                        const SizedBox(height: AppSpacing.s30),
                      ]),
                    ),
                  ),
                  if (filteredBooks.isEmpty)
                    SliverPadding(
                      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s20),
                      sliver: SliverToBoxAdapter(
                        child: EmptyStateWidget(
                          title: l10n.noBookFound,
                          message: selectedCategory == 1
                              ? l10n.noTextBooksInLibrary
                              : selectedCategory == 2
                                  ? l10n.noAudioBooksInLibrary
                                  : l10n.noBooksFound,
                          iconAsset: Assets.assetsIcBooks,
                          compact: true,
                        ),
                      ),
                    )
                  else
                    SliverPadding(
                      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s20),
                      sliver: SliverGrid(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                          childAspectRatio: 0.55,
                        ),
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            final book = filteredBooks[index];
                            
                            // Handle null/empty progress data safely
                            final int progressValue = book.type == "audio"
                                ? (book.progressTime ?? 0)
                                : (book.lastPageRead ?? 0);
                            final double progress = (progressValue > 0 ? progressValue : 0) / 100.0;

                            // Validate book data before navigation
                            if (book.id == null) {
                              return const SizedBox.shrink();
                            }

                            return GestureDetector(
                              onTap: () {
                                final bookModel = BookModel(
                                  id: book.id.toString(),
                                  name: book.name ?? l10n.untitled,
                                  image: book.image ?? '',
                                  type: book.type ?? 'text',
                                );
                                context.push(PathRoute.productRoute, extra: bookModel);
                              },
                              child: BookProgressCard(
                                progress: progress.clamp(0.0, 1.0),
                                iconPath: Assets.assetsIcDon,
                                bookImagePath: buildImageUrl(book.image) ?? '',
                                bookTitle: book.name ?? l10n.untitled,
                              ),
                            );
                          },
                          childCount: filteredBooks.length,
                        ),
                      ),
                    ),
                  SliverPadding(
                    padding: const EdgeInsets.only(
                      left: AppSpacing.s20,
                      right: AppSpacing.s20,
                      bottom: AppSpacing.s30,
                    ),
                    sliver: SliverToBoxAdapter(
                      child: const SizedBox(height: AppSpacing.s20),
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}

class BookProgressCard extends StatelessWidget {
  final double progress;
  final String iconPath;
  final String bookImagePath;
  final String bookTitle;

  const BookProgressCard({
    super.key,
    required this.progress,
    required this.iconPath,
    required this.bookImagePath,
    required this.bookTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        left: AppSpacing.s12, 
        right: AppSpacing.s12, 
        top: AppSpacing.s12,
        bottom: AppSpacing.s12,
      ),
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
                      child: Icon(Icons.image_not_supported, size: 50, color: context.colorScheme.shadow),
                    ),
            ),
          ),
          const SizedBox(height: AppSpacing.s10),
          // Book title - Flexible to prevent overflow
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
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          if (progress > 0) ...[
            const SizedBox(height: AppSpacing.s10),
            ClipRRect(
              borderRadius: BorderRadius.circular(AppRadius.corner12),
              child: LinearProgressIndicator(
                value: progress,
                backgroundColor: context.colorScheme.shadow,
                valueColor: AlwaysStoppedAnimation<Color>(context.colorScheme.primary),
                minHeight: 6,
              ),
            ),
            const SizedBox(height: AppSpacing.s8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "${(progress * 100).toInt()}%",
                  style: context.textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.w400,
                    color: context.colorScheme.onSurface,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

class BookShelvesSection extends StatelessWidget {
  final int selectedCategory;
  final void Function(int) onShelfSelected;

  const BookShelvesSection({
    super.key,
    required this.selectedCategory,
    required this.onShelfSelected,
  });

  @override
  Widget build(BuildContext context) {
    // Map shelf index to category index:
    // 1: "الکترونیک" -> category 1 (text)
    // 2: "صوتی" -> category 2 (audio)
    final List<Map<String, dynamic>> shelves = [
      {'title': l10n.electronic, 'icon': Assets.assetsIcOpenbook, 'categoryIndex': 1},
      {'title': l10n.audio, 'icon': Assets.assetsIcHeadphones, 'categoryIndex': 2},
    ];

    return SizedBox(
      height: context.fullHeight * 0.175,
      child: CarouselSlider.builder(
        options: CarouselOptions(
          height: context.fullHeight * 0.1,
          enlargeCenterPage: false,
          viewportFraction: 0.3,
          enableInfiniteScroll: false,
          padEnds: false,
          scrollPhysics: const BouncingScrollPhysics(),
        ),
        itemCount: shelves.length,
        itemBuilder: (context, index, realIndex) {
          final shelf = shelves[index];
          final categoryIndex = shelf['categoryIndex'] as int;
          final isSelected = selectedCategory == categoryIndex;
          
          return GestureDetector(
            onTap: () {
              onShelfSelected(categoryIndex);
            },
            child: Container(
              width: context.fullWidth * 0.23,
              decoration: BoxDecoration(
                color: isSelected 
                    ? context.colorScheme.primary 
                    : context.colorScheme.surface,
                borderRadius: BorderRadius.circular(AppRadius.corner16),
                boxShadow: [
                  BoxShadow(
                    color: context.colorScheme.shadow,
                    blurRadius: 20,
                    spreadRadius: -4,
                    offset: const Offset(0, 10),
                  ),
                  BoxShadow(
                    color: context.colorScheme.shadow,
                    blurRadius: 8,
                    spreadRadius: -1,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: AppSpacing.s26,
                    width: AppSpacing.s26,
                    child: SvgPicture.asset(
                      shelf['icon'],
                      fit: BoxFit.contain,
                      colorFilter: isSelected
                          ? ColorFilter.mode(
                              context.colorScheme.onPrimary,
                              BlendMode.srcIn,
                            )
                          : null,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.s10),
                  Text(
                    shelf['title'],
                    textAlign: TextAlign.center,
                    style: context.textTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: isSelected
                          ? context.colorScheme.onPrimary
                          : context.colorScheme.onSurface,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}