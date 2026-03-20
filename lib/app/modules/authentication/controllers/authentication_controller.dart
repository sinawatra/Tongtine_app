import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homework_app/app/common/widgets/custom_loading_dialog.dart';
import 'package:homework_app/app/data/service/secure_storage_service.dart' show SecureStorageService;
import 'package:homework_app/app/modules/authentication/repository/authentication_repository.dart';
import 'package:homework_app/app/routes/app_pages.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationController extends GetxController {
  final AuthRepository authRepository;  
  final SharedPreferences sharedPreferences;
  final SecureStorageService secureStorageService;

  AuthenticationController({required this.authRepository, required this.sharedPreferences, required this.secureStorageService});

  //TODO: Implement AuthenticationController

  final bool _isTypingCompleted = false;

  bool get isTypingCompleted => _isTypingCompleted;


  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final count = 0.obs;


  Future<void> signIn() async {
    if (phoneController.text.isEmpty) {
      Get.snackbar("Error", "Please enter phone number");
      return;
    }
    if (passwordController.text.isEmpty) {
      Get.snackbar("Error", "Please enter password");
      return;
    }
      LoadingDialog.showDialog();
    final response = await authRepository.loginUser(phoneController.text, passwordController.text);
    if (response.success == true) {
      await secureStorageService.saveToken(response.body["token"] ?? '');
      Get.offAndToNamed(Routes.APPSCREEN);
      LoadingDialog.dismiss();
      return;
    }
    Get.snackbar("Error", response.message ?? '');
    LoadingDialog.dismiss();
  }


  void increment() => count.value++;
}
