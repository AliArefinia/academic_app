class StudyTourDetailModel {
  final String id;
  final String title;
  final String description;
  final String categoryName;
  final String estimatedDuration;
  final List<StudyTourBookModel> books;

  StudyTourDetailModel({
    required this.id,
    required this.title,
    required this.description,
    required this.categoryName,
    required this.estimatedDuration,
    required this.books,
  });
}

class StudyTourBookModel {
  final String id;
  final String title;
  final String image;
  final String? author;
  final String? translator;
  final String? publisher;
  final String? audioTime;
  final String? content;
  final int? price;
  final int? discountPrice;
  final double? peopleRates;
  final int? numOfPeopleRates;
  final String? menuOfContents;
  final String? bookId;
  final String? type;
  final List<dynamic>? authors;
  final String? speaker;
  final List<dynamic>? categories;
  final List<dynamic>? excerpts;
  final List<dynamic>? comments;
  final int? commentCount;
  final List<dynamic>? authorBooks;
  final List<dynamic>? publisherBooks;
  final String? epub;
  final String? sampleEpub;
  final String? sampleAudio;
  final String? time;
  final double? avgRate;
  final int? fileSize;
  final bool? isPurchased;
  final int? publishYear;
  final List<dynamic>? headlines;

  StudyTourBookModel({
    required this.id,
    required this.title,
    required this.image,
    this.author,
    this.translator,
    this.publisher,
    this.audioTime,
    this.content,
    this.price,
    this.discountPrice,
    this.peopleRates,
    this.numOfPeopleRates,
    this.menuOfContents,
    this.bookId,
    this.type,
    this.authors,
    this.speaker,
    this.categories,
    this.excerpts,
    this.comments,
    this.commentCount,
    this.authorBooks,
    this.publisherBooks,
    this.epub,
    this.sampleEpub,
    this.sampleAudio,
    this.time,
    this.avgRate,
    this.fileSize,
    this.isPurchased,
    this.publishYear,
    this.headlines,
  });
}
