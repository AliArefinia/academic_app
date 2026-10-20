import 'package:flutter/material.dart';
import 'package:academic/l10n/l10n.dart';
import 'package:academic/core/utils/price_parser.dart';
import 'package:academic/core/helper/ui_extention.dart';

/// A reusable widget for displaying prices with proper formatting
class PriceDisplayWidget extends StatelessWidget {
  final dynamic price;
  final dynamic discountPrice;
  final TextStyle? priceStyle;
  final TextStyle? discountStyle;
  final TextStyle? originalPriceStyle;
  final bool showCurrency;
  /// Defaults to the localized currency name (Toman).
  final String? currency;
  final CrossAxisAlignment alignment;

  const PriceDisplayWidget({
    super.key,
    required this.price,
    this.discountPrice,
    this.priceStyle,
    this.discountStyle,
    this.originalPriceStyle,
    this.showCurrency = false,
    this.currency,
    this.alignment = CrossAxisAlignment.start,
  });

  @override
  Widget build(BuildContext context) {
    final double? parsedPrice = PriceParser.parseToDouble(price);
    final double? parsedDiscountPrice = PriceParser.parseToDouble(discountPrice);
    
    if (parsedPrice == null || parsedPrice <= 0) {
      return const SizedBox.shrink();
    }

    final bool hasDiscount = parsedDiscountPrice != null && 
                           parsedDiscountPrice > 0 && 
                           parsedDiscountPrice < parsedPrice;

    return Column(
      crossAxisAlignment: alignment,
      children: [
        if (hasDiscount) ...[
          // Show original price with strikethrough
          Text(
            '${PriceParser.formatPrice(parsedPrice)}${showCurrency ? ' ${currency ?? l10n.toman}' : ''}',
            style: (originalPriceStyle ?? context.textTheme.bodyMedium)?.copyWith(
              decoration: TextDecoration.lineThrough,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 4),
          // Show discount price
          Text(
            '${PriceParser.formatPrice(parsedDiscountPrice)}${showCurrency ? ' ${currency ?? l10n.toman}' : ''}',
            style: discountStyle ?? context.textTheme.titleMedium?.copyWith(
              color: Colors.red,
              fontWeight: FontWeight.bold,
            ),
          ),
        ] else ...[
          // Show regular price
          Text(
            '${PriceParser.formatPrice(parsedPrice)}${showCurrency ? ' ${currency ?? l10n.toman}' : ''}',
            style: priceStyle ?? context.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ],
    );
  }
}

/// A simple price text widget
class PriceTextWidget extends StatelessWidget {
  final dynamic price;
  final TextStyle? style;
  final bool showCurrency;
  /// Defaults to the localized currency name (Toman).
  final String? currency;

  const PriceTextWidget({
    super.key,
    required this.price,
    this.style,
    this.showCurrency = false,
    this.currency,
  });

  @override
  Widget build(BuildContext context) {
    final double? parsedPrice = PriceParser.parseToDouble(price);
    
    if (parsedPrice == null || parsedPrice <= 0) {
      return const SizedBox.shrink();
    }

    return Text(
      '${PriceParser.formatPrice(parsedPrice)}${showCurrency ? ' ${currency ?? l10n.toman}' : ''}',
      style: style ?? context.textTheme.bodyMedium,
    );
  }
}
