import 'package:academic/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:get_it/get_it.dart';
import 'package:academic/core/injection/get_it_instance.dart';
import 'package:academic/data/repo/auth_repo.dart';
import 'package:academic/data/repo/home_repository.dart';
import 'package:academic/data/repo/my_book_excerpts_repository.dart';
import 'package:academic/data/repo/my_books_repository.dart';
import 'package:academic/data/repo/my_purchases_repository.dart';
import 'package:academic/data/repo/user_reviews_repository.dart';
import 'package:academic/data/repository/likes_repository.dart';
import 'package:academic/data/repository/subscription_repository.dart';
import 'package:academic/pages/author_book/author_book_page.dart';
import 'package:academic/pages/author_book/logic/author_book_cubit.dart';
import 'package:academic/pages/book_categories/book_categories_page.dart';
import 'package:academic/pages/book_categories/logic/book_categories_cubit.dart';
import 'package:academic/pages/book_categories/logic/sub_categories_cubit.dart';
import 'package:academic/pages/book_categories/sub_categories_page.dart';
import 'package:academic/pages/book_i_d/book_i_d_page.dart';
import 'package:academic/pages/book_i_d/logic/book_i_d_cubit.dart';
import 'package:academic/pages/book_publisher/book_publisher_page.dart';
import 'package:academic/pages/book_publisher/logic/book_publisher_cubit.dart';
import 'package:academic/pages/book_tour/book_tour_page.dart';
import 'package:academic/pages/book_tour/logic/book_tour_cubit.dart';
import 'package:academic/pages/cart/cart_page.dart';
import 'package:academic/pages/cart/logic/cart_cubit.dart';
import 'package:academic/pages/get_started/logic/get_started_cubit.dart';
import 'package:academic/pages/gift_to_others/gift_to_others_page.dart';
import 'package:academic/pages/gift_to_others/logic/gift_to_others_cubit.dart';
import 'package:academic/pages/home_page/home_page_page.dart';
import 'package:academic/pages/home_page/logic/home_page_cubit.dart';
import 'package:academic/pages/shop/shop_page.dart';
import 'package:academic/pages/shop/logic/shop_cubit.dart';
import 'package:academic/pages/invite_friends/invite_friends_page.dart';
import 'package:academic/pages/invite_friends/logic/invite_friends_cubit.dart';
import 'package:academic/pages/my_book_excerpt_comments/logic/my_book_excerpt_comments_cubit.dart';
import 'package:academic/pages/my_book_excerpt_comments/my_book_excerpt_comments_page.dart';
import 'package:academic/pages/my_books/logic/my_books_cubit.dart';
import 'package:academic/pages/my_books/my_books_page.dart';
import 'package:academic/pages/my_clippings/logic/my_clippings_cubit.dart';
import 'package:academic/pages/my_clippings/my_clippings_page.dart';
import 'package:academic/pages/my_chapters/my_chapters_page.dart';
import 'package:academic/pages/my_chapters/logic/my_chapters_cubit.dart';
import 'package:academic/pages/chapter_detail/chapter_detail_page.dart';
import 'package:academic/pages/chapter_detail/logic/chapter_detail_cubit.dart';
import 'package:academic/pages/my_comments/logic/my_comments_cubit.dart';
import 'package:academic/pages/my_comments/my_comments_page.dart';
import 'package:academic/pages/my_comments_main/logic/my_comments_main_cubit.dart';
import 'package:academic/pages/my_comments_main/my_comments_main_page.dart';
import 'package:academic/pages/my_purchases/logic/my_purchases_cubit.dart';
import 'package:academic/pages/my_purchases/my_purchases_page.dart';
import 'package:academic/pages/my_shelves/logic/my_shelves_cubit.dart';
import 'package:academic/pages/my_shelves/my_shelves_page.dart';
import 'package:academic/pages/bookmarked_books/logic/bookmarked_books_cubit.dart';
import 'package:academic/pages/bookmarked_books/bookmarked_books_page.dart';
import 'package:academic/data/repository/bookmarks_repository.dart';
import 'package:academic/pages/payment_history/logic/payment_history_cubit.dart';
import 'package:academic/pages/payment_history/payment_history_page.dart';
import 'package:academic/pages/personal_development_books/logic/personal_development_books_cubit.dart';
import 'package:academic/pages/category_products/category_products_page.dart';
import 'package:academic/pages/tag_books/tag_books_page.dart';
import 'package:academic/pages/tag_books/logic/tag_books_cubit.dart';
import 'package:academic/pages/product/logic/product_cubit.dart';
import 'package:academic/pages/product/product_page.dart';
import 'package:academic/pages/reply_to_book_clipping/logic/reply_to_book_clipping_cubit.dart';
import 'package:academic/pages/reply_to_book_clipping/reply_to_book_clipping_page.dart';
import 'package:academic/pages/reviews_and_rating/logic/reviews_and_rating_cubit.dart';
import 'package:academic/pages/share_view/logic/share_view_cubit.dart';
import 'package:academic/pages/share_view/share_view_page.dart';
import 'package:academic/pages/text_books/logic/text_books_cubit.dart';
import 'package:academic/pages/text_books/text_books_page.dart';
import 'package:academic/pages/user_profile/logic/user_profile_cubit.dart';
import 'package:academic/pages/user_profile/user_profile_page.dart';
import 'package:academic/pages/wallet/logic/wallet_cubit.dart';
import 'package:academic/pages/wallet/wallet_page.dart';
import 'package:academic/core/storage/local_storage.dart';
import 'package:academic/pages/player/player_page.dart';
import 'package:academic/core/player/global_player.dart';
import 'package:academic/pages/payment/payment_success_page.dart';

