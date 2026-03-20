import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homework_app/app/common/style/style.dart';
import 'package:homework_app/app/modules/home/components/custom_card.dart';
import 'package:homework_app/app/modules/utils/constants/colors.dart';
import 'package:homework_app/app/routes/app_pages.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../controllers/tontine_group_controller.dart';

class TontineGroupView extends GetView<TontineGroupController> {
  const TontineGroupView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "activeGroups".tr,
          style: localizedTextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: AppColor.contentDefault,
          ),
        ),
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, size: 20),
          onPressed: () => Get.back(),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onChanged: controller.onSearch,
              decoration: InputDecoration(
                hintText: "Search group...",
                prefixIcon: const Icon(Icons.search, color: AppColor.contentDim),
                filled: true,
                fillColor: AppColor.backgroundAlt,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
            ),
          ),
          Expanded(
            child: Obx(() => Skeletonizer(
                  enabled: controller.isLoading.value,
                  child: controller.tontineGroups.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.group_off_outlined,
                                size: 64,
                                color: AppColor.contentPlaceholder,
                              ),
                              const SizedBox(height: 16),
                              Text(
                                "noGroupsFound".tr,
                                style: localizedTextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: AppColor.contentDim,
                                ),
                              ),
                            ],
                          ),
                        )
                      : ListView.separated(
                          padding: const EdgeInsets.all(16.0),
                          itemCount: controller.tontineGroups.length,
                          separatorBuilder: (context, index) => const SizedBox(height: 16),
                          itemBuilder: (context, index) {
                            final group = controller.tontineGroups[index];
                            return TontineCard(
                              groupId: group["id"] ?? group["_id"],
                              groupName: group["groupName"],
                              startDate: group["startDate"],
                              totalMembers: group["totalMembers"],
                              contributionAmount: (group["contributionAmount"] as num).toDouble(),
                              status: group["status"],
                              imageUrl: group["imageUrl"],
                              onTap: () => Get.toNamed(Routes.GROUP_DETAILS, arguments: group["id"] ?? group["_id"]),
                            );
                          },
                        ),
                )),
          ),
        ],
      ),
    );
  }
}
