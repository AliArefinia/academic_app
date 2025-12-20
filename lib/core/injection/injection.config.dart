// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

import '../../data/api/api_service.dart' as _i236;
import '../../data/api/auth/auth_api.dart' as _i956;
import '../../data/api/book_excerpts/book_excerpts_api_service.dart' as _i738;
import '../../data/api/bookmarks/bookmarks_api.dart' as _i505;
import '../../data/api/books/books_api.dart' as _i681;
import '../../data/api/cart/cart_api.dart' as _i783;
import '../../data/api/categories/categories_api.dart' as _i871;
import '../../data/api/gifts/gifts_api.dart' as _i837;
import '../../data/api/headlines/headlines_api.dart' as _i714;
import '../../data/api/home/home_api_service.dart' as _i699;
import '../../data/api/invitation/invitation_api.dart' as _i171;
import '../../data/api/likes/likes_api.dart' as _i656;
import '../../data/api/my_book_cases/book_case_api.dart' as _i658;
import '../../data/api/my_book_excerpts/my_book_excerpts_api_service.dart'
    as _i1037;
import '../../data/api/my_books/my_books_api.dart' as _i35;
import '../../data/api/my_purchases/my_purchases_api.dart' as _i631;
import '../../data/api/notes/notes_api.dart' as _i935;
import '../../data/api/payment/payment_api.dart' as _i393;
import '../../data/api/payment_history/payment_history_api.dart' as _i614;
import '../../data/api/people/people_api.dart' as _i755;
import '../../data/api/product/product_api.dart' as _i154;
import '../../data/api/product_request/product_request_api.dart' as _i411;
import '../../data/api/profile/profile_api.dart' as _i766;
import '../../data/api/shop/shop_api_service.dart' as _i124;
import '../../data/api/study_tour_request/study_tour_request_api.dart' as _i488;
import '../../data/api/subscription/subscription_api.dart' as _i314;
import '../../data/api/user_reviews/user_reviews_api.dart' as _i1010;
import '../../data/repo/auth_repo.dart' as _i922;
import '../../data/repo/book_case_repository.dart' as _i1051;
import '../../data/repo/book_excerpts_repository.dart' as _i477;
import '../../data/repo/chapters_repository.dart' as _i589;
import '../../data/repo/home_repository.dart' as _i424;
import '../../data/repo/my_book_excerpts_repository.dart' as _i866;
import '../../data/repo/my_books_repository.dart' as _i7;
import '../../data/repo/my_purchases_repository.dart' as _i803;
import '../../data/repo/notes_repository.dart' as _i292;
import '../../data/repo/profile_repository.dart' as _i310;
import '../../data/repo/shop_repository.dart' as _i377;
import '../../data/repo/user_reviews_repository.dart' as _i770;
import '../../data/repository/bookmarks_repository.dart' as _i255;
import '../../data/repository/cart_repository.dart' as _i156;
import '../../data/repository/categories_repository.dart' as _i1;
import '../../data/repository/gifts_repository.dart' as _i584;
import '../../data/repository/invitation_repository.dart' as _i682;
import '../../data/repository/likes_repository.dart' as _i810;
import '../../data/repository/payment_history_repository.dart' as _i396;
import '../../data/repository/payment_repository.dart' as _i678;
import '../../data/repository/product_repository.dart' as _i262;
import '../../data/repository/product_request_repository.dart' as _i1038;
import '../../data/repository/study_tour_request_repository.dart' as _i721;
import '../../data/repository/subscription_repository.dart' as _i960;
import '../../pages/auth/login/logic/login_cubit.dart' as _i648;
import '../../pages/auth/password/logic/password_cubit.dart' as _i99;
import '../../pages/auth/verification/logic/verification_cubit.dart' as _i144;
import '../../pages/book_categories/logic/book_categories_cubit.dart' as _i391;
import '../../pages/book_tour/logic/book_tour_cubit.dart' as _i869;
import '../../pages/bookmarked_books/logic/bookmarked_books_cubit.dart'
    as _i123;
import '../../pages/buy_subscription/logic/buy_subscription_cubit.dart'
    as _i362;
