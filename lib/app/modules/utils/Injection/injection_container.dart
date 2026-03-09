import 'package:b_partner/app/data/network/dio_client.dart';
import 'package:b_partner/app/data/services/secure_storage_service.dart';
import 'package:b_partner/app/data/services/socket_service.dart';
import 'package:b_partner/app/modules/authentication/controllers/authentication_controller.dart';
import 'package:b_partner/app/modules/authentication/repository/auth_repository.dart';
import 'package:b_partner/app/data/services/translation_service.dart';
import 'package:b_partner/common/controller/permission_controller.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InjectionContainer extends Bindings {
  @override
  void dependencies() {
    // Core services
    Get.lazyPut<SocketService>(() => SocketService(), fenix: true);
    Get.lazyPut<SecureStorageService>(() => SecureStorageService(), fenix: true);
    Get.lazyPut<Dio>(() => Dio(), fenix: true);
    Get.lazyPut<DioClient>(
       () => DioClient(
        dio: Get.find<Dio>(),
        secureStorage: Get.find<SecureStorageService>(),
      ),
      fenix: true,
    );

    // Controllers
    Get.lazyPut<AuthenticationController>(
      () => AuthenticationController(
        authRepository: Get.find<AuthRepository>(),
        sharedPreferences: Get.find<SharedPreferences>(),
        secureStorageService: Get.find<SecureStorageService>(),
      ),
      fenix: true
    );
    Get.lazyPut<TranslationService>(() => TranslationService(), fenix: true);
    Get.lazyPut<PermissionController>(() => PermissionController(), fenix: true);
  }
}
