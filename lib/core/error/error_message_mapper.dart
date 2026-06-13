import 'package:dio/dio.dart';

String _dioUnknownRootMessage(DioException error) {
  final parts = <String>[
    if (error.message != null && error.message!.trim().isNotEmpty) error.message!.trim(),
    if (error.error != null) error.error.toString().trim(),
  ];
  return parts.join(' — ');
}

/// Maps technical error messages to user-friendly Persian messages
class ErrorMessageMapper {
  static const String _defaultErrorMessage = 'مشکلی پیش آمده است. لطفا دوباره تلاش کنید';
  static const String _networkErrorMessage = 'اتصال اینترنت برقرار نیست';
  static const String _serverErrorMessage = 'مشکلی در سرور پیش آمده است. لطفا دوباره تلاش کنید';
  static const String _timeoutErrorMessage = 'زمان اتصال به پایان رسید. لطفا دوباره تلاش کنید';
  static const String _unauthorizedErrorMessage = 'لطفا دوباره وارد شوید';
  static const String _forbiddenErrorMessage = 'دسترسی غیرمجاز';
  static const String _notFoundErrorMessage = 'اطلاعات مورد نظر یافت نشد';
  static const String _validationErrorMessage = 'اطلاعات وارد شده نامعتبر است';
  static const String _serverUnavailableErrorMessage = 'سرویس در دسترس نیست. لطفا بعدا تلاش کنید';

  /// Maps any error to a user-friendly message
  static String mapError(dynamic error) {
    if (error == null) return _defaultErrorMessage;

    // Handle DioException (most common)
    if (error is DioException) {
      return _mapDioException(error);
    }

    // Handle String errors
    if (error is String) {
      return _mapStringError(error);
    }

    // Handle other exceptions
    return _mapGenericError(error);
  }

