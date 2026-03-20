import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:homework_app/app/data/service/dio_client.dart';
import 'package:homework_app/app/data/service/secure_storage_service.dart';
import 'package:homework_app/app/modules/authentication/repository/authentication_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controllers/authentication_controller.dart';

class AuthenticationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Dio>(() => Dio(), fenix: true);
    Get.lazyPut<SecureStorageService>(() => SecureStorageService());
    Get.lazyPut<DioClient>(() => DioClient(secureStorage: Get.find(),dio: Get.find(),));
    Get.lazyPut<AuthRepository>(
      () => AuthRepository(
        dioClient: Get.find(),
        sharedPreferences: Get.find(),
        secureStorageService: Get.find(),
      ),
    );
    Get.lazyPut<AuthenticationController>(
      () => AuthenticationController(
        authRepository: Get.find(),
        sharedPreferences: Get.find(),
        secureStorageService: Get.find(),
      ),
    );
  }
}
