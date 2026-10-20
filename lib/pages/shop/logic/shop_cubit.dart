import 'package:academic/l10n/l10n.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../data/repo/shop_repository.dart';
import 'shop_state.dart';

@injectable
class ShopCubit extends Cubit<ShopState> {
  final ShopRepository _repository;

  String? searchQuery;

  ShopCubit(this._repository) : super(const ShopState.initial()) {
    fetchShopData();
  }

  void setSearchQuery(String? query) {
    searchQuery = query;
    fetchShopData(query: query);
  }

  void clearFilters() {
    searchQuery = null;
    fetchShopData();
  }

  Future<void> fetchShopData({
    String? query,
  }) async {
    emit(const ShopState.loading());

    try {
      final response = await _repository.fetchShopData(
        query: query,
      );

      // Check if all sections are empty or null
      final isAllEmpty = [
        response.pamphlets?.data,
        response.educational?.data,
        response.questionBank?.data,
        response.periodical?.data,
        response.quarterly?.data,
        response.monthly?.data,
        response.yearbook?.data,
      ].every((list) => list == null || list.isEmpty);

      if (isAllEmpty) {
        emit(const ShopState.empty());
      } else {
        emit(ShopState.success(response));
      }
    } catch (e) {
      // Error logged by repository
      emit(ShopState.error(l10n.errorFetchingShop));
    }
  }
}

