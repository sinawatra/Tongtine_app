import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:homework_app/app/routes/app_pages.dart';

import 'controllers/splash.controller.dart';

class SplashScreen extends GetView<SplashController> {
  const SplashScreen({super.key});

  afterSplash() async {
    await Future.delayed(const Duration(seconds: 2));
    Get.offNamed(Routes.AUTHENTICATION);
  }

  @override
  Widget build(BuildContext context) {
    afterSplash();
    return Scaffold(
      body: const Center(
        child: Text(
          'តុងទីន',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
