// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'router.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
      $playerRoute,
      $cartRoute,
      $paymentSuccessRoute,
      $studyTourRequestRoute,
      $studyTourListRoute,
      $studyTourDetailRoute,
      $tagBooksRoute,
      $authorBooksRoute,
      $publisherBooksRoute,
      $passwordRoute,
      $verificationRoute,
      $bookpublisherRoute,
      $mycommentsmainRoute,
      $authorbookRoute,
      $homepageRoute,
      $giftcardRoute,
      $bookidRoute,
      $gifttoothersRoute,
      $mycommentsRoute,
      $productRoute,
      $booktourRoute,
      $selectprogramlanguageRoute,
      $mypurchasesRoute,
      $invitefriendsRoute,
      $personaldevelopmentbooksRoute,
      $shareviewRoute,
      $replytobookclippingRoute,
      $paymenthistoryRoute,
      $bookcategoriesRoute,
      $subCategoriesRoute,
      $categoryProductsRoute,
      $textbooksRoute,
      $mysubscriptionsRoute,
      $splashRoute,
      $mybooksRoute,
      $myshelvesRoute,
      $bookmarkedBooksRoute,
      $myClippingsRoute,
      $mychaptersRoute,
      $chapterDetailRoute,
      $myBookExcerptCommentsRoute,
      $walletRoute,
      $userprofileRoute,
      $profilemanagementRoute,
      $reviewsandratingRoute,
      $getStartedRoute,
      $introRoute,
      $buysubscriptionRoute,
      $loginRoute,
      $langRoute,
      $mainShellRouteData,
      $uploadproductRoute,
    ];

RouteBase get $playerRoute => GoRouteData.$route(
      path: '/player',
      factory: $PlayerRouteExtension._fromState,
    );

extension $PlayerRouteExtension on PlayerRoute {
  static PlayerRoute _fromState(GoRouterState state) => const PlayerRoute();

