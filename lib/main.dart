import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final sharedPreferences = await SharedPreferences.getInstance();
  Get.put(sharedPreferences);
  runApp(
    GetMaterialApp(
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      showPerformanceOverlay: false,
      fallbackLocale: Locale('en', 'US'),
      //  translations: AppTranslations(),R
      // builder: (BuildContext context, Widget? child) {
      //     return EasyLoading.init()(
      //       context,
      //       Stack(
      //         children: [
      //           child!,
      //           // const NoInternetOverlay(),
      //         ],
      //       ),
      //     );
      //   }
    ),
  );
}
