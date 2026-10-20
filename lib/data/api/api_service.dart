import 'package:academic/l10n/l10n.dart';
import 'dart:io';

import 'package:academic/core/storage/local_storage.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../core/api_constants.dart';

/// **ناامن:** برای hostهای API گواهی TLS را بدون اعتبارسنجی کامل قبول می‌کند (ریسک MITM).
/// پیش‌فرض در همهٔ بیلدها روشن است. وقتی SSL سرور درست شد:
/// `--dart-define=BYPASS_TLS_VERIFY=false`
const bool kBypassTlsCertificateVerify = bool.fromEnvironment(
  'BYPASS_TLS_VERIFY',
  defaultValue: true,
);

Set<String> get _hostsAllowingInsecureCert {
  final u = Uri.parse(ApiConstants.baseUrl);
  return {u.host};
}

void _logDioExceptionDetails(DioException err) {
  if (!kDebugMode) return;

  final underlying = err.error;
  final b = StringBuffer()
    ..writeln('[Dio][detail] ═══ ${err.requestOptions.method} ${err.requestOptions.uri} ═══')
    ..writeln('[Dio][detail] type: ${err.type}')
    ..writeln('[Dio][detail] dio message: ${err.message}')
    ..writeln('[Dio][detail] underlying (${underlying?.runtimeType}): $underlying');

  if (underlying is SocketException) {
    b
      ..writeln('[Dio][detail] socket address: ${underlying.address}, port: ${underlying.port}')
      ..writeln('[Dio][detail] socket osError: ${underlying.osError}');
  }
  if (underlying is HandshakeException) {
    b.writeln('[Dio][detail] TLS handshake: ${underlying.message}');
  }
  if (underlying is TlsException) {
    b.writeln('[Dio][detail] TLS: ${underlying.message} (os: ${underlying.osError})');
  }
  if (underlying is HttpException) {
    b.writeln('[Dio][detail] HttpException: ${underlying.message}');
  }
  if (underlying is FormatException) {
    b.writeln('[Dio][detail] FormatException: ${underlying.message}');
  }

  final sc = err.response?.statusCode;
  if (sc != null) {
    b.writeln('[Dio][detail] response status: $sc');
  }
  if (err.response?.data != null) {
    b.writeln('[Dio][detail] response data (truncated): ${err.response!.data}');
  }
  b.writeln('[Dio][detail] stackTrace:\n${err.stackTrace}');

  debugPrint(b.toString());
}

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
    if (kBypassTlsCertificateVerify) {
      if (kDebugMode) {
        debugPrint(
          '[ApiClient] TLS cert verification BYPASSED for hosts '
          '${_hostsAllowingInsecureCert.join(", ")} (insecure)',
        );
      }
      dio.httpClientAdapter = IOHttpClientAdapter(
        createHttpClient: () {
          final client = HttpClient();
          final allowed = _hostsAllowingInsecureCert;
          client.badCertificateCallback =
              (X509Certificate cert, String host, int port) {
            return allowed.contains(host);
          };
          return client;
        },
      );
    }

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
          if (response.data is List &&
              response.requestOptions.path.contains('/api/pay/verify')) {
            final errorList = response.data as List;
            final errorMessage =
                errorList.isNotEmpty ? errorList.first.toString() : l10n.unknownError;
            response.data = {
              'status': 500,
              'message': errorMessage,
              'code': 500,
            };
          }

          if (response.data is Map<String, dynamic>) {
            response.requestOptions.extra['response_data'] = response.data;
          }
          return handler.next(response);
        },
        onError: (error, handler) async {
          _logDioExceptionDetails(error);
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
