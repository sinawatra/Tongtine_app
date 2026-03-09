import 'package:dio/dio.dart';

class ApiException implements Exception {
  final String message;
  final int? statusCode;

  ApiException({required this.message, this.statusCode});

  @override
  String toString() => message;

  static ApiException handleError(dynamic e) => e is DioException ? _handleDioError(e) : ApiException(message: 'Unexpected Error: $e');

  static ApiException _handleDioError(DioException e) => switch (e.type) {
    DioExceptionType.connectionTimeout || DioExceptionType.sendTimeout || DioExceptionType.receiveTimeout => ApiException(message: 'Connection Timeout', statusCode: 408),
    DioExceptionType.badResponse => _handleBadResponse(e),
    DioExceptionType.cancel => ApiException(message: 'Request Cancelled'),
    DioExceptionType.connectionError => ApiException(message: 'Server Error'),
    _ => ApiException(message: 'Error: ${e.message}'),
  };

  static ApiException _handleBadResponse(DioException e) {
    final code = e.response?.statusCode ?? 500;
    final message = switch (code) {
      400 => _extractMessage(e),
      401 => 'Unauthorized: Please log in again',
      404 => 'Not Found: Resource does not exist',
      500 => 'Internal Server Error: Try again later',
      502 => 'Bad Gateway: Server error',
      _ => _extractMessage(e),
    };
    return ApiException(message: message, statusCode: code);
  }

  static String _extractMessage(DioException e) {
    final data = e.response?.data;
    if (data is! Map) return 'Invalid request';

    final message = data['message'] ?? 'Invalid request';

    // Extract validation errors if present
    final errors = data['errors'];
    if (errors is List && errors.isNotEmpty) {
      final errorMessages = errors.map((err) {
        if (err is Map) {
          return err['message'] ?? err['msg'] ?? err.toString();
        }
        return err.toString();
      }).join(', ');
      return '$message: $errorMessages';
    }

    return message;
  }
}
