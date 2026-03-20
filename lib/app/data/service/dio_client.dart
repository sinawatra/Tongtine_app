
import 'package:dio/dio.dart';
import 'package:homework_app/app/data/error/api_exception.dart';
import 'package:homework_app/app/data/service/api_client.dart';
import 'package:homework_app/app/data/service/base_response.dart';
import 'package:homework_app/app/data/service/interceptors.dart';
import 'package:homework_app/app/data/service/secure_storage_service.dart';
import 'package:homework_app/app/modules/utils/constants/app_constants.dart';

class DioClient implements ApiClient {
  final Dio dio;
  final SecureStorageService secureStorage;

  DioClient({required this.dio, required this.secureStorage}) {
    dio
      ..options.baseUrl = AppConstants.baseURLDev
      ..options.connectTimeout = const Duration(seconds: 30)
      ..options.receiveTimeout = const Duration(seconds: 30)
      ..interceptors.addAll([
        AuthInterceptor(),
        LoggerInterceptor(),
      ]);
  }

  @override
  void setAuthToken(String token) {
    dio.options.headers['Authorization'] = 'Bearer $token';
  }

  @override
  void clearAuthToken() {
    dio.options.headers.remove('Authorization');
  }

  @override
  Future<BaseResponse> get(String path, {Map<String, dynamic>? query}) async {
    try {
      final response = await dio.get(path, queryParameters: query);
      return BaseResponse.fromJson(response.data, (json) => json);
    } on DioException catch (e) {
      throw ApiException.handleError(e);
    }
  }

  @override
  Future<BaseResponse> patch(String path, {data}) async {
    try {
      final response = await dio.patch(path, data: data);
      return BaseResponse.fromJson(response.data, (json) => json);
    } on DioException catch (e) {
      throw ApiException.handleError(e);
    }
  }

  @override
  Future<BaseResponse> post(String path, {data}) async {
    try {
      final response = await dio.post(path, data: data);
      final baseResponse = BaseResponse.fromJson(response.data, (json) => json);
      return baseResponse;
    } on DioException catch (e) {
      throw ApiException.handleError(e);
    } catch (e) {
      throw ApiException(message: 'Unexpected error: $e');
    }
  }

  @override
  Future<BaseResponse> put(String path, {data}) async {
    try {
      final response = await dio.put(path, data: data);
      return BaseResponse.fromJson(response.data, (json) => json);
    } on DioException catch (e) {
      throw ApiException.handleError(e);
    }
  }

  @override
  Future<BaseResponse> delete(String path) async {
    try {
      final response = await dio.delete(path);
      return BaseResponse.fromJson(response.data, (json) => json);
    } on DioException catch (e) {
      throw ApiException.handleError(e);
    }
  }

  // Method for multipart file uploads
  Future<BaseResponse> postMultipart(String path, {Map<String, dynamic>? data}) async {
    try {
      final formData = FormData.fromMap(data ?? {});
      final response = await dio.post(path, data: formData);
      return BaseResponse.fromJson(response.data, (json) => json);
    } on DioException catch (e) {
      throw ApiException.handleError(e);
    }
  }

  Future<BaseResponse> putMultipart(String path, {Map<String, dynamic>? data}) async {
    try {
      final formData = FormData.fromMap(data ?? {});
      final response = await dio.put(path, data: formData);
      return BaseResponse.fromJson(response.data, (json) => json);
    } on DioException catch (e) {
      throw ApiException.handleError(e);
    }
  }
  
}
