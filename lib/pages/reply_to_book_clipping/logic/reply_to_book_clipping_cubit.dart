import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'reply_to_book_clipping_state.dart';
part 'reply_to_book_clipping_event.dart'; // Add event part
part 'reply_to_book_clipping_cubit.freezed.dart'; // Add freezed part

class ReplytobookclippingCubit extends Cubit<ReplytobookclippingState> {
  ReplytobookclippingCubit() : super(const ReplytobookclippingState.initial());

  final TextEditingController textEditingController = TextEditingController();

}