import '../../data/api/home/model/book_model.dart';
import '../../data/repo/book_case_repository.dart';
import '../../pages/auth/login/logic/login_cubit.dart';
import '../../pages/auth/login/login_page.dart';
import '../../pages/auth/password/logic/password_cubit.dart';
import '../../pages/auth/password/password_page.dart';
import '../../pages/auth/verification/logic/verification_cubit.dart';
import '../../pages/auth/verification/verification_page.dart';
import '../../pages/bottom_navigation/app_shell_route_screen.dart';
import '../../pages/buy_subscription/buy_subscription_page.dart';
import '../../pages/buy_subscription/logic/buy_subscription_cubit.dart';
import '../../pages/get_started/get_started_page.dart';
import '../../pages/gift_card/gift_card_page.dart';
import '../../pages/gift_card/logic/gift_card_cubit.dart';
import '../../pages/intro/intro_page.dart';
import '../../pages/my_book_case_detail/book_case_detail_cubit.dart';
import '../../pages/my_book_case_detail/my_book_case_detail_page.dart';
import '../../pages/my_subscriptions/logic/my_subscriptions_cubit.dart';
import '../../pages/my_subscriptions/my_subscriptions_page.dart';
import '../../pages/profile_management/logic/profile_management_cubit.dart';
import '../../pages/profile_management/profile_management_page.dart';
import '../../pages/reviews_and_rating/reviews_and_rating_page.dart';
import '../../pages/settings/settings_page.dart';
import '../../pages/splash/logic/splash_cubit.dart';
import '../../pages/splash/splash_page.dart';
import '../../pages/study_tour_request/study_tour_request_page.dart';
import '../../pages/study_tour_request/logic/study_tour_request_cubit.dart';
import '../../pages/study_tour_list/study_tour_list_page.dart';
import '../../pages/study_tour_list/logic/study_tour_list_cubit.dart';
import '../../pages/study_tour_detail/study_tour_detail_page.dart';
import '../../pages/study_tour_detail/logic/study_tour_detail_cubit.dart';

import '../../data/repository/categories_repository.dart';
import '../../data/repository/payment_history_repository.dart';
import 'package:academic/data/repo/profile_repository.dart';
import 'package:academic/data/repo/shop_repository.dart';
import 'package:academic/data/api/product/model/product_model.dart';
import 'package:academic/data/repo/book_excerpts_repository.dart';
import '../../pages/upload_product/upload_product_page.dart';
import '../../pages/upload_product/logic/upload_product_cubit.dart';
import '../../data/repository/product_request_repository.dart';

part 'router.g.dart';

part 'pages/password.p.dart';

part 'pages/verification.p.dart';

part 'pages/book_publisher.p.dart';

part 'pages/my_comments_main.p.dart';

part 'pages/author_book.p.dart';

part 'pages/home_page.p.dart';

part 'pages/gift_card.p.dart';

part 'pages/book_i_d.p.dart';

part 'pages/gift_to_others.p.dart';

part 'pages/my_comments.p.dart';

part 'pages/product.p.dart';

part 'pages/book_tour.p.dart';

part 'pages/settings.p.dart';

part 'pages/my_purchases.p.dart';

part 'pages/invite_friends.p.dart';

part 'pages/personal_development_books.p.dart';

part 'pages/share_view.p.dart';

part 'pages/reply_to_book_clipping.p.dart';

part 'pages/payment_history.p.dart';

part 'pages/book_categories.p.dart';

part 'pages/text_books.p.dart';
part 'pages/my_subscriptions.p.dart';
part 'pages/splash.p.dart';

part 'pages/my_books.p.dart';

