import 'package:get/get.dart';
import 'package:homework_app/app/modules/notification/controller/notification_controller.dart';
import 'package:homework_app/app/modules/notification/repository/notification_repository.dart';

class NotificationBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NotificationRepository>(() => NotificationRepository(dioClient: Get.find()));
    Get.lazyPut<NotificationController>(() => NotificationController(notificationRepository: Get.find()));
  }
}
