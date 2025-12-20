class AdvertisementModel {
  final List<String> images;
  final String title;
  final String price;
  final double rating;
  final double lat;
  final double long;

  AdvertisementModel(
      {required this.images,
      required this.title,
      required this.price,
      required this.rating,
      required this.lat,
      required this.long});
}

List<AdvertisementModel> homeData = [
  AdvertisementModel(
    images: [
      'https://rvb-img.reverb.com/image/upload/s--VijDtJ7q--/f_auto,t_large/v1582055645/hd3vticqngdaqgurcnmn.jpg'
    ],
    title: 'پاور میکسر دایناکورد مدل PowerMate 600',
    price: '۱,۰۰۰,۰۰۰ تومان',
    rating: 4.7,
    lat: 35.6892,
    long: 51.3890,
  ),
  AdvertisementModel(
    images: [
      'https://www.tehranmelody.com/image/cache/catalog/files/product/PA/speaker/FBT/Active/Evo2maxx-4A/Evomaxx4-2-800x800.jpg'
    ],
    title: 'باند اکتیو FBT مدل Evo2MaxX 4A',
    price: '۸۰۰,۰۰۰ تومان',
    rating: 4.5,
    lat: 35.6892,
    long: 51.3890,
  ),
  AdvertisementModel(
    images: [
      'https://melodyertebat.ir/wp-content/uploads/2022/04/Powermixer-Dynacord-PM600.3-04.jpg'
    ],
    title: 'باند پسیو الکترو وویس مدل ZX5',
    price: '۹۰۰,۰۰۰ تومان',
    rating: 4.6,
    lat: 35.6892,
    long: 51.3890,
  ),
  AdvertisementModel(
    images: [
      'https://melodyertebat.ir/wp-content/uploads/2022/04/Powermixer-Dynacord-PM600.3-04.jpg'
    ],
    title: 'میکروفون بی‌سیم سنهایزر مدل EW 100 G4-835-S',
    price: '۷۰۰,۰۰۰ تومان',
    rating: 4.8,
    lat: 35.6892,
    long: 51.3890,
  ),
  AdvertisementModel(
    images: [
      'https://melodyertebat.ir/wp-content/uploads/2022/04/Powermixer-Dynacord-PM600.3-04.jpg'
    ],
    title: 'رکوردر صدا زوم مدل H6',
    price: '۵۰۰,۰۰۰ تومان',
    rating: 4.7,
    lat: 35.6892,
    long: 51.3890,
  ),
];
