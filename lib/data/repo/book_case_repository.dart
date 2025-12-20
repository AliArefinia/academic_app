// 📁 lib/data/api/book_case/book_case_repository.dart

import 'package:academic/data/api/my_book_cases/model/my_book_case_model.dart';
import 'package:injectable/injectable.dart';

import 'package:dio/dio.dart';

import '../api/my_book_cases/book_case_api.dart';

@lazySingleton
class BookCaseRepository {
  final BookCaseApi _api;

  BookCaseRepository(this._api);

  Future<List<BookCase>> getBookCases() async {
    try {
      final response = await _api.getBookCases();

      if (response.status == 200) {
        return response.data;
      } else {
        throw Exception(response.message);
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 500) {
        // Handle server error gracefully
        return []; // Return empty list instead of throwing error
      }
      final message = e.response?.data['message']?.toString() ??
          e.message ??
          'Network error occurred.';
      throw Exception(message);
    } catch (e) {
      throw Exception('Unexpected error: ${e.toString()}');
    }
  }

  Future<BookCaseDetailResponse> getBooksForCase(int id) async {
    try {
      final response = await _api.getBooksForCase(id);
      return response;
    } on DioException catch (e) {
      final message = e.response?.data['message']?.toString() ?? e.message ?? 'Network error occurred.';
      throw Exception(message);
    } catch (e) {
      throw Exception('Unexpected error: ${e.toString()}');
    }
  }

  Future<void> createBookCase(String name) async {
    try {
      final response = await _api.createBookCase({'name': name});
      // Accept both 200 and 201 status codes as success
      if (response.status != 200 && response.status != 201) {
        throw Exception(response.message);
      }
    } on DioException catch (e) {
      final message = e.response?.data['message']?.toString() ?? e.message ?? 'Network error occurred.';
      throw Exception(message);
    } catch (e) {
      throw Exception('Unexpected error: ${e.toString()}');
    }
  }

  Future<void> addBookToCase(int caseId, int bookId) async {
    try {
      await _api.addBookToCase(caseId, bookId);
    } on DioException catch (e) {
      final message = e.response?.data['message']?.toString() ?? e.message ?? 'Network error occurred.';
      throw Exception(message);
    } catch (e) {
      throw Exception('Unexpected error: ${e.toString()}');
    }
  }

  Future<void> deleteBookCase(int id) async {
    try {
      final response = await _api.deleteBookCase(id);
      if (response.status != 200) {
        throw Exception(response.message);
      }
    } on DioException catch (e) {
      final message = e.response?.data['message']?.toString() ?? e.message ?? 'Network error occurred.';
      throw Exception(message);
    } catch (e) {
      throw Exception('Unexpected error: ${e.toString()}');
    }
  }
}