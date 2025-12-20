import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:academic/core/storage/local_storage.dart';
import 'package:academic/data/repository/subscription_repository.dart';
import 'package:injectable/injectable.dart';

part 'splash_state.dart';
part 'splash_event.dart'; // اگر استفاده می‌کنی
part 'splash_cubit.freezed.dart';

@injectable
class SplashCubit extends Cubit<SplashState> {
  final LocalStorage _localStorage;
  final ISubscriptionRepository _subscriptionRepository;

  SplashCubit(this._localStorage, this._subscriptionRepository) : super(const SplashState.initial());

  Future<void> checkAuthStatus() async {
    if (isClosed) return;
    emit(const SplashState.loading());

    try {
      final token = _localStorage.getToken();
      final user = _localStorage.getUser();

      if (isClosed) return;

      if (token != null && token.isNotEmpty && user != null) {
        // بررسی وضعیت اشتراک فعال
        await _checkPremiumStatus();
        if (isClosed) return;
        emit(const SplashState.authenticated());
      } else {
        await _localStorage.clearUser();
        if (isClosed) return;
        emit(const SplashState.unauthenticated());
      }
    } catch (e) {
      if (isClosed) return;
      print('Error checking auth status: $e');
      try {
        await _localStorage.clearUser();
      } catch (clearError) {
        print('Error clearing user data: $clearError');
      }
      emit(SplashState.error(e.toString()));
    }
  }

  Future<void> _checkPremiumStatus() async {
    try {
      final activePlans = await _subscriptionRepository.getActivePlans();
      final hasActiveSubscription = activePlans.isNotEmpty;
      await _localStorage.savePremiumStatus(hasActiveSubscription);
      print('Premium status updated: $hasActiveSubscription');
    } catch (e) {
      print('Error checking premium status: $e');
      // در صورت خطا، وضعیت premium را false قرار می‌دهیم
      await _localStorage.savePremiumStatus(false);
    }
  }

  /// متد عمومی برای به‌روزرسانی وضعیت اشتراک
  Future<void> refreshPremiumStatus() async {
    await _checkPremiumStatus();
  }
}