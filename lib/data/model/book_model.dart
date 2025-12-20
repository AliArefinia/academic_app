import '../../gen/assets.gen.dart';

class FakeBookModel {
  final String bookName;
  final String author;
  final String image;
  final double rate;
  final int numOfRates;
  final int price;
  final int? discount;

  FakeBookModel(
      {required this.bookName,
      required this.author,
      required this.image,
      required this.rate,
      required this.numOfRates,
      required this.price,
      this.discount});
}

List<FakeBookModel> fake = [
  FakeBookModel(
      image: Assets.pcBook2.path,
      bookName: 'خرده عادت ها',
      author: 'زهرا صادقی',
      rate: 4.5,
      price: 100000,
      discount: 50,
      numOfRates: 50),
  FakeBookModel(
      image: Assets.pcBook2.path,
      bookName: 'خرده عادت ها',
      author: 'زهرا صادقی',
      rate: 4.5,
      price: 50000,
      discount: 0,
      numOfRates: 50),
  FakeBookModel(
      image: Assets.pcBook2.path,
      bookName: 'خرده عادت ها',
      author: 'زهرا صادقی',
      rate: 4.5,
      price: 70000,
      discount: 20,
      numOfRates: 50),
  FakeBookModel(
      image: Assets.pcBook2.path,
      bookName: 'خرده عادت ها',
      author: 'زهرا صادقی',
      rate: 4.5,
      price: 150000,
      discount: 0,
      numOfRates: 30),
  FakeBookModel(
      image: Assets.pcBook2.path,
      bookName: 'خرده عادت ها',
      author: 'زهرا صادقی',
      rate: 4.5,
      price: 150000,
      discount: 30,
      numOfRates: 30),
  FakeBookModel(
      image: Assets.pcBook2.path,
      bookName: 'خرده عادت ها',
      author: 'زهرا صادقی',
      rate: 4.5,
      price: 100000,
      discount: 50,
      numOfRates: 50),
];
