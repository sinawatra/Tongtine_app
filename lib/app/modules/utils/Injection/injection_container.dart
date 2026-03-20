
import 'package:get/get.dart';
import 'package:homework_app/app/data/service/dio_client.dart';
import 'package:homework_app/app/data/service/translation_service.dart';
import 'package:homework_app/app/modules/authentication/controllers/authentication_controller.dart';

class InjectionContainer extends Bindings {
  @override
  void dependencies() {
    // Core services
    Get.lazyPut<DioClient>(() => DioClient(
      secureStorage: Get.find(),
    dio: Get.find(),));


    // Controllers
    Get.lazyPut<AuthenticationController>(() => AuthenticationController(
      authRepository: Get.find(),
      sharedPreferences: Get.find(),
      secureStorageService: Get.find(),
    ), fenix: true);
    Get.lazyPut<TranslationService>(() => TranslationService(), fenix: true);
  }
}
