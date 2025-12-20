import 'package:academic/data/api/cart/model/cart_model.dart';
import 'package:academic/data/api/payment/model/payment_model.dart';
import 'package:academic/pages/payment/logic/payment_cubit.dart';
import 'package:injectable/injectable.dart';

@injectable
class PaymentService {
  final PaymentCubit _paymentCubit;

  PaymentService(this._paymentCubit);

  /// Process payment for cart items
  Future<void> processCartPayment({
    required CartMeta cartMeta,
    String? discountCode,
    String gatewayName = 'zarinpal',
  }) async {
    // Extract book IDs from cart meta
    final bookIds = cartMeta.bookIds
        .map((id) => id is int ? id : int.tryParse(id.toString()))
        .where((id) => id != null)
        .cast<int>()
        .toList();

    final response = await _paymentCubit.createPayment(
      amount: cartMeta.total,
      discountCode: discountCode,
      gatewayName: gatewayName,
      bookIds: bookIds.isNotEmpty ? bookIds : null,
      type: PaymentType.book,
    );

    // If payment has return_url, we can use it for deep linking
    if (response?.returnUrl != null) {
      print('Payment return URL: ${response!.returnUrl}');
    }
  }

  /// Process subscription payment
  Future<void> processSubscriptionPayment({
    required int amount,
    required int planId,
    String? discountCode,
    String gatewayName = 'zarinpal',
  }) async {
    await _paymentCubit.createPayment(
      amount: amount,
      discountCode: discountCode,
      gatewayName: gatewayName,
      planId: planId,
      type: PaymentType.subscription,
    );
  }

  /// Process gift card payment
  Future<void> processGiftCardPayment({
    required int amount,
    String? mobile,
    String? discountCode,
    String gatewayName = 'zarinpal',
  }) async {
    await _paymentCubit.createPayment(
      amount: amount,
      discountCode: discountCode,
      gatewayName: gatewayName,
      mobile: mobile,
      type: PaymentType.giftCard,
    );
  }

  /// Process wallet recharge
  Future<void> processWalletRecharge({
    required int amount,
    String? discountCode,
    String gatewayName = 'zarinpal',
  }) async {
    await _paymentCubit.createPayment(
      amount: amount,
      discountCode: discountCode,
      gatewayName: gatewayName,
      type: PaymentType.wallet,
    );
  }
}
