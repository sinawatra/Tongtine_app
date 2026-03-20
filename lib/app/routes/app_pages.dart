import 'package:get/get.dart';
import 'package:homework_app/app/modules/appscreen/binding/appscreen_binding.dart';
import 'package:homework_app/app/modules/appscreen/views/appscreen_view.dart';
import 'package:homework_app/app/modules/authentication/splash/splash.screen.dart';

import '../modules/authentication/bindings/authentication_binding.dart';
import '../modules/authentication/views/authentication_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
      GetPage(
      name: _Paths.APPSCREEN,
      page: () => const AppscreenView(),
      binding: AppscreenBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashScreen(),
    ),
    GetPage(
      name: _Paths.AUTHENTICATION,
      page: () => const AuthenticationView(),
      binding: AuthenticationBinding(),
    ),
  ];
}
