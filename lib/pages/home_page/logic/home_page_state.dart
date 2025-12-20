
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../data/api/home/model/home_response.dart';

part 'home_page_state.freezed.dart';

@freezed
class HomePageState with _$HomePageState {
  const factory HomePageState.initial() = _Initial;
  const factory HomePageState.loading() = _Loading;
  const factory HomePageState.success(HomeResponse data) = _Success;
  const factory HomePageState.empty() = _Empty;
  const factory HomePageState.error(String message) = _Error;
}
