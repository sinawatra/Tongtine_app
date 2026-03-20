import 'package:get/get.dart';
import 'package:homework_app/app/modules/home/repository/home_repository.dart';
import 'package:homework_app/app/modules/tontine_group/controllers/tontine_group_controller.dart';

class TontineGroupBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TontineGroupController>(
      () => TontineGroupController(
        homeRepository: Get.find<HomeRepository>(),
      ),
    );
  }
}
