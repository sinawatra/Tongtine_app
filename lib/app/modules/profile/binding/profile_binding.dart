import 'package:get/get.dart';
import 'package:homework_app/app/data/service/secure_storage_service.dart';
import 'package:homework_app/app/modules/profile/controller/profile_controller.dart';
import 'package:homework_app/app/modules/profile/repository/profile_repository.dart';

class ProfileBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileRepository>(() => ProfileRepository(dioClient: Get.find()));
    Get.lazyPut<ProfileController>(() => ProfileController(
      profileRepository: Get.find(),
      secureStorageService: Get.find<SecureStorageService>(),
    ));
  }
}
