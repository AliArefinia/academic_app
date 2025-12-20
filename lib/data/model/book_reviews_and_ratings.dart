import '../../gen/assets.gen.dart';

class BookReviewsAndRatingsModel {
  String image;
  String bookName;
  String bookAuthor;
  String bookPublisher;
  String category;
  double rate;
  int numOfComments;

  BookReviewsAndRatingsModel({
    required this.image,
    required this.bookName,
    required this.bookAuthor,
    required this.bookPublisher,
    required this.category,
    required this.rate,
    required this.numOfComments,
  });
}

List<BookReviewsAndRatingsModel> fakeBookReviewsAndRatingsList = [
  BookReviewsAndRatingsModel(
      image: Assets.book.path,
      bookName: 'کتاب خرده عادت ها',
      bookAuthor: 'جیمز کلییر',
      bookPublisher: 'انتشارات ملیکان',
      rate: 3.5,
      numOfComments: 14,
      category: 'کتاب صوتی'),
  BookReviewsAndRatingsModel(
      image: Assets.book.path,
      bookName: 'کتاب خرده عادت ها',
      bookAuthor: 'جیمز کلییر',
      bookPublisher: 'انتشارات ملیکان',
      rate: 3.5,
      numOfComments: 14,
      category: 'کتاب صوتی'),
  BookReviewsAndRatingsModel(
      image: Assets.book.path,
      bookName: 'کتاب خرده عادت ها',
      bookAuthor: 'جیمز کلییر',
      bookPublisher: 'انتشارات ملیکان',
      rate: 3.5,
      numOfComments: 14,
      category: 'کتاب صوتی'),
  BookReviewsAndRatingsModel(
      image: Assets.book.path,
      bookName: 'کتاب خرده عادت ها',
      bookAuthor: 'جیمز کلییر',
      bookPublisher: 'انتشارات ملیکان',
      rate: 3.5,
      numOfComments: 14,
      category: 'کتاب صوتی'),
  BookReviewsAndRatingsModel(
      image: Assets.book.path,
      bookName: 'کتاب خرده عادت ها',
      bookAuthor: 'جیمز کلییر',
      bookPublisher: 'انتشارات ملیکان',
      rate: 3.5,
      numOfComments: 14,
      category: 'کتاب صوتی'),
  BookReviewsAndRatingsModel(
      image: Assets.book.path,
      bookName: 'کتاب خرده عادت ها',
      bookAuthor: 'جیمز کلییر',
      bookPublisher: 'انتشارات ملیکان',
      rate: 3.5,
      numOfComments: 14,
      category: 'کتاب صوتی'),
];
