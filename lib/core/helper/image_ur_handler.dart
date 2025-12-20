String? buildImageUrl(String? rawImage) {
  if (rawImage == null || rawImage.isEmpty) {
    return null;
  }

  String cleaned = rawImage.replaceAll('\n', '').replaceAll(' ', '').replaceAll('"', '');
  cleaned = cleaned.replaceAll('.p\nng', '.png').replaceAll('.s\nvg', '.svg');

  if (cleaned.startsWith('http')) return cleaned;
  if (cleaned.startsWith('/products/')) return 'https://demo.halalread.ir/storage$cleaned';
  if (cleaned.startsWith('products/')) return 'https://demo.halalread.ir/storage/$cleaned';
  if (cleaned.startsWith('/')) return 'https://demo.halalread.ir$cleaned';

  return 'https://demo.halalread.ir/storage/$cleaned';
}