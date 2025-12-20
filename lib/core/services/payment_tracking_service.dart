import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:academic/data/api/payment/model/payment_model.dart';
import 'package:academic/pages/payment/logic/payment_cubit.dart';
import 'package:injectable/injectable.dart';

@injectable
class PaymentTrackingService {
  final PaymentCubit _paymentCubit;

  PaymentTrackingService(this._paymentCubit);

  /// Track payment status and handle success/failure
  Future<void> trackPaymentAndHandleResult(
    BuildContext context,
    String trackingCode,
    int amount,
    PaymentType paymentType,
  ) async {
    try {
      await _paymentCubit.verifyPayment(trackingCode);

      // Navigate to success page
      context.go('/paymentSuccess', extra: {
        'trackingCode': trackingCode,
        'amount': amount,
        'paymentType': paymentType.apiValue,
      });
    } catch (e) {
      // Show error and navigate back
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('خطا در تایید پرداخت: $e'),
          backgroundColor: Colors.red,
        ),
      );
      context.pop();
    }
  }

  /// Handle payment URL parameters (for web-based payment gateways)
  void handlePaymentUrlParameters(
    BuildContext context,
    Map<String, String> queryParameters,
    int amount,
    PaymentType paymentType,
  ) {
    final status = queryParameters['Status'];
    final authority = queryParameters['Authority'];

    if (status == 'OK' && authority != null) {
      // Payment was successful, track it
      trackPaymentAndHandleResult(context, authority, amount, paymentType);
    } else {
      // Payment failed
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('پرداخت ناموفق بود'),
          backgroundColor: Colors.red,
        ),
      );
      context.pop();
    }
  }
}