import '../../pages/cart/logic/cart_cubit.dart' as _i563;
import '../../pages/cart/logic/discount_cubit.dart' as _i1048;
import '../../pages/chapter_detail/logic/chapter_detail_cubit.dart' as _i499;
import '../../pages/home_page/logic/home_page_cubit.dart' as _i985;
import '../../pages/invite_friends/logic/invite_friends_cubit.dart' as _i372;
import '../../pages/my_book_excerpt_comments/logic/my_book_excerpt_comments_cubit.dart'
    as _i813;
import '../../pages/my_books/logic/my_books_cubit.dart' as _i619;
import '../../pages/my_chapters/logic/my_chapters_cubit.dart' as _i956;
import '../../pages/my_clippings/logic/my_clippings_cubit.dart' as _i349;
import '../../pages/my_comments_main/logic/my_comments_main_cubit.dart'
    as _i611;
import '../../pages/my_purchases/logic/my_purchases_cubit.dart' as _i1015;
import '../../pages/my_subscriptions/logic/my_subscriptions_cubit.dart' as _i39;
import '../../pages/payment/logic/payment_cubit.dart' as _i24;
import '../../pages/payment_history/logic/payment_history_cubit.dart' as _i739;
import '../../pages/profile_management/logic/profile_management_cubit.dart'
    as _i287;
import '../../pages/public_chapters/logic/public_chapters_cubit.dart' as _i95;
import '../../pages/shop/logic/shop_cubit.dart' as _i496;
import '../../pages/splash/logic/splash_cubit.dart' as _i409;
import '../../pages/study_tour_detail/logic/study_tour_detail_cubit.dart'
    as _i694;
import '../../pages/study_tour_list/logic/study_tour_list_cubit.dart' as _i444;
import '../../pages/study_tour_request/logic/study_tour_request_cubit.dart'
    as _i203;
