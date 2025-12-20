import 'package:flutter/material.dart';
import 'package:academic/core/helper/ui_extention.dart';
import 'package:academic/core/theme/const.dart';
import 'package:academic/core/router/router.dart';
import 'package:academic/core/utils/price_parser.dart';
import 'package:universal_image_flutter/universal_image_flutter.dart';
import 'package:academic/core/helper/image_ur_handler.dart';
import '../data/api/home/model/book_model.dart';

import '../generated/assets.dart';

class BookDiscountCard extends StatelessWidget {
  final String title;
  final String? author;
  final double rating;
  final int reviewCount;
  final String oldPrice;
  final String discount;
  final String newPrice;
  final bool showDiscount;
  final String? imageUrl;
  final BookModel? bookModel;

  const BookDiscountCard({
    super.key,
    required this.title,
    this.author,
    required this.rating,
    required this.reviewCount,
    required this.oldPrice,
    required this.discount,
    required this.newPrice,
    this.showDiscount = true,
    this.imageUrl,
    this.bookModel,
  });

  factory BookDiscountCard.fromBookModel(BookModel book) {
    final hasDiscount = book.discountPrice != null &&
        book.discountPrice! > 0 &&
        book.discountPrice! < (book.price ?? 0);

    return BookDiscountCard(
      title: book.name ?? '',
      author: book.author?.name,
      rating: 0.0, // اگر داری مقدارش رو بگذار
      reviewCount: 0, // اگر داری مقدارش رو بگذار
      oldPrice: PriceParser.formatPrice(book.price),
      discount: hasDiscount
          ? '%${(((book.price ?? 0) - (book.discountPrice ?? 0)) / (book.price ?? 1) * 100).round()}'
          : '-',
      newPrice: hasDiscount
          ? PriceParser.formatPrice(book.discountPrice)
          : PriceParser.formatPrice(book.price),
      showDiscount: hasDiscount,
      imageUrl: book.image,
      bookModel: book,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: AppSpacing.s12),
      child: GestureDetector(
        onTap: bookModel != null ? () => ProductRoute(bookModel!).push(context) : null,
        child: Container(
          padding: const EdgeInsets.all(AppRadius.corner16),
          decoration: BoxDecoration(
            color: Theme.of(context).cardTheme.color ?? context.colorScheme.surface,
            borderRadius: BorderRadius.circular(AppRadius.corner12),
            boxShadow: [
              BoxShadow(
                color: context.colorScheme.shadow.withOpacity(0.15),
                blurRadius: 8,
                spreadRadius: 1,
              ),
            ],
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(AppRadius.corner8),
                child: imageUrl != null && imageUrl!.isNotEmpty
                    ? UniversalImageLoader(
                        path: buildImageUrl(imageUrl) ?? imageUrl!,
                        option: UniversalImageLoaderOption(
                          width: 60,
                          height: 90,
                          fit: BoxFit.cover,
                        ),
                      )
                    : Image.asset(
                        Assets.assetsPcBook8,
                        width: 60,
                        height: 90,
                        fit: BoxFit.cover,
                      ),
              ),
              const SizedBox(width: AppSpacing.s12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: context.textTheme.headlineSmall,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (author != null && author!.isNotEmpty)
                      Text(
                        author!,
                        style: context.textTheme.labelMedium,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    const SizedBox(height: AppSpacing.s8),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.only(top: AppSpacing.s20),
                            child: Row(
                              children: [
                                Icon(Icons.star,
                                    color: context.colorScheme.primary, size: 20),
                                const SizedBox(width: AppSpacing.s4),
                                Flexible(
                                  child: Text('$rating ($reviewCount)',
                                      style: context.textTheme.labelSmall,
                                      overflow: TextOverflow.ellipsis),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                            if (showDiscount)
                              Row(
                                children: [
                                  Flexible(
                                    child: Text(
                                      oldPrice,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: Color(0xFFCACACA),
                                        fontWeight: FontWeight.w700,
                                        decoration: TextDecoration.lineThrough,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  const SizedBox(width: AppSpacing.s4),
                                  Flexible(
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: AppSpacing.s8,
                                          vertical: AppSpacing.s4),
                                      decoration: BoxDecoration(
                                        color: context.colorScheme.primary,
                                        borderRadius: BorderRadius.circular(
                                            AppRadius.corner8),
                                      ),
                                      child: Text(
                                        discount,
                                        style: context.textTheme.bodySmall
                                            ?.copyWith(fontWeight: FontWeight.w700),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            else
                              const SizedBox(height: AppSpacing.s24),
                            const SizedBox(height: AppSpacing.s4),
                            Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                      text: newPrice,
                                      style: context.textTheme.headlineMedium),
                                  TextSpan(
                                      text: " تومان",
                                      style: context.textTheme.labelSmall
                                          ?.copyWith(
                                          fontWeight: FontWeight.w600)),
                                ],
                              ),
                            ),
                          ],
                        ),
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
