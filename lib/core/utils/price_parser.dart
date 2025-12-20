/// Centralized price parsing utility to handle inconsistent backend data types
/// Backend sometimes sends price as int, sometimes as string with commas
class PriceParser {
  /// Safely parses any price value to double
  /// Handles: int, double, string with commas, null
  static double? parseToDouble(dynamic value) {
    if (value == null) return null;
    
    if (value is double) return value;
    if (value is int) return value.toDouble();
    
    if (value is String) {
      // Remove all non-numeric characters except decimal point
      final cleanValue = value
          .replaceAll(',', '') // Remove commas
          .replaceAll(' ', '') // Remove spaces
          .replaceAll(RegExp(r'[^\d.]'), ''); // Remove everything except digits and decimal point
      
      if (cleanValue.isEmpty) return null;
      
      return double.tryParse(cleanValue);
    }
    
    return null;
  }
  
  /// Safely parses any price value to int
  /// Handles: int, double, string with commas, null
  static int parseToInt(dynamic value) {
    if (value == null) return 0;
    
    if (value is int) return value;
    if (value is double) return value.toInt();
    
    if (value is String) {
      // Remove all non-numeric characters except decimal point
      final cleanValue = value
          .replaceAll(',', '') // Remove commas
          .replaceAll(' ', '') // Remove spaces
          .replaceAll(RegExp(r'[^\d.]'), ''); // Remove everything except digits and decimal point
      
      if (cleanValue.isEmpty) return 0;
      
      // Parse as double first, then convert to int
      final doubleValue = double.tryParse(cleanValue);
      return doubleValue?.toInt() ?? 0;
    }
    
    return 0;
  }
  
  /// Formats price for display with proper Persian number formatting
  static String formatPrice(double? price) {
    if (price == null) return '0';
    
    // Convert to int to remove decimal places
    final intPrice = price.toInt();
    
    // Add commas for thousands separator
    final formatted = intPrice.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]},',
    );
    
    return formatted;
  }
  
  /// Checks if a price value is valid (not null and greater than 0)
  static bool isValidPrice(dynamic value) {
    final parsed = parseToDouble(value);
    return parsed != null && parsed > 0;
  }
  
  /// Gets price as string for API calls
  static String getPriceAsString(dynamic value) {
    final parsed = parseToDouble(value);
    return parsed?.toString() ?? '0';
  }
}
