import '../../gen/assets.gen.dart';

class BookTourModel {
  String bookName;
  String bookAuthor;
  String? bookPublisher;
  String bookSubject;
  String bookClassification;
  String bookImage;
  String description;
  String userName;
  String userFamily;
  String userImage;
  String date;
  int numOfPeopleComments;
  int numOfLike;

  BookTourModel({
    required this.bookName,
    required this.bookAuthor,
    this.bookPublisher,
    required this.bookSubject,
    required this.bookClassification,
    required this.bookImage,
    required this.description,
    required this.userName,
    required this.userFamily,
    required this.userImage,
    required this.date,
    required this.numOfPeopleComments,
    required this.numOfLike,
  });
}

List<BookTourModel> fakeBookTourList = [
  BookTourModel(
      bookName: 'اثر مرکب',
      bookAuthor: 'دارن هاردی',
      bookPublisher: 'آیین محمود',
      bookSubject: 'موفقیت',
      bookClassification: 'انگیزش و موفقیت',
      bookImage: Assets.pcAsarmorakab.path,
      description: 'این کتاب به اصول ساده ولی قدرتمند برای رسیدن به موفقیت و تغییرات مثبت در زندگی می‌پردازد. دارن هاردی توضیح می‌دهد که چطور عادت‌های کوچک و قدم‌های به‌ظاهر بی‌اهمیت، وقتی به‌طور مداوم و روزانه انجام شوند، نتایج شگفت‌انگیزی به بار می‌آورند. اثر مرکب به ما یادآوری می‌کند',
      userName: 'سارا',
      userFamily: 'یوسفی',
      userImage: Assets.pcPerson9.path,
      date: '10 آبان 1403',
      numOfPeopleComments: 0,
      numOfLike: 0),
  BookTourModel(
      bookName: 'با هرکسی چگونه صحبت کنیم',
      bookAuthor: 'لیل نوندز',
      bookSubject: 'مهارت های اجتماعی',
      bookClassification: 'روان شناسی',
      bookImage: Assets.pcGreenBook.path,
      description: 'این کتاب برای کسانی که می‌خواهند در مکالماتشان ماهرتر و مؤثرتر شوند، راهنمایی ارزشمند است. نویسنده با روش‌های ساده و کاربردی، از تکنیک‌های برقراری ارتباط و شروع مکالمه گرفته تا حفظ توجه مخاطب و ایجاد حس راحتی، راهکارهای مفیدی ارائه می‌دهد.',
      userName: 'نگین',
      userFamily: 'خلیلی',
      userImage: Assets.pcPerson.path,
      date: '29 آذر 1403',
      numOfPeopleComments: 2,
      numOfLike: 3),
];
