
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:homework_app/app/data/service/translation_service.dart';
import 'package:homework_app/app/modules/authentication/controllers/authentication_controller.dart';

class InjectionContainer extends Bindings {
  @override
  void dependencies() {
    // Core services
    Get.lazyPut<Dio>(() => Dio(), fenix: true);


    // Controllers
    Get.lazyPut<AuthenticationController>(() => AuthenticationController(), fenix: true);
    Get.lazyPut<TranslationService>(() => TranslationService(), fenix: true);
  }
}
