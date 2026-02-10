/// Constants for API configuration
class ApiConstants {
  static const String baseUrl = 'https://academic.halal-books.com';
  static const Duration connectTimeout = Duration(seconds: 5);
  static const Duration receiveTimeout = Duration(seconds: 5);
  static const Map<String, String> headers = {
    'Content-Type': 'application/json'
  };
}

class AppUrls {
  static const String phoneAuth = '/api/auth/phone';
  static const String verifyAuth = '/api/auth/phone/verify';
  static const String passwordAuth = '/api/auth/phone/password';
  static const String home = '/api/home';
  static const String reviews = '/api/reviews';
  static const String studyTourRequest = '/api/study-tour-requests/store';
  static const String myStudyTourRequests = '/api/my-study-tour-requests';
}
