import 'package:injectable/injectable.dart';
import '../api/my_purchases/my_purchases_api.dart';
import '../api/my_purchases/model/my_purchases_model.dart';

abstract class IMyPurchasesRepository {
  Future<MyPurchasesResponse> getMyPurchases();
}

@LazySingleton(as: IMyPurchasesRepository)
class MyPurchasesRepository implements IMyPurchasesRepository {
  final MyPurchasesApi _api;

  MyPurchasesRepository(this._api);

  @override
  Future<MyPurchasesResponse> getMyPurchases() async {
    return await _api.getMyPurchases();
  }
} 