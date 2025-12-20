import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get_it/get_it.dart';
import 'package:academic/data/repository/product_repository.dart';
import 'package:academic/data/api/product/model/product_model.dart';
import 'package:academic/data/repo/my_book_excerpts_repository.dart';
import 'package:academic/data/repository/bookmarks_repository.dart';
import 'package:academic/data/repo/notes_repository.dart';

part 'product_state.dart';

part 'product_event.dart'; // Add event part
part 'product_cubit.freezed.dart'; // Add freezed part

class ProductCubit extends Cubit<ProductState> {
  final IProductRepository _productRepository = GetIt.I<IProductRepository>();
  final MyBookExcerptsRepository _bookExcerptsRepository = GetIt.I<MyBookExcerptsRepository>();
  final IBookmarksRepository _bookmarksRepository = GetIt.I<IBookmarksRepository>();
  final NotesRepository _notesRepository = GetIt.I<NotesRepository>();

  ProductCubit() : super(const ProductState());

  Future<void> fetchProduct(int id) async {
    try {
      emit(state.copyWith(isLoading: true));
      final product = await _productRepository.getProduct(id);
      emit(state.copyWith(
        isLoading: false,
        product: product,
      ));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        error: e.toString(),
      ));
    }
  }

  void rateAction(int index) {
    emit(state.copyWith(personRate: index));
  }

  void selectUsefulOption(String option) {
    emit(state.copyWith(selectedUsefulOption: option));
  }

  Future<void> addNote({
    required String excerpt,
    required List<int> chapterIds,
    String? userNote,
    required int bookId,
    required String bookName,
    required String bookImage,
    String? authorName,
    String? authorAvatar,
  }) async {
    try {
      emit(state.copyWith(
        isLoading: true,
        error: null,
        successMessage: null,
      ));
      
      // Create note for each selected chapter
      for (final chapterId in chapterIds) {
        await _notesRepository.createNote(
          excerpt: excerpt,
          userNote: userNote,
          chapterId: chapterId,
          bookId: bookId,
          bookName: bookName,
          bookImage: bookImage,
          authorName: authorName,
          authorAvatar: authorAvatar,
        );
      }
      
      emit(state.copyWith(
        isLoading: false,
        successMessage: 'یادداشت با موفقیت ذخیره شد',
      ));
      
      // Clear success message after 3 seconds
      await Future.delayed(const Duration(seconds: 3));
      emit(state.copyWith(successMessage: null));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        error: 'خطا در ذخیره یادداشت: ${e.toString()}',
        successMessage: null,
      ));
      
      // Clear error message after 3 seconds
      await Future.delayed(const Duration(seconds: 3));
      emit(state.copyWith(error: null));
    }
  }

  Future<void> toggleBookmark() async {
    try {
      final product = state.product;
      if (product == null) return;

      emit(state.copyWith(isBookmarking: true, error: null));

      final productId = product.idAsInt;
      if (productId == null) {
        throw Exception('Product ID is not available');
      }
      
      final response = await _bookmarksRepository.toggleBookmark(
        bookmarkableType: 'Product',
        bookmarkableId: productId,
      );

      // Update the product with new bookmark status
      final updatedProduct = ProductModel(
        id: product.id,
        name: product.name,
        image: product.image,
        author: product.author,
        publisher: product.publisher,
        translator: product.translator,
        audioTime: product.audioTime,
        content: product.content,
        price: product.price,
        discountPrice: product.discountPrice,
        peopleRates: product.peopleRates,
        numOfPeopleRates: product.numOfPeopleRates,
        menuOfContents: product.menuOfContents,
        bookId: product.bookId,
        type: product.type,
        authors: product.authors,
        speaker: product.speaker,
        categories: product.categories,
        excerpts: product.excerpts,
        comments: product.comments,
        commentCount: product.commentCount,
        authorBooks: product.authorBooks,
        publisherBooks: product.publisherBooks,
        epub: product.epub,
        sampleEpub: product.sampleEpub,
        sampleAudio: product.sampleAudio,
        time: product.time,
        avgRate: product.avgRate,
        fileSize: product.fileSize,
        isPurchased: product.isPurchased,
        publishYear: product.publishYear,
        headlines: product.headlines,
        hasSubscription: product.hasSubscription,
        isBookmarked: response.bookmarked,
        isLiked: product.isLiked,
        isLoggedIn: product.isLoggedIn,
        tags: product.tags,
      );
      emit(state.copyWith(
        isBookmarking: false,
        product: updatedProduct,
        successMessage: response.bookmarked ? 'کتاب به بوکمارک اضافه شد' : 'کتاب از بوکمارک حذف شد',
      ));

      // Clear success message after 3 seconds
      await Future.delayed(const Duration(seconds: 3));
      emit(state.copyWith(successMessage: null));

    } catch (e) {
      emit(state.copyWith(
        isBookmarking: false,
        error: 'خطا در بوکمارک کردن: ${e.toString()}',
      ));

      // Clear error message after 3 seconds
      await Future.delayed(const Duration(seconds: 3));
      emit(state.copyWith(error: null));
    }
  }
}
