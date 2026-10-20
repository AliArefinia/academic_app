import 'package:academic/l10n/l10n.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:academic/data/repository/study_tour_request_repository.dart';
import 'package:academic/data/api/study_tour_request/model/study_tour_request_model.dart';
import '../models/study_tour_detail_model.dart';

part 'study_tour_detail_state.dart';
part 'study_tour_detail_cubit.freezed.dart';

@injectable
class StudyTourDetailCubit extends Cubit<StudyTourDetailState> {
  final IStudyTourRequestRepository _studyTourRequestRepository;
  
  StudyTourDetailCubit(this._studyTourRequestRepository) 
      : super(const StudyTourDetailState.initial());

  Future<void> loadStudyTourDetail(String studyTourId) async {
    try {
      emit(const StudyTourDetailState.loading());
      
      print('🚀 Starting to load study tour detail for ID: $studyTourId');
      
      // Get study tour requests from API
      final response = await _studyTourRequestRepository.getMyStudyTourRequests();
      print('📡 API response received successfully');
      
      // Find the specific study tour by ID (using title hash as ID)
      StudyTourRequestData? studyTourData;
      print('🔍 Looking for study tour with ID: $studyTourId');
      print('📋 Available study tours:');
      for (int i = 0; i < response.data.list.length; i++) {
        final item = response.data.list[i];
        final itemId = item.title.hashCode.toString();
        print('  $i: "${item.title}" -> ID: $itemId (has ${item.books.length} books)');
      }
      
      // Find study tour with books (prioritize ones with books)
      for (final item in response.data.list) {
        if (item.title.hashCode.toString() == studyTourId && item.books.isNotEmpty) {
          studyTourData = item;
          print('✅ Found study tour with books: "${item.title}" with ${item.books.length} books');
          break;
        }
      }
      
      // If not found with books, try any matching ID
      if (studyTourData == null) {
        try {
          studyTourData = response.data.list.firstWhere(
            (item) => item.title.hashCode.toString() == studyTourId,
          );
          print('✅ Found study tour: "${studyTourData.title}" with ${studyTourData.books.length} books');
        } catch (e) {
          print('❌ Study tour not found by ID, trying to find one with books...');
          // Find the first study tour that has books
          for (final item in response.data.list) {
            if (item.books.isNotEmpty) {
              studyTourData = item;
              print('✅ Found study tour with books: "${item.title}" with ${item.books.length} books');
              break;
            }
          }
          
          // If still not found, use the first one
          if (studyTourData == null && response.data.list.isNotEmpty) {
            studyTourData = response.data.list.first;
            print('⚠️ Using first study tour: "${studyTourData.title}" with ${studyTourData.books.length} books');
          }
        }
      }
      
      if (studyTourData == null) {
        emit(StudyTourDetailState.error(l10n.studyTourNotFound));
        return;
      }
      
      // Convert API books to StudyTourBookModel
      print('📚 Converting ${studyTourData.books.length} books from API');
      final books = <StudyTourBookModel>[];
      
      try {
        for (int i = 0; i < studyTourData.books.length; i++) {
          final book = studyTourData.books[i];
          print('📖 Processing book $i: $book');
          
          try {
            // book is always Map<String, dynamic> from API
            final bookMap = book as Map<String, dynamic>;
            print('📖 Book: ${bookMap['name']} - ID: ${bookMap['id']}');
            
            final bookModel = StudyTourBookModel(
              id: bookMap['id']?.toString() ?? '0',
              title: bookMap['name']?.toString() ?? l10n.untitled,
              image: bookMap['image']?.toString() ?? '',
              author: null,
              translator: null,
              publisher: null,
              audioTime: null,
              avgRate: null,
              price: bookMap['price']?.toInt(),
              discountPrice: bookMap['discount_price']?.toInt(),
              peopleRates: null,
              numOfPeopleRates: null,
              content: null,
              menuOfContents: null,
              bookId: bookMap['id']?.toString(),
              type: bookMap['type']?.toString(),
              speaker: null,
              commentCount: null,
              epub: null,
              sampleEpub: null,
              sampleAudio: null,
              time: null,
              fileSize: null,
              isPurchased: null,
              publishYear: null,
            );
            
            books.add(bookModel);
            print('✅ Book $i converted successfully');
          } catch (e, stackTrace) {
            print('❌ Error converting book $i: $e');
            print('📋 Stack trace: $stackTrace');
            // Continue with other books
          }
        }
        print('✅ Converted ${books.length} books successfully');
      } catch (e, stackTrace) {
        print('❌ Error in book conversion: $e');
        print('📋 Stack trace: $stackTrace');
        // Continue with empty books list
      }
      
      print('🏗️ Creating StudyTourDetailModel...');
      final studyTour = StudyTourDetailModel(
        id: studyTourId,
        title: studyTourData.title,
        description: studyTourData.description,
        categoryName: studyTourData.category,
        estimatedDuration: _getEstimatedDuration(books.length),
        books: books,
      );
      print('✅ StudyTourDetailModel created successfully');

      print('📤 Emitting loaded state...');
      emit(StudyTourDetailState.loaded(studyTour));
      print('✅ StudyTourDetailState.loaded emitted successfully');
    } catch (e, stackTrace) {
      print('❌ Error in loadStudyTourDetail: $e');
      print('📋 Stack trace: $stackTrace');
      emit(StudyTourDetailState.error(l10n.errorLoadingStudyTourDetailsWithMessage(e.toString())));
    }
  }


  String _getEstimatedDuration(int bookCount) {
    if (bookCount <= 3) return l10n.twoMonths;
    if (bookCount <= 5) return l10n.fourMonths;
    if (bookCount <= 8) return l10n.sixMonths;
    return l10n.eightMonths;
  }
}
