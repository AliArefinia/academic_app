import 'package:dio/dio.dart';
import 'package:academic/data/api/notes/notes_api.dart';
import 'package:academic/data/model/note.dart';

class NotesRepository {
  final NotesApi _notesApi;

  NotesRepository(this._notesApi);

  Future<void> createNote({
    required String excerpt,
    String? userNote,
    required int chapterId,
    required int bookId,
    required String bookName,
    required String bookImage,
    String? authorName,
    String? authorAvatar,
  }) async {
    // Only call API - no local storage or fake data creation
    final formData = FormData.fromMap({
      'book_id': bookId.toString(),
      'text': excerpt,
    });
    
    // Call API to create note
    final response = await _notesApi.addNoteRaw(chapterId, formData);
    
    // Check if API call was successful
    final status = response['status'];
    final message = response['message'];
    final responseData = response['data'];
    
    // If API returns success status, consider it successful even if data is empty
    if (status == 200 && message != null && message.toString().toLowerCase().contains('success')) {
      // API call was successful
      // Parse response - API might return note data or empty array
      Map<String, dynamic>? noteData;
      if (responseData is List && responseData.isNotEmpty) {
        noteData = responseData.first as Map<String, dynamic>?;
      } else if (responseData is Map<String, dynamic>) {
        noteData = responseData;
      }
      
      // If we have note data and user provided a note, update it
      if (noteData != null) {
        Note note = Note.fromJson(noteData);
        if (userNote != null && userNote.isNotEmpty && note.id > 0) {
          await _notesApi.updateNoteRaw(
            note.id,
            FormData.fromMap({'description': userNote}),
          );
        }
      } else if (userNote != null && userNote.isNotEmpty) {
        // If no note data returned but user provided a note, we can't update
        // This is acceptable - the note was created successfully
      }
      // Success - no exception needed
      return;
    }
    
    // If we reach here, API didn't return success status
    throw Exception(message?.toString() ?? 'خطا در ذخیره یادداشت');
    
    // Note: We don't enrich with product data here - it will be fetched when needed
    // All data comes from API only
  }

  Future<Note> updateNote({
    required int noteId,
    String? userNote,
  }) async {
    try {
      // API accepts description as FormData
      final formData = FormData.fromMap({
        if (userNote != null && userNote.isNotEmpty) 'description': userNote,
      });
      final response = await _notesApi.updateNoteRaw(noteId, formData);
      final data = response['data'] as Map<String, dynamic>;
      return Note.fromJson(data);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteNote(int noteId) async {
    try {
      await _notesApi.deleteNote(noteId);
    } catch (e) {
      rethrow;
    }
  }
}
