import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_started_state.dart';
part 'get_started_event.dart'; // Add event part
part 'get_started_cubit.freezed.dart'; // Add freezed part

class GetStartedCubit extends Cubit<GetStartedState> {
  GetStartedCubit() : super(const GetStartedState.initial());
}
