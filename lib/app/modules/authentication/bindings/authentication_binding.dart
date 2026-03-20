import 'package:get/get.dart';
import 'package:homework_app/app/data/service/dio_client.dart';
import 'package:homework_app/app/modules/authentication/repository/authentication_repository.dart';

import '../controllers/authentication_controller.dart';

class AuthenticationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthRepository>(
      () => AuthRepository(
        dioClient: Get.find<DioClient>(),
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
