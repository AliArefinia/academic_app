import 'dart:ffi';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:academic/core/services/payment_service.dart';
import 'package:get_it/get_it.dart';

part 'gift_card_state.dart';
part 'gift_card_event.dart'; // Add event part
part 'gift_card_cubit.freezed.dart'; // Add freezed part

class GiftcardCubit extends Cubit<GiftcardState> {
  GiftcardCubit() : super(const GiftcardState());

  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  void selectCharge(int amount) {
    emit(state.copyWith(amountOfCharge: amount));
    priceController.text = state.amountOfCharge.toString();
  }

  void showConfirmationAndPaymentSection() {
    if (phoneNumberController.text.isNotEmpty &&
        priceController.text.isNotEmpty) {
      emit(state.copyWith(isContinued: true, isPaymentSuccessful: false));
    }
  }

  Future<void> processGiftCardPayment() async {
    try {
      emit(state.copyWith(isProcessingPayment: true));
      
      final paymentService = GetIt.I<PaymentService>();
      final amount = int.tryParse(priceController.text) ?? state.amountOfCharge;
      
      await paymentService.processGiftCardPayment(
        amount: amount,
        mobile: phoneNumberController.text,
      );
      
      emit(state.copyWith(
        isProcessingPayment: false,
        isContinued: true, 
        isPaymentSuccessful: true
      ));
    } catch (e) {
      emit(state.copyWith(
        isProcessingPayment: false,
        error: e.toString()
      ));
    }
  }

  void showPaymentSuccessful() {
    emit(state.copyWith(isContinued: true, isPaymentSuccessful: true));
  }

  void bottomNavigationBarAction(int value) {
    emit(state.copyWith(index: value));
  }
}
