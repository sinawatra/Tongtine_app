
import 'package:homework_app/app/data/service/base_response.dart';
import 'package:homework_app/app/data/service/dio_client.dart';
import 'package:homework_app/app/data/service/secure_storage_service.dart';
import 'package:homework_app/app/modules/utils/constants/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepository {
  final DioClient dioClient;
  final SharedPreferences sharedPreferences;
  final SecureStorageService secureStorageService;

  AuthRepository({required this.dioClient, required this.sharedPreferences, required this.secureStorageService});

  Future<BaseResponse> registerUser(String fullName, String phone, String password) async{
    try {
      final response = await dioClient.post(
       AppConstants.register,
        data: {
          'fullName': fullName,
          'phone': phone,
          'password': password,
        },
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<BaseResponse> loginUser(String phone, String password) async{
    try {
      final response = await dioClient.post(
       AppConstants.login,
        data: {
          'phone': phone,
          'password': password,
        },
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }}