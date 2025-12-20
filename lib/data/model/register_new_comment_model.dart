import '../../gen/assets.gen.dart';

class RegisterNewCommentModel {
  String bookName;
  String bookImage;

  RegisterNewCommentModel({
    required this.bookName,
    required this.bookImage,
  });
}

List<RegisterNewCommentModel> fakeRegisterNewCommentList = [
  RegisterNewCommentModel(
      bookName: 'خرده عادت ها', bookImage: Assets.book.path),
  RegisterNewCommentModel(
      bookName: 'خرده عادت ها', bookImage: Assets.book.path),
  RegisterNewCommentModel(
      bookName: 'اثر مرکب', bookImage: Assets.pcAsarmorakab.path),
];
