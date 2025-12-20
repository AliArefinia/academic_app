import 'package:injectable/injectable.dart';
import '../api/payment_history/model/payment_history_model.dart';
import '../api/payment_history/payment_history_api.dart';

abstract class IPaymentHistoryRepository {
  Future<PaymentHistoryResponse> getPaymentHistory();
}

@LazySingleton(as: IPaymentHistoryRepository)
class PaymentHistoryRepository implements IPaymentHistoryRepository {
  final PaymentHistoryApi _api;

  PaymentHistoryRepository(this._api);

  @override
  Future<PaymentHistoryResponse> getPaymentHistory() async {
    return await _api.getPaymentHistory();
  }
} 