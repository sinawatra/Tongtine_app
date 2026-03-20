import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homework_app/app/data/service/secure_storage_service.dart';
import 'package:homework_app/app/routes/app_pages.dart';

import 'controllers/splash.controller.dart';

class SplashScreen extends GetView<SplashController> {
  final SecureStorageService _secureStorageService = Get.find<SecureStorageService>();
  
   SplashScreen({super.key});

  afterSplash() async {
    await Future.delayed(const Duration(seconds: 2));
    _checkAuth();
  }

  _checkAuth() async {
  final hasToken = await _secureStorageService.hasValidToken();
  if (hasToken) {
    Get.offNamed(Routes.APPSCREEN);
  } else {
    Get.offNamed(Routes.AUTHENTICATION);
  }
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