part 'pages/my_shelves.p.dart';

part 'pages/bookmarked_books.p.dart';

part 'pages/my_clippings.p.dart';
part 'pages/my_chapters.p.dart';
part 'pages/chapter_detail.p.dart';

part 'pages/my_book_excerpt_comments.p.dart';

part 'pages/wallet.p.dart';

part 'pages/user_profile.p.dart';

part 'pages/profile_management.p.dart';

part 'pages/reviews_and_rating.p.dart';

part 'pages/get_started.p.dart';

part 'pages/intro.p.dart';
part 'pages/buy_subscription.p.dart';

part 'pages/login.p.dart';


part 'pages/bottom_navigation/bottom_navigation.p.dart';

part 'pages/bottom_navigation/home.p.dart';

part 'pages/bottom_navigation/category.p.dart';

part 'pages/bottom_navigation/profile.p.dart';

part 'pages/bottom_navigation/shop.p.dart';

part 'pages/bottom_navigation/my_books.p.dart';

part 'pages/upload_product.p.dart';

final GlobalKey<NavigatorState> rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');

class PathRoute {
  static const String shareViewRoute = '/shareView';
  static const String replyToBookClippingRoute = '/replyToBookClipping';
  static const String bookTourRoute = '/bookTour';
  static const String myCommentsMainRoute = '/myCommentsMain';
  static const String buySubscriptionRoute = '/buySubscriptionRoute';
  static const String settingsRoute = '/settings';
  static const String inviteFriendsRoute = '/inviteFriends';
  static const String mySubscriptionsRoute = '/mySubscriptionsRoute';
  static const String homePageRoute = '/homePage';
  static const String authorBookRoute = '/authorBook';
  static const String bookPublisherRoute = '/bookPublisher';
  static const String bookIDRoute = '/bookID';
  static const String personalDevelopmentBooksRoute =
      '/personalDevelopmentBooks';
  static const String textBooksRoute = '/textBooks';
  static const String bookCategoriesRoute = '/bookCategories';
  static const String profileManagementRoute = '/profileManagement';
  static const String myClippingsRoute = '/myClippings';
  static const String paymentHistoryRoute = '/paymentHistory';
  static const String walletRoute = '/wallet';
  static const String myShelvesRoute = '/myShelves';
  static const String myBooksRoute = '/myBooks';
  static const String bookmarkedBooksRoute = '/bookmarkedBooks';
  static const String myPurchasesRoute = '/myPurchases';
  static const String userProfileRoute = '/userProfile';
  static const String passwordRoute = '/password';
  static const String verificationRoute = '/verification';
  static const String reviewsAndRatingRoute = '/reviewsAndRating';
  static const String getStartedRoute = '/getStarted';
  static const String splashRoute = '/splash';
  static const String loginRoute = '/loginRoute';
  static const String introRoute = '/introRoute';
  static const String giftCardRoute = '/giftCardRoute';
  static const String giftToOthersRoute = '/giftToOthersRoute';
  static const String myCommentsRoute = '/myCommentsRoute';
  static const String myBookExcerptCommentsRoute = '/myBookExcerptComments';
  static const String productRoute = '/productRoute';
  static const String paymentSuccessRoute = '/paymentSuccess';
  static const String studyTourRequestRoute = '/study-tour-request';
  static const String studyTourListRoute = '/study-tour-list';
  static const String studyTourDetailRoute = '/study-tour-detail';
  static const String uploadProductRoute = '/upload-product';
}

PathRoute pathRoute = PathRoute();

final typedRouter = GoRouter(
  navigatorKey: rootNavigatorKey,
  initialLocation: PathRoute.splashRoute,
  // HomeRouteData.route
  // PathRoute.userProfileRoute,
  routes: $appRoutes,
  redirect: (context, state) {
    // Prevent GoRouter from trying to parse custom scheme URLs (academic://)
    final uri = state.uri;
    if (uri.scheme == 'academic' || uri.scheme == 'app') {
      // Return null to stay on current route, DeepLinkService will handle navigation
      return null;
    }
    return null;
  },
  errorBuilder: (context, state) {
    // Handle GoRouter errors (e.g., custom scheme deep links)
    print('⚠️ GoRouter error: ${state.error}');
    // Return a temporary widget, will be replaced by DeepLinkService navigation
    return const SizedBox.shrink();
  },
);

