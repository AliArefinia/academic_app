import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:academic/core/injection/injection.config.dart';
import 'package:academic/core/storage/local_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/api/api_service.dart';
import '../../data/api/payment_history/payment_history_api.dart';
import '../../data/api/people/people_api.dart';
import '../../data/api/user_reviews/user_reviews_api.dart';
import '../../data/api/subscription/subscription_api.dart';
import '../../data/api/study_tour_request/study_tour_request_api.dart';
import '../../data/api/headlines/headlines_api.dart';
import '../../data/api/notes/notes_api.dart';
import '../../data/repo/user_reviews_repository.dart';
import '../../data/repository/study_tour_request_repository.dart';
import '../../data/repo/chapters_repository.dart';
import '../../data/repo/notes_repository.dart';
import 'get_it_instance.dart';
import 'package:academic/core/services/reading_progress_service.dart';
import 'package:academic/pages/payment/logic/payment_cubit.dart';
import 'package:academic/data/repository/payment_repository.dart';
import 'package:academic/data/api/payment/payment_api.dart';
import 'package:academic/data/api/books/books_api.dart';
import 'package:academic/data/repository/product_repository.dart';

final getIt = GetIt.instance;

@InjectableInit(
  initializerName: 'init',
  preferRelativeImports: true,
  asExtension: true,
)
Future<void> configureDependencies() async {
  await getIt.init();
}

@module
abstract class RegisterModule {
  @preResolve
  Future<SharedPreferences> get prefs => SharedPreferences.getInstance();

  @lazySingleton
  LocalStorage provideLocalStorage(SharedPreferences prefs) =>
      LocalStorage(prefs);

  @lazySingleton
  ReadingProgressService provideReadingProgressService(
          SharedPreferences prefs) =>
      ReadingProgressService(prefs);

  @lazySingleton
  ApiClient provideApiClient(LocalStorage localStorage) =>
      ApiClient(localStorage);

  @lazySingleton
  Dio provideDio(ApiClient apiClient) => apiClient.dioInstance;

  @lazySingleton
  PaymentHistoryApi providePaymentHistoryApi(Dio dio) => PaymentHistoryApi(dio);

  @lazySingleton
  PeopleApi providePeopleApi(Dio dio) => PeopleApi(dio);

  @lazySingleton
  UserReviewsApiService provideUserReviewsApiService(Dio dio) =>
      UserReviewsApiService(dio);

  @lazySingleton
  IUserReviewsRepository provideUserReviewsRepository(
          UserReviewsApiService apiService) =>
      UserReviewsRepository(apiService);

  // HeadlinesApi and NotesApi are auto-registered via @lazySingleton in their files

  @lazySingleton
  ChaptersRepository provideChaptersRepository(HeadlinesApi headlinesApi, IProductRepository productRepository) =>
      ChaptersRepository(headlinesApi, productRepository);

  @lazySingleton
  NotesRepository provideNotesRepository(NotesApi notesApi) =>
      NotesRepository(notesApi);

}
