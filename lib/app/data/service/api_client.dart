import 'package:homework_app/app/data/service/base_response.dart';

abstract class ApiClient {
  Future<BaseResponse> get(String path, {Map<String, dynamic>? query});
  Future<BaseResponse> post(String path, {dynamic data});
  Future<BaseResponse> put(String path, {dynamic data});
  Future<BaseResponse> delete(String path);

  void setAuthToken(String token);
  void clearAuthToken();
}
