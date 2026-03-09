import 'dart:async';

import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;
import 'package:homework_app/app/data/service/secure_storage_service.dart';
import 'package:homework_app/app/modules/utils/constants/app_constants.dart';

class AuthInterceptor extends Interceptor {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    if (options.uri.toString().startsWith(AppConstants.chatBaseUrl)) {
      options.headers['Authorization'] = 'Bearer ${AppConstants.chatToken}';
    } else {
      final token = await SecureStorageService().getToken();
      if (token != null) {
        options.headers['Authorization'] = 'Bearer $token';
      } else {
        options.headers.remove('Authorization');
      }
    }
    options.extra['startTime'] = DateTime.now();
    handler.next(options);
  }
}

class LoggerInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    Get.log(' REQUEST: ${options.method} ${options.uri}');
    Get.log(' REQUEST BODY: ${options.data}');
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    final start = response.requestOptions.extra['startTime'] as DateTime?;
    final elapsed = start != null ? DateTime.now().difference(start) : Duration.zero;
    Get.log(' RESPONSE: ${response.statusCode} ${response.requestOptions.uri} in ${elapsed.inMilliseconds}ms');
    Get.log(' RESPONSE BODY: ${response.data} ${response.data['message']}');
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final start = err.requestOptions.extra['startTime'] as DateTime?;
    final elapsed = start != null ? DateTime.now().difference(start) : Duration.zero;
    Get.log(' ERROR: ${err.response?.statusCode ?? '-'} ${err.requestOptions.uri} in ${elapsed.inMilliseconds}ms');
    super.onError(err, handler);
  }
}

class TokenRefreshInterceptor extends Interceptor {
  final Dio dio;
  final SecureStorageService _secureStorage = SecureStorageService();
  bool _isRefreshing = false;
  final List<_RetryRequest> _retryQueue = [];

  TokenRefreshInterceptor(this.dio);

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode != 419) {
      return super.onError(err, handler);
    }
    // Prevent retrying the refresh endpoint itself (avoid infinite loop)
    if (err.requestOptions.path.contains(AppConstants.refreshtoken)) {
      return super.onError(err, handler);
    }

    if (_isRefreshing) {
      // Another request is already refreshing → queue this one
      _queueRequest(err.requestOptions, handler);
      return;
    }

    _isRefreshing = true;

    try {
      final newToken = await _refreshToken();
      if (newToken == null) {
        _isRefreshing = false;
        _rejectQueue(err);
        return handler.reject(err);
      }
      await _secureStorage.saveToken(newToken);
      dio.options.headers['Authorization'] = 'Bearer $newToken';
      _isRefreshing = false;
      _resolveQueue(newToken);
      // Retry the current request with new token
      final response = await _retryRequest(err.requestOptions, newToken);
      return handler.resolve(response);
    } catch (refreshError) {
      _isRefreshing = false;
      _rejectQueue(err);
      return handler.reject(err);
    }
  }
   void _queueRequest(RequestOptions options, ErrorInterceptorHandler handler) {
    _retryQueue.add(_RetryRequest(options: options, handler: handler));
  }

  void _resolveQueue(String newToken) {
    for (final retry in _retryQueue) {
      retry.options.headers['Authorization'] = 'Bearer $newToken';
      dio.fetch(retry.options).then(
        (response) => retry.handler.resolve(response),
        onError: (e) => retry.handler.reject(
          e is DioException
              ? e
              : DioException(requestOptions: retry.options, error: e),
        ),
      );
    }
    _retryQueue.clear();
  }

  void _rejectQueue(DioException error) {
    for (final retry in _retryQueue) {
      retry.handler.reject(error);
    }
    _retryQueue.clear();
  }

  Future<String?> _refreshToken() async {
    final refreshToken = await _secureStorage.getRefreshToken();
    if (refreshToken == null) return null;
    final refreshDio = Dio(BaseOptions(
      baseUrl: dio.options.baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
    ));
    final response = await refreshDio.post(
      AppConstants.refreshtoken,
      data: {'refreshToken': refreshToken},
    );
    final data = response.data;
    final body = data['data'] ?? data;
    final accessToken = body['accessToken'] as String?;
    final newRefreshToken = body['refreshToken'] as String?;
    if (newRefreshToken != null && newRefreshToken.isNotEmpty) {
      await _secureStorage.saveRefreshToken(newRefreshToken);
    }

    return accessToken;
  }


Future<Response> _retryRequest(
    RequestOptions options, String newToken) async {
    options.headers['Authorization'] = 'Bearer $newToken';
    return dio.fetch(options);
  }

}

class _RetryRequest {
  final RequestOptions options;
  final ErrorInterceptorHandler handler;
  _RetryRequest({required this.options, required this.handler});
}
