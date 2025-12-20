import 'package:flutter/material.dart';
import 'package:academic/core/error/error_message_mapper.dart';
import 'package:academic/core/error/error_type.dart';

/// Helper class for displaying user-friendly error messages
class ErrorHelper {
  /// Detects the type of error
  static ErrorType detectErrorType(dynamic error) {
    return ErrorTypeDetector.detect(error);
  }
  /// Shows a user-friendly error message in a snack bar
  static void showErrorSnackBar(
    BuildContext context,
    dynamic error, {
    Duration duration = const Duration(seconds: 3),
    SnackBarAction? action,
  }) {
    if (!context.mounted) return;

    final userFriendlyMessage = ErrorMessageMapper.mapError(error);
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(userFriendlyMessage),
        backgroundColor: Theme.of(context).colorScheme.error,
        behavior: SnackBarBehavior.floating,
        duration: duration,
        action: action,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        margin: const EdgeInsets.all(8),
      ),
    );
  }

  /// Shows a user-friendly success message in a snack bar
  static void showSuccessSnackBar(
    BuildContext context,
    String message, {
    Duration duration = const Duration(seconds: 2),
    SnackBarAction? action,
  }) {
    if (!context.mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        duration: duration,
        action: action,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        margin: const EdgeInsets.all(8),
      ),
    );
  }

  /// Shows a user-friendly info message in a snack bar
  static void showInfoSnackBar(
    BuildContext context,
    String message, {
    Duration duration = const Duration(seconds: 2),
    SnackBarAction? action,
  }) {
    if (!context.mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Theme.of(context).colorScheme.primary,
        behavior: SnackBarBehavior.floating,
        duration: duration,
        action: action,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        margin: const EdgeInsets.all(8),
      ),
    );
  }

  /// Maps API error message to user-friendly message
  static String mapApiError(String? apiMessage) {
    return ErrorMessageMapper.mapApiError(apiMessage);
  }

  /// Maps any error to user-friendly message
  static String mapError(dynamic error) {
    return ErrorMessageMapper.mapError(error);
  }
}
