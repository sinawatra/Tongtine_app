import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:homework_app/app/data/service/storage_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final sharedPreferences = await SharedPreferences.getInstance();
  Get.put(sharedPreferences);
  await StorageService.init();
  runApp(
    GetMaterialApp(
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      showPerformanceOverlay: false,
      debugShowCheckedModeBanner: false, // Fixed the typo here
      fallbackLocale: const Locale('en', 'US'),
      builder: (BuildContext context, Widget? child) {
        // 1. Initialize EasyLoading
        final easyLoadingBuilder = EasyLoading.init();

        // 2. Wrap child in the Stack for overlays
        return easyLoadingBuilder(
          context,
          Stack(
            children: [
              if (child != null) child,
              // const NoInternetOverlay(),
            ],
          ),
        );
      },
    ),
  );
  // runApp(
  //   GetMaterialApp(
  //     title: "Application",
  //     initialRoute: AppPages.INITIAL,
  //     getPages: AppPages.routes,
  //     showPerformanceOverlay: false,
  //     // debugShowChStileckedModeBanner: false,
  //     fallbackLocale: Locale('en', 'US'),
  //     //  translations: AppTranslations(),R
  //     builder: (BuildContext context, Widget? child) {
  //         return EasyLoading.init()(
  //           context,
  //           Stack(
  //             children: [
  //               child!,
  //               // const NoInternetOverlay(),
  //             ],
  //           ),
  //         );
  //       }
  //   ),
  // );
}
