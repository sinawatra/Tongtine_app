
import 'package:get/get.dart';
import 'package:homework_app/app/modules/home/controllers/home_controller.dart';
import 'package:homework_app/app/modules/home/repository/home_repository.dart';
import 'package:homework_app/app/modules/profile/controller/profile_controller.dart';
import 'package:homework_app/app/modules/profile/repository/profile_repository.dart';

import '../controllers/appscreen_controller.dart';

class AppscreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AppscreenController>(
      () => AppscreenController(),
    );
    Get.lazyPut<ProfileRepository>(
      () => ProfileRepository(
        dioClient: Get.find(),
      ),
    );
    Get.lazyPut<HomeRepository>(
      () => HomeRepository(
        dioClient: Get.find(),
      ),
    );
    Get.lazyPut<HomeController>(() => HomeController(
      homeRepository: Get.find(),
    ));
    Get.lazyPut<ProfileController>(
      () => ProfileController(
        profileRepository: Get.find(),
      ),
    );
  
    
  }
}
