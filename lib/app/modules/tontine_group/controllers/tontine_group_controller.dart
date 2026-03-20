import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homework_app/app/modules/home/repository/home_repository.dart';

class TontineGroupController extends GetxController {
  final HomeRepository homeRepository;
  TontineGroupController({required this.homeRepository});

  RxList tontineGroups = <dynamic>[].obs;
  RxList groupMembers = <dynamic>[].obs;
  RxMap groupInfo = <String, dynamic>{}.obs;
  RxBool isLoading = false.obs;
  RxBool isMemberLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    getTontineGroups();
    
    // Check if we have arguments (groupId) passed to this controller
    if (Get.arguments != null && Get.arguments is String) {
      getGroupDetails(Get.arguments);
    }
  }

  Future<void> getTontineGroups() async {
    try {
      isLoading.value = true;
      final response = await homeRepository.getTontineGroup();
      tontineGroups.assignAll(response.body);
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getGroupDetails(String groupID) async {
    if (groupID.isEmpty) return;
    try {
      isLoading.value = true;
      final response = await homeRepository.getGroupInfoById(groupID);
      if (response.body is List && (response.body as List).isNotEmpty) {
        groupInfo.value = response.body[0]["group"] ?? response.body[0];
      } else if (response.body is Map) {
        groupInfo.value = response.body["group"] ?? response.body;
      }
      getGroupMemberByGroupID(groupID);
    } catch (e) {
      debugPrint("Error loading group details: $e");
      // Use postFrameCallback to avoid LateInitializationError with snackbars
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Get.snackbar("Error", "Failed to load group details");
      });
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getGroupMemberByGroupID(String groupID) async {
    try {
      isMemberLoading.value = true;
      final response = await homeRepository.getGroupMemberByGroupID(groupID);
      if (response.body is List) {
        groupMembers.assignAll(response.body);
      }
    } catch (e) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Get.snackbar("Error", "Failed to load members");
      });
    } finally {
      isMemberLoading.value = false;
    }
  }

  Future<void> joinGroup(String groupID) async {
    try {
      isLoading.value = true;
      await homeRepository.joinGroup(groupID);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Get.snackbar("Success", "You have joined the group");
      });
      getGroupDetails(groupID); // Refresh details and members
    } catch (e) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Get.snackbar("Error", e.toString());
      });
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> triggerPayoutForTheGroup(String groupID, String amount) async {
    try {
      isLoading.value = true;
      await homeRepository.triggerPayoutForTheGroup(groupID, amount);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Get.snackbar("Success", "Payout triggered for the group");
      });
      getGroupDetails(groupID); // Refresh to see updated status/info
    } catch (e) {
      debugPrint("Error triggering payout: $e");
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Get.snackbar("Error", e.toString());
      });
    } finally {
      isLoading.value = false;
    }
  }

  void onSearch(String query) {
    if (query.isEmpty) {
      getTontineGroups();
      return;
    }
    final filtered = tontineGroups.where((group) => 
      group["groupName"].toString().toLowerCase().contains(query.toLowerCase())
    ).toList();
    tontineGroups.assignAll(filtered);
  }
}
