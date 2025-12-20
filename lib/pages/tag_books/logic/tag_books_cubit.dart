import 'package:bloc/bloc.dart';
import 'package:academic/data/api/books/books_api.dart';
import 'package:get_it/get_it.dart';
import 'tag_books_state.dart';

class TagBooksCubit extends Cubit<TagBooksState> {
  final BooksApi _booksApi = GetIt.I<BooksApi>();

  TagBooksCubit() : super(const TagBooksState.initial());

  Future<void> fetchTagBooks({
    int? tagId,
    int? authorId,
    int? publisherId,
    String? publisherName,
    String? query,
  }) async {
    try {
      emit(const TagBooksState.loading());
      
      // If publisherName is provided but publisherId is not, try to find publisher by name
      int? finalPublisherId = publisherId;
      if (publisherName != null && publisherId == null) {
        // For now, we'll use a simple approach - search by publisher name in query
        final response = await _booksApi.getBooks(
          tagId: tagId,
          authorId: authorId,
          query: publisherName,
          perPage: 20,
          page: 1,
        );
        final books = response.data.list.map((item) => item.toBookModel()).toList();
        emit(TagBooksState.success(books: books));
        return;
      }
      
      final response = await _booksApi.getBooks(
        tagId: tagId,
        authorId: authorId,
        publisherId: finalPublisherId,
        query: query,
        perPage: 20,
        page: 1,
      );
      // Convert BookItem to BookModel
      final books = response.data.list.map((item) => item.toBookModel()).toList();
      emit(TagBooksState.success(books: books));
    } catch (e) {
      emit(TagBooksState.error(e.toString()));
    }
  }
}
