import 'dart:developer' as developer;
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

/// Comprehensive JSON parsing error handler with detailed logging
class JsonParsingErrorHandler {
  static const String _tag = '🔥 JSON_PARSING_ERROR';
  
  /// Handles JSON parsing errors with detailed logging and context
  static T handleParsingError<T>({
    required String modelName,
    required Map<String, dynamic>? json,
    required T Function() parseFunction,
    String? endpoint,
    RequestOptions? requestOptions,
  }) {
    try {
      return parseFunction();
    } catch (error, stackTrace) {
      _logDetailedError(
        modelName: modelName,
        json: json,
        error: error,
        stackTrace: stackTrace,
        endpoint: endpoint,
        requestOptions: requestOptions,
      );
      rethrow;
    }
  }

  /// Logs detailed error information for debugging
  static void _logDetailedError({
    required String modelName,
    required Map<String, dynamic>? json,
    required Object error,
    required StackTrace stackTrace,
    String? endpoint,
    RequestOptions? requestOptions,
  }) {
    final timestamp = DateTime.now().toIso8601String();
    
    // Create detailed error report
    final errorReport = StringBuffer();
    errorReport.writeln('$_tag ═══════════════════════════════════════');
    errorReport.writeln('⏰ Timestamp: $timestamp');
    errorReport.writeln('🏷️  Model: $modelName');
    errorReport.writeln('🌐 Endpoint: ${endpoint ?? requestOptions?.path ?? 'Unknown'}');
    errorReport.writeln('📊 HTTP Method: ${requestOptions?.method ?? 'Unknown'}');
    errorReport.writeln('💥 Error Type: ${error.runtimeType}');
    errorReport.writeln('📝 Error Message: $error');
    errorReport.writeln('');
    
    // Add JSON data analysis
    if (json != null) {
      errorReport.writeln('📋 JSON Analysis:');
      errorReport.writeln('   • Keys count: ${json.keys.length}');
      errorReport.writeln('   • Keys: ${json.keys.toList()}');
      
      // Check for common issues
      _analyzeJsonIssues(json, errorReport);
      
      // Show JSON structure (truncated for large objects)
      final jsonString = json.toString();
      if (jsonString.length > 1000) {
        errorReport.writeln('   • JSON (truncated): ${jsonString.substring(0, 1000)}...');
      } else {
        errorReport.writeln('   • JSON: $jsonString');
      }
    } else {
      errorReport.writeln('📋 JSON: null or empty');
    }
    
    errorReport.writeln('');
    errorReport.writeln('📍 Stack Trace:');
    
    // Format stack trace for better readability
    final stackLines = stackTrace.toString().split('\n');
    for (int i = 0; i < stackLines.length && i < 15; i++) {
      final line = stackLines[i].trim();
      if (line.isNotEmpty) {
        errorReport.writeln('   ${i.toString().padLeft(2, '0')}: $line');
      }
    }
    
    if (stackLines.length > 15) {
      errorReport.writeln('   ... (${stackLines.length - 15} more lines)');
    }
    
    errorReport.writeln('═══════════════════════════════════════════════════');

    // Log using different methods based on build mode
    if (kDebugMode) {
      // In debug mode, use developer.log for better formatting
      developer.log(
        errorReport.toString(),
        name: 'JsonParsingError',
        error: error,
        stackTrace: stackTrace,
      );
      
      // Also print to console for immediate visibility
      print(errorReport.toString());
    } else {
      // In release mode, use print (could be replaced with crash reporting)
      print(errorReport.toString());
    }
  }

  /// Analyzes JSON for common parsing issues
  static void _analyzeJsonIssues(Map<String, dynamic> json, StringBuffer report) {
    final issues = <String>[];
    
    // Check for null values in required fields
    json.forEach((key, value) {
      if (value == null) {
        issues.add('Null value for key: $key');
      } else if (value is String && value.isEmpty) {
        issues.add('Empty string for key: $key');
      } else if (value is List && value.isEmpty) {
        issues.add('Empty list for key: $key');
      } else if (value is Map && value.isEmpty) {
        issues.add('Empty map for key: $key');
      }
    });
    
    // Check for type mismatches (common issues)
    json.forEach((key, value) {
      if (value is String) {
        // Check if string looks like it should be a number
        if (RegExp(r'^\d+$').hasMatch(value)) {
          issues.add('String "$value" for key "$key" might should be int');
        } else if (RegExp(r'^\d+\.\d+$').hasMatch(value)) {
          issues.add('String "$value" for key "$key" might should be double');
        }
      }
    });
    
    if (issues.isNotEmpty) {
      report.writeln('   • Potential Issues:');
      for (final issue in issues) {
        report.writeln('     - $issue');
      }
    } else {
      report.writeln('   • No obvious issues detected');
    }
  }
}

/// CustomParseErrorLogger implementation for Retrofit generated code
class CustomParseErrorLogger {
  /// Logs parsing errors from Retrofit generated API calls
  void logError(Object error, StackTrace stackTrace, RequestOptions options) {
    JsonParsingErrorHandler._logDetailedError(
      modelName: 'API Response',
      json: options.extra['response_data'] as Map<String, dynamic>?,
      error: error,
      stackTrace: stackTrace,
      endpoint: options.path,
      requestOptions: options,
    );
  }
}

/// Extension to add error handling to any fromJson method
extension SafeJsonParsing on Map<String, dynamic> {
  /// Safely parse JSON with detailed error logging
  T safeFromJson<T>(
    String modelName,
    T Function(Map<String, dynamic>) fromJsonFunction, {
    String? endpoint,
  }) {
    return JsonParsingErrorHandler.handleParsingError<T>(
      modelName: modelName,
      json: this,
      parseFunction: () => fromJsonFunction(this),
      endpoint: endpoint,
    );
  }
}
