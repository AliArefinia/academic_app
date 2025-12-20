import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:academic/data/repo/my_purchases_repository.dart';
import 'my_purchases_state.dart';

@injectable
class MypurchasesCubit extends Cubit<MypurchasesState> {
  final IMyPurchasesRepository _repository;

  MypurchasesCubit(this._repository) : super(const MypurchasesState.initial()) {
    fetchPurchases();
  }

  Future<void> fetchPurchases() async {
    try {
      emit(const MypurchasesState.loading());
      final response = await _repository.getMyPurchases();
      if (response.data.isEmpty) {
        emit(const MypurchasesState.empty());
      } else {
        emit(MypurchasesState.loaded(response.data));
      }
    } catch (e) {
      emit(MypurchasesState.error(e.toString()));
    }
  }
}
