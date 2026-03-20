import 'package:get/get.dart';
import 'package:homework_app/app/modules/home/repository/home_repository.dart';

class HomeController extends GetxController {
  final HomeRepository homeRepository;
  HomeController({required this.homeRepository});
  //TODO: Implement HomeController

  final count = 0.obs;



  void increment() => count.value++;
}