@TypedGoRoute<PlayerRoute>(
  path: '/player',
)
class PlayerRoute extends GoRouteData {
  const PlayerRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    final product = state.extra as ProductModel;
    final globalPlayer = GlobalPlayer.of(context);
    if (globalPlayer != null) {
      globalPlayer.playerCubit.initPlayer(
        product.sampleAudio ?? '',
        title: product.name ?? l10n.untitled,
        cover: product.image ?? 'https://via.placeholder.com/150',
      );
    }
    String categoryName = l10n.uncategorized;
    if (product.categories != null && product.categories!.isNotEmpty) {
      categoryName = product.categories!.first.name ?? l10n.uncategorized;
    }
    final publisherName = product.publisher ?? l10n.unknownPublisher;
    final coverUrl = product.image ?? 'https://via.placeholder.com/150';
    final titleText = product.name ?? l10n.untitled;
    final subjectText = l10n.audioBook;
    return PlayerPage(
      cover: coverUrl,
      title: titleText,
      publisher: publisherName,
      subject: subjectText,
      category: categoryName,
      audioUrl: product.sampleAudio,
      product: product,
    );
  }
}

@TypedGoRoute<CartRoute>(
  path: '/cart',
)
class CartRoute extends GoRouteData {
  const CartRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const CartPage();
  }
}

@TypedGoRoute<PaymentSuccessRoute>(
  path: PathRoute.paymentSuccessRoute,
)
class PaymentSuccessRoute extends GoRouteData {
  const PaymentSuccessRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    final extra = state.extra as Map<String, dynamic>;
    return PaymentSuccessPage(
      trackingCode: extra['trackingCode'] as String?,
      amount: extra['amount'] as int,
      paymentType: extra['paymentType'] as String,
      orderNumber: extra['orderNumber'] as String?,
      transactionId: extra['transactionId'] as String?,
      items: extra['items'] as List<Map<String, dynamic>>?,
    );
  }
}

@TypedGoRoute<StudyTourRequestRoute>(
  path: PathRoute.studyTourRequestRoute,
)
class StudyTourRequestRoute extends GoRouteData {
  const StudyTourRequestRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider(
      create: (context) => getIt<StudyTourRequestCubit>(),
      child: const StudyTourRequestPage(),
    );
  }
}

@TypedGoRoute<StudyTourListRoute>(
  path: PathRoute.studyTourListRoute,
)
class StudyTourListRoute extends GoRouteData {
  const StudyTourListRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider(
      create: (context) => getIt<StudyTourListCubit>(),
      child: const StudyTourListPage(),
    );
  }
}

@TypedGoRoute<StudyTourDetailRoute>(
  path: '${PathRoute.studyTourDetailRoute}/:studyTourId',
)
class StudyTourDetailRoute extends GoRouteData {
  final String studyTourId;
  
  const StudyTourDetailRoute({required this.studyTourId});

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider(
      create: (context) => getIt<StudyTourDetailCubit>(),
      child: StudyTourDetailPage(studyTourId: studyTourId),
    );
  }
}

@TypedGoRoute<TagBooksRoute>(
  path: '/tag-books/:tagId/:tagName',
)
class TagBooksRoute extends GoRouteData {
  final String tagId;
  final String tagName;
  
  const TagBooksRoute({required this.tagId, required this.tagName});

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider(
      create: (context) => TagBooksCubit(),
      child: TagBooksPage(
        tagId: int.parse(tagId),
        title: tagName,
      ),
    );
  }
}

@TypedGoRoute<AuthorBooksRoute>(
  path: '/author-books/:authorId',
)
class AuthorBooksRoute extends GoRouteData {
  final String authorId;
  final String? authorName;
  
  const AuthorBooksRoute({required this.authorId, this.authorName});

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider(
      create: (context) => TagBooksCubit(),
      child: TagBooksPage(
        authorId: int.parse(authorId),
        title: authorName ?? l10n.authorBooks,
      ),
    );
  }
}

@TypedGoRoute<PublisherBooksRoute>(
  path: '/publisher-books/:publisherId',
)
class PublisherBooksRoute extends GoRouteData {
  final String publisherId;
  final String? publisherName;
  
  const PublisherBooksRoute({required this.publisherId, this.publisherName});

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider(
      create: (context) => TagBooksCubit(),
      child: TagBooksPage(
        publisherId: int.tryParse(publisherId),
        publisherName: publisherName,
        title: publisherName ?? l10n.publisherBooks,
      ),
    );
  }
}

// @TypedGoRoute<SplashRoute>(
//   path: PathRoute.splashRoute,
// )
// class SplashRoute extends GoRouteData {
//   const SplashRoute();
//
//   @override
//   Widget build(BuildContext context, GoRouterState state) {
//     return BlocProvider(
//       create: (context) =>
//           getIt<SplashBloc>()..add(const SplashEvent.appInitialized()),
//       child: BaseSplashPage.page(),
//     );
//   }
