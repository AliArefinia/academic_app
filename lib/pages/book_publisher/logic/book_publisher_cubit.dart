import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'book_publisher_state.dart';
part 'book_publisher_event.dart'; // Add event part
part 'book_publisher_cubit.freezed.dart'; // Add freezed part

class BookpublisherCubit extends Cubit<BookpublisherState> {
  BookpublisherCubit() : super(const BookpublisherState.initial());
}
