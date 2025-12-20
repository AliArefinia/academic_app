import 'package:get_it/get_it.dart';
import 'package:academic/core/services/reading_progress_service.dart';
import 'package:academic/pages/product/logic/product_cubit.dart';
import 'package:academic/pages/product/product_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

Future<void> setupDependencies() async {
  // Services
  final prefs = await SharedPreferences.getInstance();
  getIt.registerSingleton<ReadingProgressService>(ReadingProgressService(prefs));
  
  // Cubits
  getIt.registerFactory<ProductCubit>(() => ProductCubit());
  
  // Handlers
  getIt.registerFactory<EpubHandler>(() => EpubHandler(
    getIt<ProductCubit>(),
    getIt<ReadingProgressService>(),
  ));
} 