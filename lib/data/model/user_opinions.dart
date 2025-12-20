class UserOpinionsModel {
  final String name;
  final String family;
  final int rate;
  final DateTime? date;
  final String opinionText;
  final int? numOfUseful;
  final int? numOfNotUseful;
  final String? userAvatar;

  UserOpinionsModel({
    required this.name,
    required this.family,
    required this.rate,
    required this.date,
    required this.opinionText,
    this.numOfUseful,
    this.numOfNotUseful,
    this.userAvatar,
  });
}

List<UserOpinionsModel> fakeUserOpinionsModelList = [
  UserOpinionsModel(
      name: 'نگین',
      family: 'خلیلی',
      rate: 2,
      date: DateTime(2023, 9, 8),
      opinionText:
          'لورم ایپسوم متن ساختگی با تولید سادگی نامفهوم از صنعت چاپ و با استفاده از طراحان گرافیک است. چاپگرها و متون بلکه روزنامه و مجله در ستون و سطرآنچنان که لازم است و برای شرایط فعلی تکنولوژی مورد نیاز و کاربردهای متنوع با هدف بهبود',
      numOfUseful: 421,
      numOfNotUseful: 16),
  UserOpinionsModel(
      name: 'نگین',
      family: 'خلیلی',
      rate: 4,
      date: DateTime(2023, 9, 8),
      opinionText:
          'لورم ایپسوم متن ساختگی با تولید سادگی نامفهوم از صنعت چاپ و با استفاده از طراحان گرافیک است. چاپگرها و متون بلکه روزنامه و مجله در ستون و سطرآنچنان که لازم است و برای شرایط فعلی تکنولوژی مورد نیاز و کاربردهای متنوع با هدف بهبود',
      numOfUseful: 421,
      numOfNotUseful: 16),
  UserOpinionsModel(
      name: 'نگین',
      family: 'خلیلی',
      rate: 5,
      date: DateTime(2023, 9, 8),
      opinionText:
          'لورم ایپسوم متن ساختگی با تولید سادگی نامفهوم از صنعت چاپ و با استفاده از طراحان گرافیک است. چاپگرها و متون بلکه روزنامه و مجله در ستون و سطرآنچنان که لازم است و برای شرایط فعلی تکنولوژی مورد نیاز و کاربردهای متنوع با هدف بهبود',
      numOfUseful: 421,
      numOfNotUseful: 16),
  UserOpinionsModel(
      name: 'نگین',
      family: 'خلیلی',
      rate: 3,
      date: DateTime(2023, 9, 8),
      opinionText:
          'لورم ایپسوم متن ساختگی با تولید سادگی نامفهوم از صنعت چاپ و با استفاده از طراحان گرافیک است. چاپگرها و متون بلکه روزنامه و مجله در ستون و سطرآنچنان که لازم است و برای شرایط فعلی تکنولوژی مورد نیاز و کاربردهای متنوع با هدف بهبود',
      numOfUseful: 421,
      numOfNotUseful: 16),
  UserOpinionsModel(
      name: 'نگین',
      family: 'خلیلی',
      rate: 1,
      date: DateTime(2023, 9, 8),
      opinionText:
          'لورم ایپسوم متن ساختگی با تولید سادگی نامفهوم از صنعت چاپ و با استفاده از طراحان گرافیک است. چاپگرها و متون بلکه روزنامه و مجله در ستون و سطرآنچنان که لازم است و برای شرایط فعلی تکنولوژی مورد نیاز و کاربردهای متنوع با هدف بهبود',
      numOfUseful: 421,
      numOfNotUseful: 16),
];
