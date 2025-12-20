import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'model/payment_history_model.dart';

part 'payment_history_api.g.dart';

@RestApi()
abstract class PaymentHistoryApi {
  factory PaymentHistoryApi(Dio dio) = _PaymentHistoryApi;

  @GET('/api/payment-history')
  Future<PaymentHistoryResponse> getPaymentHistory();
} 