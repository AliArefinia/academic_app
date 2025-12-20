import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:academic/data/api/home/model/reading_progress_model.dart';
import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:academic/data/api/product/model/product_model.dart';

class ReadingProgressService {
  static const String _progressKey = 'reading_progress';
  final SharedPreferences _prefs;

  ReadingProgressService(this._prefs);

  Future<void> saveProgress(ReadingProgressModel progress) async {
    try {
      debugPrint('[ReadingProgressService] Saving progress for book: ${progress.product.name}');
      debugPrint('[ReadingProgressService] Epub URL: ${progress.product.epub}');
      debugPrint('[ReadingProgressService] Sample Epub URL: ${progress.product.sampleEpub}');
      debugPrint('[ReadingProgressService] Last Position: ${progress.lastPosition}');

      final progressList = await getProgressList();
      final index = progressList.indexWhere((p) => p.product.id == progress.product.id);

      if (index != -1) {
        progressList[index] = progress;
      } else {
        progressList.add(progress);
      }

      final progressJson = progressList.map((p) => p.toJson()).toList();
      await _prefs.setString(_progressKey, jsonEncode(progressJson));
      
      debugPrint('[ReadingProgressService] Successfully saved progress for book: ${progress.product.name}');
      debugPrint('[ReadingProgressService] Saved lastPosition: ${progress.lastPosition}');
    } catch (e) {
      debugPrint('[ReadingProgressService] Error saving progress: $e');
    }
  }

  Future<List<ReadingProgressModel>> getProgressList() async {
    try {
      final jsonString = _prefs.getString(_progressKey);
      if (jsonString == null || jsonString.isEmpty) {
        return [];
      }
      
      final List<dynamic> jsonList = jsonDecode(jsonString);
      final List<ReadingProgressModel> progressList = [];
      
      for (var json in jsonList) {
        if (json == null) continue;
        
        try {
          if (json is Map<String, dynamic>) {
            // Validate required fields
            if (json['product'] == null || json['progress'] == null || json['lastPosition'] == null || json['lastReadAt'] == null) {
              continue;
            }

            final progress = ReadingProgressModel.fromJson(json);
            if (progress.product != null) {
              progressList.add(progress);
            }
          }
        } catch (e) {
          continue;
        }
      }
      
      return progressList;
    } catch (e) {
      // If there's an error parsing the stored data, clear it to prevent future errors
      await _prefs.remove(_progressKey);
      return [];
    }
  }

  Future<ReadingProgressModel?> getProgress(String bookId) async {
    final progressList = await getProgressList();
    return progressList.firstWhereOrNull((p) => p.product.id == bookId);
  }

  Future<void> clearProgress(String bookId) async {
    final progressList = await getProgressList();
    progressList.removeWhere((p) => p.product.id == bookId);
    
    final jsonList = progressList.map((p) => p.toJson()).toList();
    await _prefs.setString(_progressKey, jsonEncode(jsonList));
  }
} 