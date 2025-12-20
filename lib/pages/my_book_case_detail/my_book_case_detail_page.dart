// 📁 lib/ui/book_case_detail/book_case_detail_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:get_it/get_it.dart';

import '../../core/theme/const.dart';
import '../../core/helper/ui_extention.dart';
import 'book_case_detail_cubit.dart';
import '../../data/repo/book_case_repository.dart';
import '../../data/api/home/model/book_model.dart';
import '../../core/router/router.dart';
import '../../core/helper/image_ur_handler.dart';
import 'package:universal_image_flutter/universal_image_flutter.dart';

class BookCaseDetailPage extends StatelessWidget {
  final int caseId;
  final String caseName;

  const BookCaseDetailPage({
    super.key,
    required this.caseId,
    required this.caseName,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BookCaseDetailCubit(GetIt.I<BookCaseRepository>())
        ..fetchBookCase(caseId),
      child: Scaffold(
        appBar: AppBar(
          title: Text(caseName),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => context.pop(),
          ),
        ),
        body: BlocBuilder<BookCaseDetailCubit, BookCaseDetailState>(
          builder: (context, state) {
            return state.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (msg) => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.error_outline, size: 64, color: Colors.red[300]),
                    const SizedBox(height: 16),
                    Text(
                      "خطا در بارگذاری قفسه",
                      style: context.textTheme.titleMedium?.copyWith(
                        color: Colors.red[700],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      msg,
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: Colors.grey[600],
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        context
                            .read<BookCaseDetailCubit>()
                            .fetchBookCase(caseId);
                      },
                      child: const Text('تلاش مجدد'),
                    ),
                  ],
                ),
              ),
              success: (bookCase) {
                final books = bookCase.data.books;

                if (books.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.book_outlined,
                          size: 64,
                          color: Colors.grey[400],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          "این قفسه خالی است",
                          style: context.textTheme.titleMedium?.copyWith(
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "کتاب‌های مورد علاقه خود را به این قفسه اضافه کنید",
                          style: context.textTheme.bodyMedium?.copyWith(
                            color: Colors.grey[500],
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                }

                return Padding(
                  padding: const EdgeInsets.all(AppSpacing.s20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header with book count
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "کتاب‌های قفسه",
                            style: context.textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color:
                                  context.colorScheme.primary.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              "${books.length} کتاب",
                              style: context.textTheme.bodyMedium?.copyWith(
                                color: context.colorScheme.primary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),

                      // Books grid
                      Expanded(
                        child: GridView.builder(
                          itemCount: books.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: AppSpacing.s20,
                            crossAxisSpacing: AppSpacing.s20,
                            childAspectRatio: 0.75,
                          ),
                          itemBuilder: (context, index) {
                            final book = books[index];

                            // Calculate progress
                            final double progress = ((book.type == "audio"
                                            ? book.progressTime
                                            : book.lastPageRead) ??
                                        0)
                                    .toDouble() /
                                100.0;

                            return GestureDetector(
                              onTap: () {
                                // Navigate to product page
                                final bookModel = BookModel(
                                  id: book.id.toString(),
                                  name: book.name,
                                  image: book.image,
                                  type: book.type,
                                );
                                ProductRoute(bookModel).push(context);
                              },
                              child: BookCard(
                                book: book,
                                progress: progress.clamp(0.0, 1.0),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class BookCard extends StatelessWidget {
  final dynamic book; // MyBookItem from API
  final double progress;

  const BookCard({
    super.key,
    required this.book,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: BorderRadius.circular(AppRadius.corner16),
        border: Border.all(
          color: context.colorScheme.outline.withOpacity(0.2),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: context.colorScheme.shadow.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Book cover image
          Expanded(
            flex: 3,
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(AppRadius.corner16),
              ),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: context.colorScheme.surfaceVariant,
                ),
                child: UniversalImageLoader(
                  path: buildImageUrl(book.image) ?? '',
                  option: UniversalImageLoaderOption(
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),

          // Book information
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.s12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Book title
                  Flexible(
                    child: Text(
                      book.name ?? 'بدون عنوان',
                      style: context.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),

                  const SizedBox(height: 4),

                  // Book type indicator
                  Row(
                    children: [
                      Icon(
                        book.type == 'audio' ? Icons.headphones : Icons.book,
                        size: 14,
                        color: context.colorScheme.primary,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        book.type == 'audio' ? 'صوتی' : 'متنی',
                        style: context.textTheme.bodySmall?.copyWith(
                          color: context.colorScheme.primary,
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 8),

                  // Progress indicator
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'پیشرفت',
                            style: context.textTheme.bodySmall?.copyWith(
                              fontSize: 10,
                              color: context.colorScheme.onSurface
                                  .withOpacity(0.7),
                            ),
                          ),
                          Text(
                            '${(progress * 100).toInt()}%',
                            style: context.textTheme.bodySmall?.copyWith(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: context.colorScheme.primary,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: LinearProgressIndicator(
                          value: progress,
                          backgroundColor:
                              context.colorScheme.outline.withOpacity(0.3),
                          valueColor: AlwaysStoppedAnimation<Color>(
                            context.colorScheme.primary,
                          ),
                          minHeight: 4,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
