import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:academic/core/services/payment_service.dart';
import 'package:academic/data/api/product/model/product_model.dart';
import 'package:get_it/get_it.dart';

part 'gift_to_others_state.dart';
part 'gift_to_others_event.dart'; // Add event part
part 'gift_to_others_cubit.freezed.dart'; // Add freezed part

class GifttoothersCubit extends Cubit<GifttoothersState> {
  GifttoothersCubit() : super(const GifttoothersState.initial());

  final TextEditingController textEditingController = TextEditingController();

  Future<void> processGiftBookPayment(ProductModel product) async {
    try {
      emit(const GifttoothersState.processing());
      
      final paymentService = GetIt.I<PaymentService>();
      final amount = (product.discountPrice ?? product.price ?? 0).toInt();
      
      await paymentService.processGiftCardPayment(
        amount: amount,
        mobile: textEditingController.text,
      );
      
      emit(const GifttoothersState.success());
    } catch (e) {
      emit(GifttoothersState.error(e.toString()));
    }
  }
}
