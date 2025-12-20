import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'select_program_language_state.dart';
part 'select_program_language_event.dart'; // Add event part
part 'select_program_language_cubit.freezed.dart'; // Add freezed part

class SelectprogramlanguageCubit extends Cubit<SelectprogramlanguageState> {
  SelectprogramlanguageCubit() : super(const SelectprogramlanguageState());

  void onLanguageTap(String language) => emit(state.copyWith(currentLanguage: language));
}