import '../../pages/upload_product/logic/upload_product_cubit.dart' as _i745;
import '../../pages/user_profile/logic/user_profile_cubit.dart' as _i989;
import '../services/deep_link_service.dart' as _i391;
import '../services/payment_service.dart' as _i809;
import '../services/payment_tracking_service.dart' as _i80;
import '../services/reading_progress_service.dart' as _i274;
import '../services/url_handler_service.dart' as _i971;
import '../storage/local_storage.dart' as _i329;
import 'injection.dart' as _i464;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final registerModule = _$RegisterModule();
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => registerModule.prefs,
      preResolve: true,
    );
    gh.lazySingleton<_i329.LocalStorage>(() =>
        registerModule.provideLocalStorage(gh<_i460.SharedPreferences>()));
    gh.lazySingleton<_i274.ReadingProgressService>(() => registerModule
        .provideReadingProgressService(gh<_i460.SharedPreferences>()));
    gh.lazySingleton<_i236.ApiClient>(
        () => registerModule.provideApiClient(gh<_i329.LocalStorage>()));
    gh.lazySingleton<_i361.Dio>(
        () => registerModule.provideDio(gh<_i236.ApiClient>()));
    gh.lazySingleton<_i614.PaymentHistoryApi>(
        () => registerModule.providePaymentHistoryApi(gh<_i361.Dio>()));
    gh.lazySingleton<_i755.PeopleApi>(
        () => registerModule.providePeopleApi(gh<_i361.Dio>()));
    gh.lazySingleton<_i1010.UserReviewsApiService>(
        () => registerModule.provideUserReviewsApiService(gh<_i361.Dio>()));
    gh.lazySingleton<_i658.BookCaseApi>(
        () => _i658.BookCaseApi(gh<_i361.Dio>()));
    gh.lazySingleton<_i411.ProductRequestApi>(
        () => _i411.ProductRequestApi(gh<_i361.Dio>()));
    gh.lazySingleton<_i699.HomeApiService>(
        () => _i699.HomeApiService(gh<_i361.Dio>()));
    gh.lazySingleton<_i35.MyBooksApi>(() => _i35.MyBooksApi(gh<_i361.Dio>()));
    gh.lazySingleton<_i656.LikesApi>(() => _i656.LikesApi(gh<_i361.Dio>()));
    gh.lazySingleton<_i956.AuthApiService>(
        () => _i956.AuthApiService(gh<_i361.Dio>()));
    gh.lazySingleton<_i393.PaymentApi>(() => _i393.PaymentApi(gh<_i361.Dio>()));
    gh.lazySingleton<_i714.HeadlinesApi>(
        () => _i714.HeadlinesApi(gh<_i361.Dio>()));
    gh.lazySingleton<_i124.ShopApiService>(
        () => _i124.ShopApiService(gh<_i361.Dio>()));
    gh.lazySingleton<_i681.BooksApi>(() => _i681.BooksApi(gh<_i361.Dio>()));
    gh.lazySingleton<_i154.ProductApi>(() => _i154.ProductApi(gh<_i361.Dio>()));
    gh.lazySingleton<_i314.SubscriptionApi>(
        () => _i314.SubscriptionApi(gh<_i361.Dio>()));
    gh.lazySingleton<_i935.NotesApi>(() => _i935.NotesApi(gh<_i361.Dio>()));
    gh.lazySingleton<_i505.BookmarksApi>(
        () => _i505.BookmarksApi(gh<_i361.Dio>()));
    gh.lazySingleton<_i488.StudyTourRequestApi>(
        () => _i488.StudyTourRequestApi(gh<_i361.Dio>()));
    gh.lazySingleton<_i837.GiftsApi>(() => _i837.GiftsApi(gh<_i361.Dio>()));
    gh.lazySingleton<_i783.CartApi>(() => _i783.CartApi(gh<_i361.Dio>()));
    gh.lazySingleton<_i631.MyPurchasesApi>(
        () => _i631.MyPurchasesApi(gh<_i361.Dio>()));
    gh.lazySingleton<_i171.InvitationApi>(
        () => _i171.InvitationApi(gh<_i361.Dio>()));
    gh.lazySingleton<_i871.CategoriesApi>(
        () => _i871.CategoriesApi(gh<_i361.Dio>()));
    gh.factory<_i766.ProfileApiService>(
        () => _i766.ProfileApiService(gh<_i361.Dio>()));
    gh.lazySingleton<_i738.BookExcerptsApiService>(
        () => _i738.BookExcerptsApiService(gh<_i361.Dio>()));
    gh.lazySingleton<_i1037.MyBookExcerptsApiService>(
        () => _i1037.MyBookExcerptsApiService(gh<_i361.Dio>()));
    gh.lazySingleton<_i803.IMyPurchasesRepository>(
        () => _i803.MyPurchasesRepository(gh<_i631.MyPurchasesApi>()));
    gh.lazySingleton<_i7.MyBooksRepository>(
        () => _i7.MyBooksRepository(gh<_i35.MyBooksApi>()));
    gh.lazySingleton<_i584.IGiftsRepository>(
        () => _i584.GiftsRepository(gh<_i837.GiftsApi>()));
    gh.factory<_i619.MyBooksCubit>(
        () => _i619.MyBooksCubit(gh<_i7.MyBooksRepository>()));
    gh.lazySingleton<_i678.IPaymentRepository>(
        () => _i678.PaymentRepository(gh<_i393.PaymentApi>()));
    gh.lazySingleton<_i1051.BookCaseRepository>(
        () => _i1051.BookCaseRepository(gh<_i658.BookCaseApi>()));
    gh.factory<_i721.IStudyTourRequestRepository>(() =>
        _i721.StudyTourRequestRepository(gh<_i488.StudyTourRequestApi>()));
    gh.lazySingleton<_i682.IInvitationRepository>(
        () => _i682.InvitationRepository(gh<_i171.InvitationApi>()));
    gh.lazySingleton<_i866.MyBookExcerptsRepository>(() =>
        _i866.MyBookExcerptsRepository(gh<_i1037.MyBookExcerptsApiService>()));
    gh.lazySingleton<_i810.ILikesRepository>(
        () => _i810.LikesRepository(gh<_i656.LikesApi>()));
    gh.lazySingleton<_i292.NotesRepository>(
        () => registerModule.provideNotesRepository(gh<_i935.NotesApi>()));
    gh.lazySingleton<_i255.IBookmarksRepository>(
        () => _i255.BookmarksRepository(gh<_i505.BookmarksApi>()));
    gh.factory<_i1015.MypurchasesCubit>(
        () => _i1015.MypurchasesCubit(gh<_i803.IMyPurchasesRepository>()));
    gh.lazySingleton<_i960.ISubscriptionRepository>(
        () => _i960.SubscriptionRepository(gh<_i314.SubscriptionApi>()));
    gh.lazySingleton<_i377.ShopRepository>(
        () => _i377.ShopRepository(gh<_i124.ShopApiService>()));
    gh.lazySingleton<_i770.IUserReviewsRepository>(() => registerModule
        .provideUserReviewsRepository(gh<_i1010.UserReviewsApiService>()));
    gh.factory<_i922.AuthRepo>(() => _i922.AuthRepo(
          gh<_i956.AuthApiService>(),
          gh<_i329.LocalStorage>(),
        ));
    gh.factory<_i611.MycommentsmainCubit>(
        () => _i611.MycommentsmainCubit(gh<_i770.IUserReviewsRepository>()));
    gh.lazySingleton<_i1038.IProductRequestRepository>(
        () => _i1038.ProductRequestRepository(gh<_i411.ProductRequestApi>()));
    gh.factory<_i409.SplashCubit>(() => _i409.SplashCubit(
          gh<_i329.LocalStorage>(),
          gh<_i960.ISubscriptionRepository>(),
        ));
    gh.lazySingleton<_i262.IProductRepository>(
        () => _i262.ProductRepository(gh<_i154.ProductApi>()));
    gh.lazySingleton<_i396.IPaymentHistoryRepository>(
        () => _i396.PaymentHistoryRepository(gh<_i614.PaymentHistoryApi>()));
    gh.lazySingleton<_i589.ChaptersRepository>(
        () => registerModule.provideChaptersRepository(
              gh<_i714.HeadlinesApi>(),
              gh<_i262.IProductRepository>(),
            ));
    gh.factory<_i310.ProfileRepository>(
        () => _i310.ProfileRepository(gh<_i766.ProfileApiService>()));
    gh.lazySingleton<_i156.ICartRepository>(
        () => _i156.CartRepository(gh<_i783.CartApi>()));
    gh.lazySingleton<_i1.ICategoriesRepository>(
        () => _i1.CategoriesRepository(gh<_i871.CategoriesApi>()));
    gh.lazySingleton<_i424.HomeRepository>(
        () => _i424.HomeRepository(gh<_i699.HomeApiService>()));
    gh.factory<_i1048.DiscountCubit>(
        () => _i1048.DiscountCubit(gh<_i156.ICartRepository>()));
    gh.factory<_i563.CartCubit>(
        () => _i563.CartCubit(gh<_i156.ICartRepository>()));
    gh.lazySingleton<_i477.BookExcerptsRepository>(
        () => _i477.BookExcerptsRepository(gh<_i738.BookExcerptsApiService>()));
    gh.factory<_i444.StudyTourListCubit>(() =>
        _i444.StudyTourListCubit(gh<_i721.IStudyTourRequestRepository>()));
    gh.factory<_i694.StudyTourDetailCubit>(() =>
        _i694.StudyTourDetailCubit(gh<_i721.IStudyTourRequestRepository>()));
    gh.factory<_i99.PasswordCubit>(() => _i99.PasswordCubit(
          gh<_i922.AuthRepo>(),
          gh<String>(),
        ));
    gh.factory<_i123.BookmarkedBooksCubit>(
        () => _i123.BookmarkedBooksCubit(gh<_i255.IBookmarksRepository>()));
    gh.factory<_i745.UploadProductCubit>(() => _i745.UploadProductCubit(
          gh<_i1038.IProductRequestRepository>(),
          gh<_i1.ICategoriesRepository>(),
        ));
    gh.factory<_i372.InvitefriendsCubit>(() => _i372.InvitefriendsCubit(
          gh<_i329.LocalStorage>(),
          gh<_i682.IInvitationRepository>(),
          gh<_i584.IGiftsRepository>(),
        ));
    gh.factory<_i739.PaymenthistoryCubit>(
        () => _i739.PaymenthistoryCubit(gh<_i396.IPaymentHistoryRepository>()));
    gh.factory<_i24.PaymentCubit>(
        () => _i24.PaymentCubit(gh<_i678.IPaymentRepository>()));
    gh.factory<_i989.UserprofileCubit>(() => _i989.UserprofileCubit(
          gh<_i329.LocalStorage>(),
          gh<_i922.AuthRepo>(),
          gh<_i310.ProfileRepository>(),
        ));
    gh.factory<_i203.StudyTourRequestCubit>(() => _i203.StudyTourRequestCubit(
          gh<_i1.ICategoriesRepository>(),
          gh<_i721.IStudyTourRequestRepository>(),
        ));
    gh.factory<_i813.MyBookExcerptCommentsCubit>(
        () => _i813.MyBookExcerptCommentsCubit(
              gh<_i866.MyBookExcerptsRepository>(),
              gh<int>(),
            ));
    gh.factory<_i956.MyChaptersCubit>(
        () => _i956.MyChaptersCubit(gh<_i589.ChaptersRepository>()));
    gh.factory<_i95.PublicChaptersCubit>(
        () => _i95.PublicChaptersCubit(gh<_i589.ChaptersRepository>()));
    gh.factory<_i496.ShopCubit>(
        () => _i496.ShopCubit(gh<_i377.ShopRepository>()));
    gh.factory<_i499.ChapterDetailCubit>(() => _i499.ChapterDetailCubit(
          gh<_i589.ChaptersRepository>(),
          gh<_i292.NotesRepository>(),
        ));
    gh.factory<_i349.MyClippingsCubit>(
        () => _i349.MyClippingsCubit(gh<_i866.MyBookExcerptsRepository>()));
    gh.factory<_i648.LoginCubit>(() => _i648.LoginCubit(gh<_i922.AuthRepo>()));
    gh.factory<_i362.BuysubscriptionCubit>(
        () => _i362.BuysubscriptionCubit(gh<_i960.ISubscriptionRepository>()));
    gh.factory<_i39.MysubscriptionsCubit>(
        () => _i39.MysubscriptionsCubit(gh<_i960.ISubscriptionRepository>()));
    gh.factory<_i391.BookcategoriesCubit>(
        () => _i391.BookcategoriesCubit(gh<_i1.ICategoriesRepository>()));
    gh.factory<_i287.ProfilemanagementCubit>(() => _i287.ProfilemanagementCubit(
          gh<_i310.ProfileRepository>(),
          gh<_i329.LocalStorage>(),
        ));
    gh.factory<_i985.HomePageCubit>(
        () => _i985.HomePageCubit(gh<_i424.HomeRepository>()));
    gh.factory<_i809.PaymentService>(
        () => _i809.PaymentService(gh<_i24.PaymentCubit>()));
    gh.factory<_i80.PaymentTrackingService>(
        () => _i80.PaymentTrackingService(gh<_i24.PaymentCubit>()));
    gh.factory<_i144.VerificationCubit>(() => _i144.VerificationCubit(
          gh<_i922.AuthRepo>(),
          gh<_i1.ICategoriesRepository>(),
        ));
    gh.factory<_i869.BooktourCubit>(() => _i869.BooktourCubit(
          gh<_i477.BookExcerptsRepository>(),
          gh<_i810.ILikesRepository>(),
        ));
    gh.factory<_i391.DeepLinkService>(() => _i391.DeepLinkService(
          gh<_i24.PaymentCubit>(),
          gh<_i563.CartCubit>(),
        ));
    gh.factory<_i971.UrlHandlerService>(
        () => _i971.UrlHandlerService(gh<_i391.DeepLinkService>()));
    return this;
  }
}

class _$RegisterModule extends _i464.RegisterModule {}
