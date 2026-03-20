import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homework_app/app/common/style/style.dart';
import 'package:homework_app/app/modules/home/components/custom_card.dart';
import 'package:homework_app/app/modules/home/components/earning_summary_card.dart';
import 'package:homework_app/app/modules/utils/constants/colors.dart';
import 'package:homework_app/app/routes/app_pages.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        title: Text(
          'ទំព័រដើម',
          style: localizedTextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: AppColor.contentDefault,
          ),
        ),
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          // Blue "Graffiti/Mesh" Background
          Positioned.fill(
            child: Container(
              color: Colors.white,
            ),
          ),
          Positioned(
            top: 0,
            right: -50,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColor.alertDarkHover
              ),
            ),
          ),
         
          // Blur effect for graffiti feel
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
              child: Container(
                color: Colors.transparent,
              ),
            ),
          ),
          
          Obx(() => Skeletonizer(
            enabled: controller.isLoading.value,
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 100, 16, 16),
                    child: Column(
                      spacing: 12,
                      children: [
                    Row(
                      children: [
                        Expanded(
                          child: EarningSummaryCard(
                            title: "ចំនួនសមាជិកសរុប".tr,
                            backgroundColor: AppColor.infoLight,
                            amountText: controller.overView["totalUser"].toString(),
                            trailing: Icon(
                              Icons.people_alt_outlined,
                              size: 80,
                              color: AppColor.infoNormal.withOpacity(0.1),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: EarningSummaryCard(
                            title: "ចំនួនក្រុមតុងទីនសរុប".tr,
                            backgroundColor: AppColor.successLight,
                            amountText: controller.overView["totalGroup"].toString(),
                            trailing: Icon(
                              Icons.group_work_outlined,
                              size: 80,
                              color: AppColor.successNormal.withOpacity(0.1),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: EarningSummaryCard(
                            title: "ប្រាក់សរុបនៃក្រុមតុងទីន".tr,
                            backgroundColor: AppColor.warningLight,
                            amountText: "\$${controller.overView["totalMoney"].toString()}",
                            trailing: Icon(
                              Icons.monetization_on_outlined,
                              size: 80,
                              color: AppColor.warningNormal.withOpacity(0.1),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: EarningSummaryCard(
                            title: "ចំនួនការស្នើសុំKYC".tr,
                            backgroundColor: AppColor.alertLight,
                            amountText: controller.overView["totalPendingKyc"].toString(),
                            trailing: Icon(
                              Icons.how_to_reg_outlined,
                              size: 80,
                              color: AppColor.alertNormal.withOpacity(0.1),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "ក្រុមតុងទីន".tr,
                          style: localizedTextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColor.contentDefault,
                          ),
                        ),
                        TextButton(
                           onPressed: () => Get.toNamed(Routes.TONTINE_GROUP),
                           child: Text(
                             "មើលទាំងអស់".tr,
                             style: localizedTextStyle(
                               fontSize: 14,
                               fontWeight: FontWeight.bold,
                               color: AppColor.infoNormal,
                             ),
                           ),
                         ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              sliver: controller.tontineGroup.isEmpty
                  ? SliverToBoxAdapter(
                      child: Column(
                        children: [
                          const SizedBox(height: 40),
                          Icon(
                            Icons.group_off_outlined,
                            size: 64,
                            color: AppColor.contentPlaceholder,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            "មិនមានក្រុមតុងទីនទេ".tr,
                            style: localizedTextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: AppColor.contentDim,
                            ),
                          ),
                        ],
                      ),
                    )
                  : SliverList.separated(
                      separatorBuilder: (context, index) => const SizedBox(height: 16),
                      itemCount: controller.tontineGroup.length,
                      itemBuilder: (context, index) {
                        return TontineCard(
                            groupId: controller.tontineGroup[index]["id"] ?? controller.tontineGroup[index]["_id"],
                            groupName: controller.tontineGroup[index]["groupName"],
                            startDate: controller.tontineGroup[index]["startDate"],
                            totalMembers: controller.tontineGroup[index]["totalMembers"],
                            contributionAmount: (controller.tontineGroup[index]["contributionAmount"] as num).toDouble(),
                            status: controller.tontineGroup[index]["status"],
                            imageUrl: controller.tontineGroup[index]["imageUrl"],
                            onTap: () => Get.toNamed(Routes.GROUP_DETAILS, arguments: controller.tontineGroup[index]["id"] ?? controller.tontineGroup[index]["_id"]),
                          );
                      },
                    ),
            ),
          ],
        ),
      )),
    ],
  ),
);
  }
}
