import 'package:get/get.dart';
import 'package:homework_app/app/modules/home/repository/home_repository.dart';

class HomeController extends GetxController {
  final HomeRepository homeRepository;
  HomeController({required this.homeRepository});
  //TODO: Implement HomeController

  final count = 0.obs;

  RxList tontineGroup = <dynamic>[].obs;
  RxMap overView = <String, dynamic>{}.obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    getTontineGroup();
    getOverView();
  }



  void increment() => count.value++;


  Future<void> getTontineGroup() async {
    try {
      final response = await homeRepository.getTontineGroup();
      tontineGroup.value = response.body;
    } catch (e) {
      throw e.toString();
     }
    }

    Future<void> getOverView() async {
      try {
        isLoading.value = true;
      final response = await homeRepository.getOverView();
       if(response.success == true){
        overView.value = response.body;
        isLoading.value = false;
        }
      } catch (e) {
        isLoading.value = false;
        throw e.toString();
      }
    } 

    Future<void> createGroup (String groupName, int contributionAmount, int totalMembers, String imageUrl ) async {
      try {
        final response = await homeRepository.createGroup(groupName, contributionAmount, totalMembers, imageUrl);
        if(response.body["success"]){
          Get.snackbar("Success", "Group created successfully");
        }
      } catch (e) {
        throw e.toString();
       }
    }
}
