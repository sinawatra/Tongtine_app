import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homework_app/app/modules/notification/controller/notification_controller.dart';


class NotificationView extends GetView<NotificationController> {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notification".tr),
      ),
      body: Center(
        child: Text("NotificationView is working".tr),
      ),
    );
  }
}
