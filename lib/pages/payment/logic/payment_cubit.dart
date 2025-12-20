import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:academic/core/error/error_message_mapper.dart';
import 'package:academic/data/api/payment/model/payment_model.dart';
import 'package:academic/data/repository/payment_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:url_launcher/url_launcher.dart';

part 'payment_cubit.freezed.dart';
part 'payment_state.dart';

@injectable
class PaymentCubit extends Cubit<PaymentState> {
  final IPaymentRepository _repository;

  PaymentCubit(this._repository) : super(const PaymentState.initial());

  Future<PaymentResponse?> createPayment({
    required int amount,
    String? discountCode,
    required String gatewayName,
    List<int>? bookIds,
    int? planId,
    required PaymentType type,
    String? mobile,
  }) async {
    try {
      emit(const PaymentState.loading());
      final response = await _repository.createPayment(
        amount: amount,
        discountCode: discountCode,
        gatewayName: gatewayName,
        bookIds: bookIds,
        planId: planId,
        type: type,
        mobile: mobile,
      );

      // Launch payment URL
      final uri = Uri.parse(response.redirectUrl);
      print('Attempting to launch payment URL: ${response.redirectUrl}');
      
      try {
        // Try to launch URL directly without checking canLaunchUrl
        // because canLaunchUrl sometimes returns false even when launch works
        print('Launching URL directly...');
        final launched = await launchUrl(
          uri, 
          mode: LaunchMode.externalApplication,
        );
        print('Launch result: $launched');
        
        if (launched) {
          // Emit success to show message to user
          emit(PaymentState.success(response));
          return response;
        } else {
          print('Launch returned false, trying platform specific approach...');
          // Try with different mode
          final alternativeLaunch = await launchUrl(
            uri,
            mode: LaunchMode.externalNonBrowserApplication,
          );
          print('Alternative launch result: $alternativeLaunch');
          
          // Emit success anyway as URL was provided
          emit(PaymentState.success(response));
          return response;
        }
      } catch (e) {
        print('URL launch error: $e');
        print('URL that failed to launch: ${response.redirectUrl}');
        
        // Show URL to user as fallback
        emit(PaymentState.error(
            'لطفاً این لینک را در مرورگر باز کنید: ${response.redirectUrl}'));
        return response;
      }
    } catch (e) {
      emit(PaymentState.error(ErrorMessageMapper.mapError(e)));
      return null;
    }
  }

  Future<void> verifyPayment(String authority) async {
    try {
      emit(const PaymentState.loading());
      print('🔍 Verifying payment with authority: $authority');
      
      final response = await _repository.verifyPayment(authority);
      print('✅ Payment verification response: ${response.status} - ${response.message}');

      if (response.status == 200) {
        // Payment verified successfully
        print('✅ Payment verified successfully');
        emit(PaymentState.verified(response));
      } else {
        // Payment verification failed - use specific error message from server
        final errorMessage = response.message.isNotEmpty
            ? response.message
            : 'تایید پرداخت ناموفق بود. لطفاً دوباره تلاش کنید.';
        print('❌ Payment verification failed: $errorMessage');
        emit(PaymentState.error(errorMessage));
      }
    } catch (e) {
      print('❌ Payment verification error: $e');
      emit(PaymentState.error(ErrorMessageMapper.mapError(e)));
    }
  }

  Future<void> trackPayment(String trackingCode) async {
    try {
      emit(const PaymentState.loading());
      final response = await _repository.trackPayment(trackingCode);
      emit(PaymentState.tracked(response));
    } catch (e) {
      emit(PaymentState.error(ErrorMessageMapper.mapError(e)));
    }
  }
}
