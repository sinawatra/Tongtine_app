import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homework_app/app/common/style/style.dart';
import 'package:homework_app/app/modules/notification/controller/notification_controller.dart';


class NotificationView extends GetView<NotificationController> {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.white,
        title: Text("ការជូនដំណឹង".tr, style: localizedTextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
      ),
      body: Center(
        child: Text("មិនមានការជូនដំណឹងទេ".tr, style: localizedTextStyle(fontSize: 16, fontWeight: FontWeight.normal),),
      ),
    );
  }
}
