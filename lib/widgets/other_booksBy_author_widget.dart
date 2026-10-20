import 'package:academic/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:academic/core/helper/image_ur_handler.dart';
import 'package:academic/core/helper/ui_extention.dart';
import 'package:academic/core/utils/price_parser.dart';
import 'package:academic/core/theme/const.dart';
import 'package:academic/core/router/router.dart';
import 'package:universal_image_flutter/universal_image_flutter.dart';
import '../data/api/home/model/book_model.dart';

class OtherBooksByAuthorWidget extends StatelessWidget {
  final BookModel bookModel;
  final VoidCallback? onTap;

  const OtherBooksByAuthorWidget({super.key, required this.bookModel, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.s8),
      child: SizedBox(
        width: context.fullWidth * 0.42,
        height: context.fullHeight * 0.42,
        child: GestureDetector(
          onTap: onTap ?? () => ProductRoute(bookModel).push(context),
          child: Stack(
            children: [
              Positioned(
                bottom: 0,
                top: context.fullHeight * 0.03,
                left: 0,
                right: 0,
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardTheme.color ?? Theme.of(context).colorScheme.surface,
                    boxShadow: [
                      BoxShadow(
                        color: Theme.of(context).colorScheme.shadow.withOpacity(0.1),
                        blurRadius: 30,
                        offset: const Offset(0, 10),
                      )
                    ],
                    borderRadius: BorderRadius.circular(AppRadius.corner16),
                  ),
                ),
              ),
              _buildBookCard(context),
              _buildBookContent(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBookCard(BuildContext context) {
    return Positioned(
      bottom: 12,
      top: 0,
      left: 4,
      right: 4,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          _buildRatingSection(context),
          _buildPriceSection(context),
        ],
      ),
    );
  }

  Widget _buildRatingSection(BuildContext context) {

    
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.s10),
      child: Row(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Icon(
                Icons.star,
                color: context.colorScheme.secondary,
                size: 20,
              ),
              Icon(
                Icons.star,
                color: context.colorScheme.primary,
                size: 15,
              ),
            ],
          ),
          // Text("$bookModel. ", style: context.textTheme.labelSmall),
          // Text(score, style: context.textTheme.labelSmall),
        ],
      ),
    );
  }

  Widget _buildPriceSection(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: AppSpacing.s8,vertical: AppSpacing.s4),
      decoration: const BoxDecoration(color: Colors.transparent), 
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (bookModel.discountPrice != null && bookModel.discountPrice! > 0 && bookModel.discountPrice! < (bookModel.price ?? 0)) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  bookModel.discountPrice.toString(),
                  style: context.textTheme.labelMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ).addHorizontalSpacing(4),
                Container(
                  decoration: BoxDecoration(
                    color: context.colorScheme.primary,
                    borderRadius: BorderRadius.circular(AppRadius.corner5),
                    shape: BoxShape.rectangle,
                  ),
                  height: context.fullHeight * 0.02,
                  width: context.fullWidth * 0.08,
                  child: Center(
                    child: Text(
                      "%${(((bookModel.price ?? 0) - (bookModel.discountPrice ?? 0)) / (bookModel.price ?? 1) * 100).round()}",
                      style: context.textTheme.labelSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ] else ...[
            SizedBox(height: context.fullHeight * 0.02),
          ],
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: PriceParser.formatPrice(bookModel.price),
                  style: context.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                TextSpan(
                  text: l10n.tomanWithSpace,
                  style: context.textTheme.labelSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 8,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBookContent(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.topCenter,
          child: UniversalImageLoader(
            path: buildImageUrl(bookModel.image) ?? '',
            option: UniversalImageLoaderOption(
              fit: BoxFit.contain,
              height: context.fullHeight * 0.15,
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.s8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s12),
          child: Text(
            bookModel.name?? '',
            style: context.textTheme.titleSmall,maxLines: 2,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        if (bookModel.author?.name != null && bookModel.author!.name.isNotEmpty)
          Text(
            bookModel.author!.name,
            maxLines: 1,
            style: context.textTheme.bodySmall,
            overflow: TextOverflow.ellipsis,
          ),
      ],
    );
  }
}
