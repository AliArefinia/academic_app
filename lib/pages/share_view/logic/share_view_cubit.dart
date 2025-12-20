import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'share_view_state.dart';
part 'share_view_event.dart'; // Add event part
part 'share_view_cubit.freezed.dart'; // Add freezed part

class ShareviewCubit extends Cubit<ShareviewState> {
  ShareviewCubit() : super(const ShareviewState.initial());
}
