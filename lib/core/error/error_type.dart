/// Enum to categorize different types of errors
enum ErrorType {
  /// No internet connection
  network,
  
  /// Server error (5xx)
  server,
  
  /// Timeout error
  timeout,
  
  /// Not found (404)
  notFound,
  
  /// Unauthorized (401)
  unauthorized,
  
  /// Forbidden (403)
  forbidden,
  
  /// Validation error (422)
  validation,
  
  /// JSON parsing error
  parse,
  
  /// Generic/unknown error
  unknown,
}

/// Extension to detect error type from error message
extension ErrorTypeDetector on ErrorType {
  /// Detects the error type from an error message or exception
  static ErrorType detect(dynamic error) {
    if (error == null) return ErrorType.unknown;
    
    final errorString = error.toString().toLowerCase();
    
    // Network errors
    if (errorString.contains('socketexception') ||
        errorString.contains('failed host lookup') ||
        errorString.contains('network is unreachable') ||
        errorString.contains('no internet') ||
        errorString.contains('connection') && errorString.contains('error')) {
      return ErrorType.network;
    }
    
    // Timeout errors
    if (errorString.contains('timeout') ||
        errorString.contains('deadline exceeded')) {
      return ErrorType.timeout;
    }
    
    // Server errors
    if (errorString.contains('500') ||
        errorString.contains('502') ||
        errorString.contains('503') ||
        errorString.contains('504') ||
        errorString.contains('internal server error') ||
        errorString.contains('server error')) {
      return ErrorType.server;
    }
    
    // Not found
    if (errorString.contains('404') ||
        errorString.contains('not found')) {
      return ErrorType.notFound;
    }
    
    // Unauthorized
    if (errorString.contains('401') ||
        errorString.contains('unauthorized') ||
        errorString.contains('token expired') ||
        errorString.contains('invalid token')) {
      return ErrorType.unauthorized;
    }
    
    // Forbidden
    if (errorString.contains('403') ||
        errorString.contains('forbidden') ||
        errorString.contains('access denied')) {
      return ErrorType.forbidden;
    }
    
    // Validation
    if (errorString.contains('422') ||
        errorString.contains('validation') ||
        errorString.contains('invalid input')) {
      return ErrorType.validation;
    }
    
    // Parse errors
    if (errorString.contains('json') ||
        errorString.contains('parsing') ||
        errorString.contains('format') ||
        errorString.contains('unexpected character')) {
      return ErrorType.parse;
    }
    
    return ErrorType.unknown;
  }
  
  /// Returns an appropriate icon for the error type
  String get iconAsset {
    switch (this) {
      case ErrorType.network:
        return 'assets/ic_cloud.svg'; // Use existing cloud icon
      case ErrorType.server:
      case ErrorType.timeout:
        return 'assets/ic_cloud.svg';
      case ErrorType.notFound:
        return 'assets/ic_search.svg'; // Use existing search icon
      case ErrorType.unauthorized:
      case ErrorType.forbidden:
        return 'assets/ic_exit.svg'; // Use existing exit icon
      case ErrorType.validation:
      case ErrorType.parse:
      case ErrorType.unknown:
        return 'assets/ic_cloud.svg';
    }
  }
}

