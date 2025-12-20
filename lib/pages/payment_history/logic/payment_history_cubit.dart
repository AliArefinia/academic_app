import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import '../../../data/api/payment_history/model/payment_history_model.dart';
import '../../../data/repository/payment_history_repository.dart';
import 'package:flutter/foundation.dart';

part 'payment_history_state.dart';
part 'payment_history_event.dart'; // Add event part
part 'payment_history_cubit.freezed.dart'; // Add freezed part

@injectable
class PaymenthistoryCubit extends Cubit<PaymenthistoryState> {
  final IPaymentHistoryRepository _repository;

  PaymenthistoryCubit(this._repository) : super(const PaymenthistoryState.initial());

  Future<void> getPaymentHistory() async {
    try {
      emit(const PaymenthistoryState.loading());
      final response = await _repository.getPaymentHistory();
      emit(PaymenthistoryState.success(response.data));
    } catch (e, stackTrace) {
      if (kDebugMode) {
        print('Error fetching payment history: $e');
        print(stackTrace);
      }
      emit(PaymenthistoryState.error(e.toString()));
    }
  }
}
