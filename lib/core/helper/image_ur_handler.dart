import 'package:academic/core/api_constants.dart';

String? buildImageUrl(String? rawImage) {
  if (rawImage == null || rawImage.isEmpty) {
    return null;
  }

  String cleaned = rawImage.replaceAll('\n', '').replaceAll(' ', '').replaceAll('"', '');
  cleaned = cleaned.replaceAll('.p\nng', '.png').replaceAll('.s\nvg', '.svg');

  const baseUrl = ApiConstants.baseUrl;
  if (cleaned.startsWith('http')) return cleaned;
  if (cleaned.startsWith('/products/')) return '$baseUrl/storage$cleaned';
  if (cleaned.startsWith('products/')) return '$baseUrl/storage/$cleaned';
  if (cleaned.startsWith('/')) return '$baseUrl$cleaned';

  return '$baseUrl/storage/$cleaned';
}
