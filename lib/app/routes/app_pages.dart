import 'package:get/get.dart';
import 'package:homework_app/app/modules/appscreen/binding/appscreen_binding.dart';
import 'package:homework_app/app/modules/appscreen/views/appscreen_view.dart';
import 'package:homework_app/app/modules/authentication/splash/splash.screen.dart';
import 'package:homework_app/app/modules/notification/binding%20/notification_binding.dart';
import 'package:homework_app/app/modules/notification/view/notification_view.dart';
import 'package:homework_app/app/modules/profile/binding/profile_binding.dart';
import 'package:homework_app/app/modules/profile/view/profile_view.dart';

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
      name: _Paths.NOTIFICATION,
      page: () => const NotificationView(),
      binding: NotificationBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH,
      page: () =>  SplashScreen(),
    ),
    GetPage(
      name: _Paths.AUTHENTICATION,
      page: () => const AuthenticationView(),
      binding: AuthenticationBinding(),
    ),
  ];
}