  /// Maps DioException to user-friendly messages
  static String _mapDioException(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return _timeoutErrorMessage;

      case DioExceptionType.connectionError:
        return _networkErrorMessage;

      case DioExceptionType.badResponse:
        return _mapDioBadResponse(error);

      case DioExceptionType.cancel:
        return 'عملیات لغو شد';

      case DioExceptionType.unknown:
        final combined = _dioUnknownRootMessage(error);
        if (combined.isEmpty) return _defaultErrorMessage;
        return _mapStringError(combined);

      default:
        return _defaultErrorMessage;
    }
  }

  /// Maps Dio bad response to user-friendly messages
  static String _mapDioBadResponse(DioException error) {
    final statusCode = error.response?.statusCode;
    final responseData = error.response?.data;
    
    // Handle validation errors (422) with specific field messages
    if (statusCode == 422 && responseData is Map<String, dynamic>) {
      // Check for phone field validation error
      if (responseData.containsKey('phone') && responseData['phone'] is List) {
        final phoneErrors = responseData['phone'] as List;
        if (phoneErrors.isNotEmpty) {
          return phoneErrors.first.toString();
        }
      }
      
      // Check for other field validation errors
      for (final entry in responseData.entries) {
        if (entry.value is List && (entry.value as List).isNotEmpty) {
          return (entry.value as List).first.toString();
        }
      }
    }
    
    // Handle specific error messages in response body
    if (responseData is Map<String, dynamic>) {
      // Check for error field
      if (responseData.containsKey('error')) {
        final errorMessage = responseData['error'].toString();
        return mapApiError(errorMessage);
      }
      
      // Check for message field
      if (responseData.containsKey('message')) {
        final message = responseData['message'].toString();
        return mapApiError(message);
      }
    }
    
    // If no specific field errors found, return generic message for 422
    if (statusCode == 422) {
      return 'اطلاعات وارد شده نامعتبر است';
    }
    
    return _mapHttpStatusCode(statusCode);
  }

  /// Maps HTTP status codes to user-friendly messages
  static String _mapHttpStatusCode(int? statusCode) {
    switch (statusCode) {
      case 400:
        return 'اطلاعات ارسالی نامعتبر است. لطفا دوباره تلاش کنید';
      case 401:
        return _unauthorizedErrorMessage;
      case 403:
        return _forbiddenErrorMessage;
      case 404:
        return _notFoundErrorMessage;
      case 422:
        return _validationErrorMessage;
      case 413:
        return 'حجم فایل بسیار بزرگ است';
      case 415:
        return 'فرمت فایل پشتیبانی نمی‌شود';
      case 429:
        return 'تعداد درخواست‌ها بیش از حد مجاز است. لطفا کمی صبر کنید';
      case 500:
        return _serverErrorMessage;
      case 502:
      case 503:
      case 504:
        return _serverUnavailableErrorMessage;
      default:
        return _defaultErrorMessage;
    }
  }

  /// Maps string errors to user-friendly messages
  static String _mapStringError(String error) {
    final lowerError = error.toLowerCase();

    // Network related errors
    if (lowerError.contains('socketexception') ||
        lowerError.contains('failed host lookup') ||
        lowerError.contains('network is unreachable') ||
        lowerError.contains('no internet connection')) {
      return _networkErrorMessage;
    }

    // Timeout errors
    if (lowerError.contains('timeout') ||
        lowerError.contains('deadline exceeded')) {
      return _timeoutErrorMessage;
    }

    // Server errors
    if (lowerError.contains('500') ||
        lowerError.contains('internal server error') ||
        lowerError.contains('server error')) {
      return _serverErrorMessage;
    }

    // Authentication errors
    if (lowerError.contains('401') ||
        lowerError.contains('unauthorized') ||
        lowerError.contains('token expired') ||
        lowerError.contains('invalid token')) {
      return _unauthorizedErrorMessage;
    }

    // Validation errors
    if (lowerError.contains('422') ||
        lowerError.contains('validation') ||
        lowerError.contains('invalid input') ||
        lowerError.contains('required field')) {
      return _validationErrorMessage;
    }

    // Not found errors
    if (lowerError.contains('404') ||
        lowerError.contains('not found')) {
      return _notFoundErrorMessage;
    }

    // Forbidden errors
    if (lowerError.contains('403') ||
        lowerError.contains('forbidden') ||
        lowerError.contains('access denied')) {
      return _forbiddenErrorMessage;
    }

    // JSON parsing errors
    if (lowerError.contains('json') ||
        lowerError.contains('parsing') ||
        lowerError.contains('format')) {
      return 'خطا در پردازش اطلاعات';
    }

    // Return original error if no pattern matches
    return error;
  }

  /// Maps generic errors to user-friendly messages
  static String _mapGenericError(dynamic error) {
    final errorString = error.toString().toLowerCase();

    if (errorString.contains('exception') ||
        errorString.contains('error')) {
      return _defaultErrorMessage;
    }

    return _defaultErrorMessage;
  }

  /// Maps specific API error messages to user-friendly messages
  static String mapApiError(String? apiMessage) {
    if (apiMessage == null || apiMessage.isEmpty) {
      return _defaultErrorMessage;
    }

    final lowerMessage = apiMessage.toLowerCase();

    // Common API error patterns
    if (lowerMessage.contains('invalid credentials') ||
        lowerMessage.contains('wrong password') ||
        lowerMessage.contains('incorrect password')) {
      return 'رمز عبور یا شماره همراه اشتباه است';
    }

    if (lowerMessage.contains('user not found') ||
        lowerMessage.contains('user does not exist')) {
      return 'کاربری با این اطلاعات یافت نشد';
    }

    if (lowerMessage.contains('phone number') ||
        lowerMessage.contains('mobile number')) {
      return 'شماره همراه نامعتبر است';
    }

    if (lowerMessage.contains('verification code') ||
        lowerMessage.contains('otp') ||
        lowerMessage.contains('invalid otp')) {
      return 'کد تایید اشتباه است. لطفا کد صحیح را وارد کنید';
    }

    if (lowerMessage.contains('expired') ||
        lowerMessage.contains('expire')) {
      return 'کد تایید منقضی شده است. لطفا کد جدید درخواست کنید';
    }

    if (lowerMessage.contains('wrong') ||
        lowerMessage.contains('incorrect') ||
        lowerMessage.contains('invalid')) {
      return 'اطلاعات وارد شده اشتباه است';
    }

    if (lowerMessage.contains('already exists') ||
        lowerMessage.contains('duplicate')) {
      return 'این اطلاعات قبلا ثبت شده است';
    }

    if (lowerMessage.contains('insufficient') ||
        lowerMessage.contains('not enough')) {
      return 'موجودی کافی نیست';
    }

    if (lowerMessage.contains('payment') ||
        lowerMessage.contains('transaction')) {
      return 'خطا در پردازش پرداخت';
    }

    // Backend technical errors - convert to user-friendly messages
    if (lowerMessage.contains('call to undefined method') ||
        lowerMessage.contains('undefined method') ||
        lowerMessage.contains('method not found') ||
        lowerMessage.contains('fatal error') ||
        lowerMessage.contains('syntax error') ||
        lowerMessage.contains('parse error')) {
      return 'مشکلی در سرور پیش آمده است. لطفا بعدا تلاش کنید';
    }

    // Return the original message if no pattern matches
    return apiMessage;
  }
}