  String get location => GoRouteData.$location(
        '/player',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $cartRoute => GoRouteData.$route(
      path: '/cart',
      factory: $CartRouteExtension._fromState,
    );

extension $CartRouteExtension on CartRoute {
  static CartRoute _fromState(GoRouterState state) => const CartRoute();

  String get location => GoRouteData.$location(
        '/cart',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $paymentSuccessRoute => GoRouteData.$route(
      path: '/paymentSuccess',
      factory: $PaymentSuccessRouteExtension._fromState,
    );

extension $PaymentSuccessRouteExtension on PaymentSuccessRoute {
  static PaymentSuccessRoute _fromState(GoRouterState state) =>
      const PaymentSuccessRoute();

  String get location => GoRouteData.$location(
        '/paymentSuccess',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $studyTourRequestRoute => GoRouteData.$route(
      path: '/study-tour-request',
      factory: $StudyTourRequestRouteExtension._fromState,
    );

extension $StudyTourRequestRouteExtension on StudyTourRequestRoute {
  static StudyTourRequestRoute _fromState(GoRouterState state) =>
      const StudyTourRequestRoute();

  String get location => GoRouteData.$location(
        '/study-tour-request',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $studyTourListRoute => GoRouteData.$route(
      path: '/study-tour-list',
      factory: $StudyTourListRouteExtension._fromState,
    );

extension $StudyTourListRouteExtension on StudyTourListRoute {
  static StudyTourListRoute _fromState(GoRouterState state) =>
      const StudyTourListRoute();

  String get location => GoRouteData.$location(
        '/study-tour-list',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $studyTourDetailRoute => GoRouteData.$route(
      path: '/study-tour-detail/:studyTourId',
      factory: $StudyTourDetailRouteExtension._fromState,
    );

extension $StudyTourDetailRouteExtension on StudyTourDetailRoute {
  static StudyTourDetailRoute _fromState(GoRouterState state) =>
      StudyTourDetailRoute(
        studyTourId: state.pathParameters['studyTourId']!,
      );

  String get location => GoRouteData.$location(
        '/study-tour-detail/${Uri.encodeComponent(studyTourId)}',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $tagBooksRoute => GoRouteData.$route(
      path: '/tag-books/:tagId/:tagName',
      factory: $TagBooksRouteExtension._fromState,
    );

extension $TagBooksRouteExtension on TagBooksRoute {
  static TagBooksRoute _fromState(GoRouterState state) => TagBooksRoute(
        tagId: state.pathParameters['tagId']!,
        tagName: state.pathParameters['tagName']!,
      );

  String get location => GoRouteData.$location(
        '/tag-books/${Uri.encodeComponent(tagId)}/${Uri.encodeComponent(tagName)}',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $authorBooksRoute => GoRouteData.$route(
      path: '/author-books/:authorId',
      factory: $AuthorBooksRouteExtension._fromState,
    );

extension $AuthorBooksRouteExtension on AuthorBooksRoute {
  static AuthorBooksRoute _fromState(GoRouterState state) => AuthorBooksRoute(
        authorId: state.pathParameters['authorId']!,
        authorName: state.uri.queryParameters['author-name'],
      );

  String get location => GoRouteData.$location(
        '/author-books/${Uri.encodeComponent(authorId)}',
        queryParams: {
          if (authorName != null) 'author-name': authorName,
        },
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $publisherBooksRoute => GoRouteData.$route(
      path: '/publisher-books/:publisherId',
      factory: $PublisherBooksRouteExtension._fromState,
    );

extension $PublisherBooksRouteExtension on PublisherBooksRoute {
  static PublisherBooksRoute _fromState(GoRouterState state) =>
      PublisherBooksRoute(
        publisherId: state.pathParameters['publisherId']!,
        publisherName: state.uri.queryParameters['publisher-name'],
      );

  String get location => GoRouteData.$location(
        '/publisher-books/${Uri.encodeComponent(publisherId)}',
        queryParams: {
          if (publisherName != null) 'publisher-name': publisherName,
        },
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $passwordRoute => GoRouteData.$route(
      path: '/password',
      factory: $PasswordRouteExtension._fromState,
    );

extension $PasswordRouteExtension on PasswordRoute {
  static PasswordRoute _fromState(GoRouterState state) => PasswordRoute(
        state.uri.queryParameters['phone']!,
        _$convertMapValue(
            'is-invited', state.uri.queryParameters, _$boolConverter),
      );

  String get location => GoRouteData.$location(
        '/password',
        queryParams: {
          'phone': phone,
          if (isInvited != null) 'is-invited': isInvited!.toString(),
        },
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

T? _$convertMapValue<T>(
  String key,
  Map<String, String> map,
  T Function(String) converter,
) {
  final value = map[key];
  return value == null ? null : converter(value);
}

bool _$boolConverter(String value) {
  switch (value) {
    case 'true':
      return true;
    case 'false':
      return false;
    default:
      throw UnsupportedError('Cannot convert "$value" into a bool.');
  }
}

RouteBase get $verificationRoute => GoRouteData.$route(
      path: '/verification',
      factory: $VerificationRouteExtension._fromState,
    );

extension $VerificationRouteExtension on VerificationRoute {
  static VerificationRoute _fromState(GoRouterState state) => VerificationRoute(
        state.uri.queryParameters['phone']!,
        _$convertMapValue(
            'is-invited', state.uri.queryParameters, _$boolConverter),
        _$convertMapValue(
            'has-password', state.uri.queryParameters, _$boolConverter),
        _$boolConverter(state.uri.queryParameters['new-user']!),
      );

  String get location => GoRouteData.$location(
        '/verification',
        queryParams: {
          'phone': phone,
          if (isInvited != null) 'is-invited': isInvited!.toString(),
          if (hasPassword != null) 'has-password': hasPassword!.toString(),
          'new-user': newUser.toString(),
        },
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $bookpublisherRoute => GoRouteData.$route(
      path: '/bookPublisher',
      factory: $BookpublisherRouteExtension._fromState,
    );

extension $BookpublisherRouteExtension on BookpublisherRoute {
  static BookpublisherRoute _fromState(GoRouterState state) =>
      const BookpublisherRoute();

  String get location => GoRouteData.$location(
        '/bookPublisher',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $mycommentsmainRoute => GoRouteData.$route(
      path: '/myCommentsMain',
      factory: $MycommentsmainRouteExtension._fromState,
    );

extension $MycommentsmainRouteExtension on MycommentsmainRoute {
  static MycommentsmainRoute _fromState(GoRouterState state) =>
      const MycommentsmainRoute();

  String get location => GoRouteData.$location(
        '/myCommentsMain',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $authorbookRoute => GoRouteData.$route(
      path: '/authorBook',
      factory: $AuthorbookRouteExtension._fromState,
    );

extension $AuthorbookRouteExtension on AuthorbookRoute {
  static AuthorbookRoute _fromState(GoRouterState state) =>
      const AuthorbookRoute();

  String get location => GoRouteData.$location(
        '/authorBook',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $homepageRoute => GoRouteData.$route(
      path: '/homePage',
      factory: $HomepageRouteExtension._fromState,
    );

extension $HomepageRouteExtension on HomepageRoute {
  static HomepageRoute _fromState(GoRouterState state) => const HomepageRoute();

  String get location => GoRouteData.$location(
        '/homePage',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $giftcardRoute => GoRouteData.$route(
      path: '/giftCardRoute',
      factory: $GiftcardRouteExtension._fromState,
    );

extension $GiftcardRouteExtension on GiftcardRoute {
  static GiftcardRoute _fromState(GoRouterState state) => const GiftcardRoute();

  String get location => GoRouteData.$location(
        '/giftCardRoute',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $bookidRoute => GoRouteData.$route(
      path: '/bookID',
      factory: $BookidRouteExtension._fromState,
    );

extension $BookidRouteExtension on BookidRoute {
  static BookidRoute _fromState(GoRouterState state) => BookidRoute(
        id: state.uri.queryParameters['id']!,
        name: state.uri.queryParameters['name'],
        image: state.uri.queryParameters['image'],
        type: state.uri.queryParameters['type'],
        publisher: state.uri.queryParameters['publisher'],
        translator: state.uri.queryParameters['translator'],
        price:
            _$convertMapValue('price', state.uri.queryParameters, double.parse),
        discountPrice: _$convertMapValue(
            'discount-price', state.uri.queryParameters, double.parse),
      );

  String get location => GoRouteData.$location(
        '/bookID',
        queryParams: {
          'id': id,
          if (name != null) 'name': name,
          if (image != null) 'image': image,
          if (type != null) 'type': type,
          if (publisher != null) 'publisher': publisher,
          if (translator != null) 'translator': translator,
          if (price != null) 'price': price!.toString(),
          if (discountPrice != null)
            'discount-price': discountPrice!.toString(),
        },
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $gifttoothersRoute => GoRouteData.$route(
      path: '/giftToOthersRoute',
      factory: $GifttoothersRouteExtension._fromState,
    );

extension $GifttoothersRouteExtension on GifttoothersRoute {
  static GifttoothersRoute _fromState(GoRouterState state) =>
      const GifttoothersRoute();

  String get location => GoRouteData.$location(
        '/giftToOthersRoute',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $mycommentsRoute => GoRouteData.$route(
      path: '/myCommentsRoute',
      factory: $MycommentsRouteExtension._fromState,
    );

extension $MycommentsRouteExtension on MycommentsRoute {
  static MycommentsRoute _fromState(GoRouterState state) => MycommentsRoute(
        bookName: state.uri.queryParameters['book-name']!,
        bookImage: state.uri.queryParameters['book-image']!,
        rate: int.parse(state.uri.queryParameters['rate']!),
        productId: int.parse(state.uri.queryParameters['product-id']!),
      );

  String get location => GoRouteData.$location(
        '/myCommentsRoute',
        queryParams: {
          'book-name': bookName,
          'book-image': bookImage,
          'rate': rate.toString(),
          'product-id': productId.toString(),
        },
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $productRoute => GoRouteData.$route(
      path: '/productRoute',
      factory: $ProductRouteExtension._fromState,
    );

extension $ProductRouteExtension on ProductRoute {
  static ProductRoute _fromState(GoRouterState state) => ProductRoute(
        state.extra as BookModel,
      );

  String get location => GoRouteData.$location(
        '/productRoute',
      );

  void go(BuildContext context) => context.go(location, extra: $extra);

  Future<T?> push<T>(BuildContext context) =>
      context.push<T>(location, extra: $extra);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location, extra: $extra);

  void replace(BuildContext context) =>
      context.replace(location, extra: $extra);
}

RouteBase get $booktourRoute => GoRouteData.$route(
      path: '/bookTour',
      factory: $BooktourRouteExtension._fromState,
    );

extension $BooktourRouteExtension on BooktourRoute {
  static BooktourRoute _fromState(GoRouterState state) => const BooktourRoute();

  String get location => GoRouteData.$location(
        '/bookTour',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $selectprogramlanguageRoute => GoRouteData.$route(
      path: '/selectProgramLanguage',
      factory: $SelectprogramlanguageRouteExtension._fromState,
    );

extension $SelectprogramlanguageRouteExtension on SelectprogramlanguageRoute {
  static SelectprogramlanguageRoute _fromState(GoRouterState state) =>
      const SelectprogramlanguageRoute();

  String get location => GoRouteData.$location(
        '/selectProgramLanguage',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $mypurchasesRoute => GoRouteData.$route(
      path: '/myPurchases',
      factory: $MypurchasesRouteExtension._fromState,
    );

extension $MypurchasesRouteExtension on MypurchasesRoute {
  static MypurchasesRoute _fromState(GoRouterState state) =>
      const MypurchasesRoute();

  String get location => GoRouteData.$location(
        '/myPurchases',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $invitefriendsRoute => GoRouteData.$route(
      path: '/inviteFriends',
      factory: $InvitefriendsRouteExtension._fromState,
    );

extension $InvitefriendsRouteExtension on InvitefriendsRoute {
  static InvitefriendsRoute _fromState(GoRouterState state) =>
      const InvitefriendsRoute();

  String get location => GoRouteData.$location(
        '/inviteFriends',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $personaldevelopmentbooksRoute => GoRouteData.$route(
      path: '/personalDevelopmentBooks/:id/:title',
      factory: $PersonaldevelopmentbooksRouteExtension._fromState,
    );

extension $PersonaldevelopmentbooksRouteExtension
    on PersonaldevelopmentbooksRoute {
  static PersonaldevelopmentbooksRoute _fromState(GoRouterState state) =>
      PersonaldevelopmentbooksRoute(
        id: int.parse(state.pathParameters['id']!),
        title: state.pathParameters['title']!,
      );

  String get location => GoRouteData.$location(
        '/personalDevelopmentBooks/${Uri.encodeComponent(id.toString())}/${Uri.encodeComponent(title)}',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $shareviewRoute => GoRouteData.$route(
      path: '/shareView',
      factory: $ShareviewRouteExtension._fromState,
    );

extension $ShareviewRouteExtension on ShareviewRoute {
  static ShareviewRoute _fromState(GoRouterState state) => ShareviewRoute(
        userNameAndFamily: state.uri.queryParameters['user-name-and-family']!,
        userImage: state.uri.queryParameters['user-image']!,
        date: state.uri.queryParameters['date']!,
        opinion: state.uri.queryParameters['opinion']!,
        numOfComment: _$convertMapValue(
            'num-of-comment', state.uri.queryParameters, int.parse),
        numOfLike: _$convertMapValue(
            'num-of-like', state.uri.queryParameters, int.parse),
        todayDate: state.uri.queryParameters['today-date']!,
        personNameAndFamily:
            state.uri.queryParameters['person-name-and-family']!,
        userDescription: state.uri.queryParameters['user-description']!,
      );

  String get location => GoRouteData.$location(
        '/shareView',
        queryParams: {
          'user-name-and-family': userNameAndFamily,
          'user-image': userImage,
          'date': date,
          'opinion': opinion,
          if (numOfComment != null) 'num-of-comment': numOfComment!.toString(),
          if (numOfLike != null) 'num-of-like': numOfLike!.toString(),
          'today-date': todayDate,
          'person-name-and-family': personNameAndFamily,
          'user-description': userDescription,
        },
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $replytobookclippingRoute => GoRouteData.$route(
      path: '/replyToBookClipping',
      factory: $ReplytobookclippingRouteExtension._fromState,
    );

extension $ReplytobookclippingRouteExtension on ReplytobookclippingRoute {
  static ReplytobookclippingRoute _fromState(GoRouterState state) =>
      ReplytobookclippingRoute(
        bookImage: state.uri.queryParameters['book-image']!,
        userNameAndFamily: state.uri.queryParameters['user-name-and-family']!,
        date: state.uri.queryParameters['date']!,
        userImage: state.uri.queryParameters['user-image']!,
        numOfLike: _$convertMapValue(
            'num-of-like', state.uri.queryParameters, int.parse),
        numOfComment: _$convertMapValue(
            'num-of-comment', state.uri.queryParameters, int.parse),
        userDescription: state.uri.queryParameters['user-description']!,
      );

  String get location => GoRouteData.$location(
        '/replyToBookClipping',
        queryParams: {
          'book-image': bookImage,
          'user-name-and-family': userNameAndFamily,
          'date': date,
          'user-image': userImage,
          if (numOfLike != null) 'num-of-like': numOfLike!.toString(),
          if (numOfComment != null) 'num-of-comment': numOfComment!.toString(),
          'user-description': userDescription,
        },
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $paymenthistoryRoute => GoRouteData.$route(
      path: '/paymentHistory',
      factory: $PaymenthistoryRouteExtension._fromState,
    );

extension $PaymenthistoryRouteExtension on PaymenthistoryRoute {
  static PaymenthistoryRoute _fromState(GoRouterState state) =>
      const PaymenthistoryRoute();

  String get location => GoRouteData.$location(
        '/paymentHistory',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $bookcategoriesRoute => GoRouteData.$route(
      path: '/bookCategories',
      factory: $BookcategoriesRouteExtension._fromState,
    );

extension $BookcategoriesRouteExtension on BookcategoriesRoute {
  static BookcategoriesRoute _fromState(GoRouterState state) =>
      const BookcategoriesRoute();

  String get location => GoRouteData.$location(
        '/bookCategories',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $subCategoriesRoute => GoRouteData.$route(
      path: '/sub-categories/:categoryId',
      factory: $SubCategoriesRouteExtension._fromState,
    );

extension $SubCategoriesRouteExtension on SubCategoriesRoute {
  static SubCategoriesRoute _fromState(GoRouterState state) =>
      SubCategoriesRoute(
        categoryId: int.parse(state.pathParameters['categoryId']!),
      );

  String get location => GoRouteData.$location(
        '/sub-categories/${Uri.encodeComponent(categoryId.toString())}',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $categoryProductsRoute => GoRouteData.$route(
      path: '/category-products/:id/:title',
      factory: $CategoryProductsRouteExtension._fromState,
    );

extension $CategoryProductsRouteExtension on CategoryProductsRoute {
  static CategoryProductsRoute _fromState(GoRouterState state) =>
      CategoryProductsRoute(
        id: int.parse(state.pathParameters['id']!),
        title: state.pathParameters['title']!,
      );

  String get location => GoRouteData.$location(
        '/category-products/${Uri.encodeComponent(id.toString())}/${Uri.encodeComponent(title)}',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $textbooksRoute => GoRouteData.$route(
      path: '/textBooks',
      factory: $TextbooksRouteExtension._fromState,
    );

extension $TextbooksRouteExtension on TextbooksRoute {
  static TextbooksRoute _fromState(GoRouterState state) =>
      const TextbooksRoute();

  String get location => GoRouteData.$location(
        '/textBooks',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $mysubscriptionsRoute => GoRouteData.$route(
      path: '/mySubscriptionsRoute',
      factory: $MysubscriptionsRouteExtension._fromState,
    );

extension $MysubscriptionsRouteExtension on MysubscriptionsRoute {
  static MysubscriptionsRoute _fromState(GoRouterState state) =>
      const MysubscriptionsRoute();

  String get location => GoRouteData.$location(
        '/mySubscriptionsRoute',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $splashRoute => GoRouteData.$route(
      path: '/splash',
      factory: $SplashRouteExtension._fromState,
    );

extension $SplashRouteExtension on SplashRoute {
  static SplashRoute _fromState(GoRouterState state) => const SplashRoute();

  String get location => GoRouteData.$location(
        '/splash',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $mybooksRoute => GoRouteData.$route(
      path: '/myBooks',
      factory: $MybooksRouteExtension._fromState,
    );

extension $MybooksRouteExtension on MybooksRoute {
  static MybooksRoute _fromState(GoRouterState state) => const MybooksRoute();

  String get location => GoRouteData.$location(
        '/myBooks',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $myshelvesRoute => GoRouteData.$route(
      path: '/myShelves',
      factory: $MyshelvesRouteExtension._fromState,
      routes: [
        GoRouteData.$route(
          path: 'case/:id/:name',
          factory: $BookCaseDetailRouteExtension._fromState,
        ),
      ],
    );

extension $MyshelvesRouteExtension on MyshelvesRoute {
  static MyshelvesRoute _fromState(GoRouterState state) =>
      const MyshelvesRoute();

  String get location => GoRouteData.$location(
        '/myShelves',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $BookCaseDetailRouteExtension on BookCaseDetailRoute {
  static BookCaseDetailRoute _fromState(GoRouterState state) =>
      BookCaseDetailRoute(
        id: int.parse(state.pathParameters['id']!),
        name: state.pathParameters['name']!,
      );

  String get location => GoRouteData.$location(
        '/myShelves/case/${Uri.encodeComponent(id.toString())}/${Uri.encodeComponent(name)}',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $bookmarkedBooksRoute => GoRouteData.$route(
      path: '/bookmarkedBooks',
      factory: $BookmarkedBooksRouteExtension._fromState,
    );

extension $BookmarkedBooksRouteExtension on BookmarkedBooksRoute {
  static BookmarkedBooksRoute _fromState(GoRouterState state) =>
      const BookmarkedBooksRoute();

  String get location => GoRouteData.$location(
        '/bookmarkedBooks',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $myClippingsRoute => GoRouteData.$route(
      path: '/myClippings',
      factory: $MyClippingsRouteExtension._fromState,
    );

extension $MyClippingsRouteExtension on MyClippingsRoute {
  static MyClippingsRoute _fromState(GoRouterState state) =>
      const MyClippingsRoute();

  String get location => GoRouteData.$location(
        '/myClippings',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $mychaptersRoute => GoRouteData.$route(
      path: '/my-chapters',
      factory: $MychaptersRouteExtension._fromState,
    );

extension $MychaptersRouteExtension on MychaptersRoute {
  static MychaptersRoute _fromState(GoRouterState state) =>
      const MychaptersRoute();

  String get location => GoRouteData.$location(
        '/my-chapters',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $chapterDetailRoute => GoRouteData.$route(
      path: '/chapter-detail/:chapterId',
      factory: $ChapterDetailRouteExtension._fromState,
    );

extension $ChapterDetailRouteExtension on ChapterDetailRoute {
  static ChapterDetailRoute _fromState(GoRouterState state) =>
      ChapterDetailRoute(
        chapterId: int.parse(state.pathParameters['chapterId']!),
      );

  String get location => GoRouteData.$location(
        '/chapter-detail/${Uri.encodeComponent(chapterId.toString())}',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $myBookExcerptCommentsRoute => GoRouteData.$route(
      path: '/myBookExcerptComments',
      factory: $MyBookExcerptCommentsRouteExtension._fromState,
    );

extension $MyBookExcerptCommentsRouteExtension on MyBookExcerptCommentsRoute {
  static MyBookExcerptCommentsRoute _fromState(GoRouterState state) =>
      MyBookExcerptCommentsRoute(
        excerptId: int.parse(state.uri.queryParameters['excerpt-id']!),
        bookImage: state.uri.queryParameters['book-image']!,
        userNameAndFamily: state.uri.queryParameters['user-name-and-family']!,
        date: state.uri.queryParameters['date']!,
        userImage: state.uri.queryParameters['user-image']!,
        numOfLike: _$convertMapValue(
            'num-of-like', state.uri.queryParameters, int.parse),
        numOfComment: _$convertMapValue(
            'num-of-comment', state.uri.queryParameters, int.parse),
        userDescription: state.uri.queryParameters['user-description']!,
      );

  String get location => GoRouteData.$location(
        '/myBookExcerptComments',
        queryParams: {
          'excerpt-id': excerptId.toString(),
          'book-image': bookImage,
          'user-name-and-family': userNameAndFamily,
          'date': date,
          'user-image': userImage,
          if (numOfLike != null) 'num-of-like': numOfLike!.toString(),
          if (numOfComment != null) 'num-of-comment': numOfComment!.toString(),
          'user-description': userDescription,
        },
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $walletRoute => GoRouteData.$route(
      path: '/wallet',
      factory: $WalletRouteExtension._fromState,
    );

extension $WalletRouteExtension on WalletRoute {
  static WalletRoute _fromState(GoRouterState state) => const WalletRoute();

  String get location => GoRouteData.$location(
        '/wallet',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $userprofileRoute => GoRouteData.$route(
      path: '/userProfile',
      factory: $UserprofileRouteExtension._fromState,
    );

extension $UserprofileRouteExtension on UserprofileRoute {
  static UserprofileRoute _fromState(GoRouterState state) =>
      const UserprofileRoute();

  String get location => GoRouteData.$location(
        '/userProfile',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $profilemanagementRoute => GoRouteData.$route(
      path: '/profileManagement',
      factory: $ProfilemanagementRouteExtension._fromState,
    );

extension $ProfilemanagementRouteExtension on ProfilemanagementRoute {
  static ProfilemanagementRoute _fromState(GoRouterState state) =>
      const ProfilemanagementRoute();

  String get location => GoRouteData.$location(
        '/profileManagement',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $reviewsandratingRoute => GoRouteData.$route(
      path: '/reviewsAndRating',
      factory: $ReviewsandratingRouteExtension._fromState,
    );

extension $ReviewsandratingRouteExtension on ReviewsandratingRoute {
  static ReviewsandratingRoute _fromState(GoRouterState state) =>
      const ReviewsandratingRoute();

  String get location => GoRouteData.$location(
        '/reviewsAndRating',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $getStartedRoute => GoRouteData.$route(
      path: '/getStarted',
      factory: $GetStartedRouteExtension._fromState,
    );

extension $GetStartedRouteExtension on GetStartedRoute {
  static GetStartedRoute _fromState(GoRouterState state) =>
      const GetStartedRoute();

  String get location => GoRouteData.$location(
        '/getStarted',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $introRoute => GoRouteData.$route(
      path: '/introRoute',
      factory: $IntroRouteExtension._fromState,
    );

extension $IntroRouteExtension on IntroRoute {
  static IntroRoute _fromState(GoRouterState state) => const IntroRoute();

  String get location => GoRouteData.$location(
        '/introRoute',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $buysubscriptionRoute => GoRouteData.$route(
      path: '/buySubscriptionRoute',
      factory: $BuysubscriptionRouteExtension._fromState,
    );

extension $BuysubscriptionRouteExtension on BuysubscriptionRoute {
  static BuysubscriptionRoute _fromState(GoRouterState state) =>
      const BuysubscriptionRoute();

  String get location => GoRouteData.$location(
        '/buySubscriptionRoute',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $loginRoute => GoRouteData.$route(
      path: '/loginRoute',
      factory: $LoginRouteExtension._fromState,
    );

extension $LoginRouteExtension on LoginRoute {
  static LoginRoute _fromState(GoRouterState state) => const LoginRoute();

  String get location => GoRouteData.$location(
        '/loginRoute',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $langRoute => GoRouteData.$route(
      path: '/langRoute',
      factory: $LangRouteExtension._fromState,
    );

extension $LangRouteExtension on LangRoute {
  static LangRoute _fromState(GoRouterState state) => const LangRoute();

  String get location => GoRouteData.$location(
        '/langRoute',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $mainShellRouteData => StatefulShellRouteData.$route(
      parentNavigatorKey: MainShellRouteData.$parentNavigatorKey,
      factory: $MainShellRouteDataExtension._fromState,
      branches: [
        StatefulShellBranchData.$branch(
          routes: [
            GoRouteData.$route(
              path: '/home',
              factory: $HomeRouteDataExtension._fromState,
            ),
          ],
        ),
        StatefulShellBranchData.$branch(
          routes: [
            GoRouteData.$route(
              path: '/profile',
              factory: $ProfileRouteDataExtension._fromState,
            ),
          ],
        ),
        StatefulShellBranchData.$branch(
          routes: [
            GoRouteData.$route(
              path: '/shop',
              factory: $ShopRouteDataExtension._fromState,
            ),
          ],
        ),
        StatefulShellBranchData.$branch(
          routes: [
            GoRouteData.$route(
              path: '/category',
              factory: $CategoryRouteDataExtension._fromState,
            ),
          ],
        ),
        StatefulShellBranchData.$branch(
          routes: [
            GoRouteData.$route(
              path: '/myBook',
              factory: $MyBooksRouteDataExtension._fromState,
            ),
          ],
        ),
      ],
    );

extension $MainShellRouteDataExtension on MainShellRouteData {
  static MainShellRouteData _fromState(GoRouterState state) =>
      const MainShellRouteData();
}

extension $HomeRouteDataExtension on HomeRouteData {
  static HomeRouteData _fromState(GoRouterState state) => const HomeRouteData();

  String get location => GoRouteData.$location(
        '/home',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $ProfileRouteDataExtension on ProfileRouteData {
  static ProfileRouteData _fromState(GoRouterState state) =>
      const ProfileRouteData();

  String get location => GoRouteData.$location(
        '/profile',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $ShopRouteDataExtension on ShopRouteData {
  static ShopRouteData _fromState(GoRouterState state) => const ShopRouteData();

  String get location => GoRouteData.$location(
        '/shop',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $CategoryRouteDataExtension on CategoryRouteData {
  static CategoryRouteData _fromState(GoRouterState state) =>
      const CategoryRouteData();

  String get location => GoRouteData.$location(
        '/category',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $MyBooksRouteDataExtension on MyBooksRouteData {
  static MyBooksRouteData _fromState(GoRouterState state) =>
      const MyBooksRouteData();

  String get location => GoRouteData.$location(
        '/myBook',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $uploadproductRoute => GoRouteData.$route(
      path: '/upload-product',
      factory: $UploadproductRouteExtension._fromState,
    );

extension $UploadproductRouteExtension on UploadproductRoute {
  static UploadproductRoute _fromState(GoRouterState state) =>
      const UploadproductRoute();

  String get location => GoRouteData.$location(
        '/upload-product',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}
