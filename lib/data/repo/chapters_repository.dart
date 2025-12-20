import 'dart:io';
import 'package:dio/dio.dart';
import 'package:academic/data/api/headlines/headlines_api.dart';
import 'package:academic/data/model/chapter.dart';
import 'package:academic/data/model/note.dart';
import 'package:academic/data/repository/product_repository.dart';
import 'package:academic/core/helper/image_ur_handler.dart';

class ChaptersRepository {
  final HeadlinesApi _headlinesApi;
  final IProductRepository _productRepository;

  ChaptersRepository(this._headlinesApi, this._productRepository);

  Future<List<Chapter>> getMyChapters() async {
    try {
      final response = await _headlinesApi.getMyHeadlines();
      final data = response['data'] as Map<String, dynamic>;
      final list = data['list'] as List<dynamic>? ?? [];
      return list.map((item) {
        final itemMap = item as Map<String, dynamic>;
        // Extract user_id from user object if not present
        if (!itemMap.containsKey('user_id') && itemMap['user'] != null) {
          final user = itemMap['user'] as Map<String, dynamic>;
          itemMap['user_id'] = user['id'];
        }
        return Chapter.fromJson(itemMap);
      }).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Chapter>> getAllChapters() async {
    try {
      final response = await _headlinesApi.getAllHeadlines();
      final data = response['data'] as Map<String, dynamic>;
      final list = data['list'] as List<dynamic>? ?? [];
      return list.map((item) {
        final itemMap = item as Map<String, dynamic>;
        // Extract user_id from user object if not present
        if (!itemMap.containsKey('user_id') && itemMap['user'] != null) {
          final user = itemMap['user'] as Map<String, dynamic>;
          itemMap['user_id'] = user['id'];
        }
        return Chapter.fromJson(itemMap);
      }).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<Chapter> getChapterById(int id) async {
    try {
      final response = await _headlinesApi.getHeadlineByIdRaw(id);
      final responseData = response['data'] as Map<String, dynamic>;
      // API might return data directly or wrapped in another object
      final chapterData = responseData['list'] != null 
          ? (responseData['list'] as List<dynamic>).first as Map<String, dynamic>
          : responseData;
      return Chapter.fromJson(chapterData);
    } catch (e) {
      // Re-throw to let the cubit handle the error appropriately
      rethrow;
    }
  }

  Future<List<Note>> getChapterNotes(int chapterId) async {
    try {
      final response = await _headlinesApi.getHeadlineByIdRaw(chapterId);
      final responseData = response['data'] as Map<String, dynamic>;
      // API might return notes in 'notes' field
      final notesData = responseData['notes'] as List<dynamic>?;
      if (notesData == null) return [];
      
      final notes = <Note>[];
      for (final item in notesData) {
        final itemMap = item as Map<String, dynamic>;
        // Extract book_id from book object if present, or try to get from note
        int? bookId;
        if (itemMap.containsKey('book_id')) {
          bookId = itemMap['book_id'] as int?;
        } else if (itemMap['book'] != null) {
          final book = itemMap['book'] as Map<String, dynamic>;
          bookId = book['id'] as int?;
        }
        
        // Set chapterId from parameter
        itemMap['user_headline_id'] = chapterId;
        // If name exists but text doesn't, use name as excerpt
        if (itemMap['text'] == null && itemMap['name'] != null) {
          itemMap['text'] = itemMap['name'];
        }
        
        Note note = Note.fromJson(itemMap);
        
        // If book is null or incomplete, fetch from product repository
        if ((note.book == null || note.bookName.isEmpty) && bookId != null) {
          try {
            final product = await _productRepository.getProduct(bookId);
            note = note.copyWith(
              bookId: bookId,
              book: NoteBook(
                id: bookId,
                name: product.name ?? '',
                image: buildImageUrl(product.image) ?? '',
                author: product.author != null
                    ? NoteAuthor(
                        id: int.tryParse(product.author!.id ?? '0') ?? 0,
                        name: product.author!.name,
                        avatar: null,
                      )
                    : null,
              ),
            );
          } catch (_) {
            // If product fetch fails, keep note as is
          }
        }
        
        notes.add(note);
      }
      
      return notes;
    } catch (e) {
      rethrow;
    }
  }

  Future<Chapter> createChapter({
    required String title,
    String? description,
    File? image,
    int? categoryId,
  }) async {
    try {
      final formData = FormData.fromMap({
        'title': title,
        if (description != null && description.isNotEmpty) 'description': description,
        if (categoryId != null) 'category_id': categoryId.toString(),
        if (image != null)
          'image': await MultipartFile.fromFile(
            image.path,
            filename: image.path.split('/').last,
          ),
      });
      final response = await _headlinesApi.storeHeadlineRaw(formData);
      final responseData = response['data'] as Map<String, dynamic>;
      // API might return data directly or in 'list' field
      final chapterData = responseData['list'] != null 
          ? (responseData['list'] as List<dynamic>).first as Map<String, dynamic>
          : responseData;
      return Chapter.fromJson(chapterData);
    } catch (e) {
      rethrow;
    }
  }

  Future<Chapter> updateChapter({
    required int chapterId,
    String? description,
  }) async {
    try {
      final formData = FormData.fromMap({
        if (description != null) 'description': description,
      });
      final response = await _headlinesApi.updateHeadlineRaw(chapterId, formData);
      final responseData = response['data'] as Map<String, dynamic>;
      // API might return data directly or in 'list' field
      final chapterData = responseData['list'] != null 
          ? (responseData['list'] as List<dynamic>).first as Map<String, dynamic>
          : responseData;
      return Chapter.fromJson(chapterData);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteChapter(int chapterId) async {
    try {
      await _headlinesApi.deleteHeadline(chapterId);
    } catch (e) {
      rethrow;
    }
  }
}
