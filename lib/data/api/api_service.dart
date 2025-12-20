import 'package:dio/dio.dart';
import 'package:academic/core/storage/local_storage.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../core/api_constants.dart';

class ApiClient {
  final Dio dio;
  final LocalStorage _localStorage;

  /// Initializes Dio with custom options and adds interceptors.
  ApiClient(this._localStorage)
      : dio = Dio(
          BaseOptions(
            baseUrl: ApiConstants.baseUrl,
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
            },
            connectTimeout: const Duration(seconds: 8),
            receiveTimeout: const Duration(seconds: 8),
          ),
        ) {
    dio.interceptors.addAll([
      ErrorInterceptor(_localStorage),
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        request: true,
        compact: true,
        maxWidth: 90,
      ),
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          _addTokenToHeader(options);
          return handler.next(options);
        },
        onResponse: (response, handler) {
          // Handle cases where API returns List instead of Map (PHP errors)
          if (response.data is List && response.requestOptions.path.contains('/api/pay/verify')) {
            // Convert List error response to proper error format
            final errorList = response.data as List;
            final errorMessage = errorList.isNotEmpty ? errorList.first.toString() : 'خطای نامشخص';
            // Convert to proper error response format
            response.data = {
              'status': 500,
              'message': errorMessage,
              'code': 500,
            };
          }
          
          // Store response data for potential error logging
          if (response.data is Map<String, dynamic>) {
            response.requestOptions.extra['response_data'] = response.data;
          }
          return handler.next(response);
        },
        onError: (error, handler) async {
          if (error.response?.statusCode == 401) {
            await _handleUnauthorizedError();
          }
          return handler.next(error);
        },
      ),
    ]);
  }

  void _addTokenToHeader(RequestOptions options) {
    final token = _localStorage.getToken();
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
  }

  Future<void> _handleUnauthorizedError() async {
    await _localStorage.clearUser();
    // TODO: Navigate to login page or show login dialog
  }

  /// Provides the Dio instance for network calls.
  Dio get dioInstance => dio;
}

/// Interceptor to handle 401 errors and refresh the token automatically.
class ErrorInterceptor extends Interceptor {
  final LocalStorage _localStorage;
  bool _isRefreshing = false;

  ErrorInterceptor(this._localStorage);

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401 && !_isRefreshing) {
      _isRefreshing = true;
      try {
        await _localStorage.clearUser();
        _isRefreshing = false;
        return handler.next(err);
      } catch (e) {
        _isRefreshing = false;
        return handler.next(err);
      }
    }
    return handler.next(err);
  }
}
