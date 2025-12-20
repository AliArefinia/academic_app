import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:academic/data/repository/cart_repository.dart';

part 'discount_cubit.freezed.dart';

@freezed
sealed class DiscountState with _$DiscountState {
  const factory DiscountState.initial() = _Initial;
  const factory DiscountState.validating() = _Validating;
  const factory DiscountState.valid(String message, String code) = _Valid;
  const factory DiscountState.invalid(String message) = _Invalid;
}

@injectable
class DiscountCubit extends Cubit<DiscountState> {
  final ICartRepository _repository;

  DiscountCubit(this._repository) : super(const DiscountState.initial());

  Future<void> validateDiscount(String code) async {
    try {
      emit(const DiscountState.validating());
      
      final result = await _repository.applyDiscount(code);
      
      if (result.status == 1) {
        emit(DiscountState.valid('کد تخفیف با موفقیت اعمال شد', code));
      } else {
        final error = result.displayMessage;
        emit(DiscountState.invalid(error));
      }
    } catch (e) {
      emit(DiscountState.invalid(e.toString().replaceAll('Exception: ', '')));
    }
  }

  void reset() {
    emit(const DiscountState.initial());
  }
} 