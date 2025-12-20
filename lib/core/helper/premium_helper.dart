import 'package:academic/core/storage/local_storage.dart';
import 'package:get_it/get_it.dart';

class PremiumHelper {
  static final LocalStorage _localStorage = GetIt.I<LocalStorage>();

  static bool isPremiumUser() {
    return _localStorage.isPremiumUser();
  }
}
