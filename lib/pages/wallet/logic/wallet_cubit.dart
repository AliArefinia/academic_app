import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:academic/core/services/payment_service.dart';
import 'package:get_it/get_it.dart';

part 'wallet_state.dart';
part 'wallet_event.dart'; // Add event part
part 'wallet_cubit.freezed.dart'; // Add freezed part

class WalletCubit extends Cubit<WalletState> {
  WalletCubit() : super(const WalletState());

  final TextEditingController amountOfMoneyController = TextEditingController();

  void selectCharge(int amount) {
    emit(state.copyWith(amountOfCharge: amount));
    amountOfMoneyController.text = state.amountOfCharge.toString();
  }

  selectIndex(int value) {
    emit(state.copyWith(index: value));
  }

  Future<void> chargeWalletAction() async {
    if(amountOfMoneyController.text.isNotEmpty) {
      try {
        emit(state.copyWith(isProcessingPayment: true));
        
        final paymentService = GetIt.I<PaymentService>();
        final amount = int.tryParse(amountOfMoneyController.text) ?? state.amountOfCharge;
        
        await paymentService.processWalletRecharge(
          amount: amount,
        );
        
        emit(state.copyWith(
          isProcessingPayment: false,
          isPaymentSuccessful: true
        ));
      } catch (e) {
        emit(state.copyWith(
          isProcessingPayment: false,
          error: e.toString()
        ));
      }
    }
  }
}
