import 'package:injectable/injectable.dart';
import '../api/payment/payment_api.dart';
import '../api/payment/model/payment_model.dart';

abstract class IPaymentRepository {
  Future<PaymentResponse> createPayment({
    required int amount,
    String? discountCode,
    required String gatewayName,
    List<int>? bookIds,
    int? planId,
    required PaymentType type,
    String? mobile,
  });
  Future<PaymentTrackingResponse> trackPayment(String trackingCode);
  Future<PaymentVerifyResponse> verifyPayment(String authority);
}

@LazySingleton(as: IPaymentRepository)
class PaymentRepository implements IPaymentRepository {
  final PaymentApi _api;

  PaymentRepository(this._api);

  @override
  Future<PaymentResponse> createPayment({
    required int amount,
    String? discountCode,
    required String gatewayName,
    List<int>? bookIds,
    int? planId,
    required PaymentType type,
    String? mobile,
  }) async {
    final request = PaymentRequest(
      amount: amount,
      discountCode: discountCode,
      gatewayName: gatewayName,
      bookIds: bookIds,
      planId: planId,
      type: type.apiValue,
      mobile: mobile,
    );
    final response = await _api.createPayment(request);
    return response.data;
  }

  @override
  Future<PaymentTrackingResponse> trackPayment(String trackingCode) async {
    return await _api.trackPayment(trackingCode);
  }

  @override
  Future<PaymentVerifyResponse> verifyPayment(String authority) async {
    final request = PaymentVerifyRequest(Authority: authority);
    try {
      final response = await _api.verifyPayment(request);
      print('✅ Payment verification response: ${response.status} - ${response.message}');
      return response;
    } catch (e) {
      print('❌ Payment verification error: $e');
      // Check if error is due to List response instead of Map
      if (e.toString().contains('List<dynamic>') && e.toString().contains('Map<String, dynamic>')) {
        throw Exception('خطا در پاسخ سرور: سرور یک خطا بازگشت داده است');
      }
      throw Exception('خطا در تایید پرداخت: ${e.toString()}');
    }
  }
}
