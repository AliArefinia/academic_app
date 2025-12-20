import 'package:academic/data/api/product/model/product_model.dart';
import 'package:academic/core/utils/price_parser.dart';

/// Extensions for ProductModel to handle price display and validation
extension ProductModelExtensions on ProductModel {
  /// Gets formatted price for display
  String get formattedPrice {
    return PriceParser.formatPrice(price);
  }
  
  /// Gets formatted discount price for display
  String get formattedDiscountPrice {
    return PriceParser.formatPrice(discountPrice);
  }
  
  /// Checks if product has a valid price
  bool get hasValidPrice {
    return PriceParser.isValidPrice(price);
  }
  
  /// Checks if product has a valid discount price
  bool get hasValidDiscountPrice {
    return PriceParser.isValidPrice(discountPrice);
  }
  
  /// Gets the final price (discount price if available, otherwise regular price)
  double? get finalPrice {
    if (hasValidDiscountPrice) {
      return discountPrice;
    }
    return price;
  }
  
  /// Gets formatted final price for display
  String get formattedFinalPrice {
    return PriceParser.formatPrice(finalPrice);
  }
  
  /// Checks if product is on discount
  bool get isOnDiscount {
    return hasValidDiscountPrice && 
           hasValidPrice && 
           discountPrice! < price!;
  }
  
  /// Gets discount percentage
  int get discountPercentage {
    if (!isOnDiscount) return 0;
    
    final originalPrice = price!;
    final discountPriceValue = discountPrice!;
    
    return ((1 - (discountPriceValue / originalPrice)) * 100).round();
  }
}
