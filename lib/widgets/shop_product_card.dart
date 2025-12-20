import 'package:flutter/material.dart';
import 'package:academic/core/helper/image_ur_handler.dart';
import 'package:academic/core/helper/ui_extention.dart';
import 'package:academic/core/utils/price_parser.dart';
import 'package:academic/core/theme/const.dart';
import 'package:academic/core/router/router.dart';
import 'package:academic/data/api/product/model/product_model.dart';
import 'package:universal_image_flutter/universal_image_flutter.dart';

class ShopProductCard extends StatelessWidget {
  final ProductModel product;
  final VoidCallback? onTap;

  const ShopProductCard({
    super.key,
    required this.product,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final hasDiscount = product.discountPrice != null &&
        product.discountPrice! > 0 &&
        product.discountPrice! < (product.price ?? 0);
    final discountPercent = hasDiscount
        ? (((product.price ?? 0) - (product.discountPrice ?? 0)) /
                (product.price ?? 1) *
                100)
            .round()
        : null;

    return GestureDetector(
      onTap: onTap ?? () => ProductRoute(product).push(context),
      child: Container(
        decoration: BoxDecoration(
          color: context.colorScheme.surface,
          borderRadius: BorderRadius.circular(AppRadius.corner20),
          boxShadow: [
            BoxShadow(
              color: context.colorScheme.shadow.withOpacity(0.08),
              blurRadius: 20,
              spreadRadius: 0,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Image Section with Discount Badge
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(AppRadius.corner20),
                    topRight: Radius.circular(AppRadius.corner20),
                  ),
                  child: Container(
                    height: 160,
                    width: double.infinity,
                    color: context.colorScheme.surfaceVariant,
                    child: product.image != null && product.image!.isNotEmpty
                        ? UniversalImageLoader(
                            path: buildImageUrl(product.image) ?? '',
                            option: UniversalImageLoaderOption(
                              width: double.infinity,
                              height: 160,
                              fit: BoxFit.cover,
                              fadeInDuration: const Duration(milliseconds: 300),
                            ),
                          )
                        : Icon(
                            Icons.image_not_supported,
                            size: 50,
                            color: context.colorScheme.onSurfaceVariant,
                          ),
                  ),
                ),
                // Discount Badge
                if (hasDiscount && discountPercent != null)
                  Positioned(
                    top: 12,
                    right: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.s8,
                        vertical: AppSpacing.s4,
                      ),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            context.colorScheme.primary,
                            context.colorScheme.primary.withOpacity(0.8),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(AppRadius.corner20),
                        boxShadow: [
                          BoxShadow(
                            color: context.colorScheme.primary.withOpacity(0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.local_offer,
                            size: 14,
                            color: context.colorScheme.onPrimary,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '$discountPercent%',
                            style: context.textTheme.labelSmall?.copyWith(
                              color: context.colorScheme.onPrimary,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                // Comment Count Badge
                if (product.commentCount != null && product.commentCount! > 0)
                  Positioned(
                    top: 12,
                    left: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.s8,
                        vertical: AppSpacing.s4,
                      ),
                      decoration: BoxDecoration(
                        color: context.colorScheme.surface.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(AppRadius.corner20),
                        boxShadow: [
                          BoxShadow(
                            color: context.colorScheme.shadow.withOpacity(0.1),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.comment_outlined,
                            size: 14,
                            color: context.colorScheme.onSurface,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${product.commentCount}',
                            style: context.textTheme.labelSmall?.copyWith(
                              fontWeight: FontWeight.w600,
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
            // Content Section
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.s10,
                  vertical: AppSpacing.s8,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Product Type Badge
                    if (product.type != null)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.s6,
                          vertical: AppSpacing.s2,
                        ),
                        decoration: BoxDecoration(
                          color: context.colorScheme.primaryContainer,
                          borderRadius: BorderRadius.circular(AppRadius.corner8),
                        ),
                        child: Text(
                          product.type!,
                          style: context.textTheme.labelSmall?.copyWith(
                            color: context.colorScheme.onPrimaryContainer,
                            fontWeight: FontWeight.w600,
                            fontSize: 9,
                          ),
                        ),
                      ),
                    if (product.type != null) const SizedBox(height: AppSpacing.s4),
                    // Product Name
                    Flexible(
                      child: Text(
                        product.name ?? '',
                        style: context.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          height: 1.2,
                          fontSize: 13,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.s4),
                    // Price Section
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (hasDiscount) ...[
                                Text(
                                  PriceParser.formatPrice(product.price),
                                  style: context.textTheme.bodySmall?.copyWith(
                                    decoration: TextDecoration.lineThrough,
                                    color: context.colorScheme.onSurface
                                        .withOpacity(0.5),
                                    fontSize: 9,
                                  ),
                                ),
                                const SizedBox(height: 1),
                              ],
                              Text(
                                PriceParser.formatPrice(
                                    product.discountPrice ?? product.price),
                                style: context.textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                  height: 1.2,
                                  color: hasDiscount
                                      ? context.colorScheme.primary
                                      : context.colorScheme.onSurface,
                                ),
                              ),
                              Text(
                                'تومان',
                                style: context.textTheme.labelSmall?.copyWith(
                                  color: context.colorScheme.onSurface
                                      .withOpacity(0.6),
                                  fontSize: 8,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Add to Cart Icon
                        Container(
                          decoration: BoxDecoration(
                            color: context.colorScheme.primaryContainer,
                            shape: BoxShape.circle,
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: onTap ?? () => ProductRoute(product).push(context),
                              borderRadius: BorderRadius.circular(30),
                              child: Padding(
                                padding: const EdgeInsets.all(AppSpacing.s6),
                                child: Icon(
                                  Icons.add_shopping_cart_rounded,
                                  size: 16,
                                  color: context.colorScheme.onPrimaryContainer,
                                ),
                              ),
                            ),
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
      ),
    );
  }
}

