import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:academic/data/api/subscription/model/subscription_plan_model.dart';
import 'package:academic/data/repository/subscription_repository.dart';

part 'buy_subscription_state.dart';
part 'buy_subscription_event.dart';
part 'buy_subscription_cubit.freezed.dart';

@injectable
class BuysubscriptionCubit extends Cubit<BuysubscriptionState> {
  final ISubscriptionRepository _repository;

  BuysubscriptionCubit(this._repository)
      : super(const BuysubscriptionState.initial()) {
    fetchSubscriptionPlans();
  }

  Future<void> fetchSubscriptionPlans() async {
    try {
      emit(const BuysubscriptionState.loading());
      final plans = await _repository.getSubscriptionPlans();
      emit(BuysubscriptionState.loaded(plans, {}));
    } catch (e) {
      emit(BuysubscriptionState.error(e.toString()));
    }
  }

  void toggleExpansion(int index) {
    state.maybeWhen(
      loaded: (plans, expandedItems) {
        final isExpanded = expandedItems[index] ?? false;
        emit(BuysubscriptionState.loaded(
          plans,
          {...expandedItems, index: !isExpanded},
        ));
      },
      orElse: () {},
    );
  }
}
