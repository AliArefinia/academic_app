enum AppMimeType {
  image,
  video,
  audio,
  application,
  model,
  font,
  other;

  factory AppMimeType.fromStringType(String type) {
    switch (type.toLowerCase()) {
      case 'image':
        return AppMimeType.image;
      case 'video':
        return AppMimeType.video;
      case 'audio':
        return AppMimeType.audio;
      case 'application':
        return AppMimeType.application;
      case 'model':
        return AppMimeType.model;
      case 'font':
        return AppMimeType.font;
      default:
        return AppMimeType.other;
    }
  }
}
