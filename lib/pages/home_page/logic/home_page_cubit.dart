import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../data/api/home/model/home_response.dart';
import '../../../data/repo/home_repository.dart';
import 'home_page_state.dart';

@injectable
class HomePageCubit extends Cubit<HomePageState> {
  final HomeRepository _repository;

  HomePageCubit(this._repository) : super(const HomePageState.initial()) {
    fetchHomeData();
  }

  Future<void> fetchHomeData() async {
    emit(const HomePageState.loading());

    try {
      final response = await _repository.fetchHomeData();

      // ✅ Log debug info
      _logHomeResponse(response);

      // ✅ Check if all lists are empty or null
      final isAllEmpty = [
        response.sliders?.data,
        response.banners?.data,
        response.categories?.data,
        response.audioBooks?.data,
        response.textBooks?.data,
        response.latestProducts?.data,
        response.offerProducts?.data,
        response.featuredProducts?.data,
      ].every((list) => list == null || list.isEmpty);

      if (isAllEmpty) {
        emit(const HomePageState.empty());
      } else {
        emit(HomePageState.success(response));
      }
    } catch (e, stackTrace) {
      print('❌ [HomePageCubit] Error fetching home data: $e');
      print(stackTrace);
      emit(const HomePageState.error('خطا در دریافت اطلاعات صفحه اصلی'));
    }
  }

  void _logHomeResponse(HomeResponse response) {
    print('✅ [HomePageCubit] Home Data Fetched:');
    print('• sliders: ${response.sliders?.data?.length ?? 0}');
    print('• banners: ${response.banners?.data?.length ?? 0}');
    print('• categories: ${response.categories?.data?.length ?? 0}');
    print('• audioBooks: ${response.audioBooks?.data?.length ?? 0}');
    print('• textBooks: ${response.textBooks?.data?.length ?? 0}');
    print('• latestProducts: ${response.latestProducts?.data?.length ?? 0}');
    print('• offerProducts: ${response.offerProducts?.data?.length ?? 0}');
    print('• featuredProducts: ${response.featuredProducts?.data?.length ?? 0}');
  }
}