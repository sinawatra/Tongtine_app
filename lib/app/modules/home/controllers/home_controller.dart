import 'package:get/get.dart';
import 'package:homework_app/app/modules/home/repository/home_repository.dart';

class HomeController extends GetxController {
  final HomeRepository homeRepository;
  HomeController({required this.homeRepository});
  //TODO: Implement HomeController

  final count = 0.obs;

  RxList tontineGroup = <dynamic>[].obs;



  void increment() => count.value++;


  Future<void> getTontineGroup() async {
    try {
      final response = await homeRepository.getTontineGroup();
      tontineGroup.value = response.body["data"];
    } catch (e) {
      throw e.toString();
     }
      }
}
