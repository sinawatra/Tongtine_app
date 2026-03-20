import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homework_app/app/common/style/style.dart';
import 'package:homework_app/app/modules/utils/constants/colors.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../controllers/tontine_group_controller.dart';

class TontineGroupDetails extends StatefulWidget {
  const TontineGroupDetails({super.key});

  @override
  State<TontineGroupDetails> createState() => _TontineGroupDetailsState();
}

class _TontineGroupDetailsState extends State<TontineGroupDetails> {
  final TontineGroupController controller = Get.find();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final String? arg = Get.arguments;
      if (arg != null && arg.isNotEmpty) {
        controller.getGroupDetails(arg);
      }
    });
  }

  void _showPayoutDialog(String groupId) {
    final TextEditingController amountController = TextEditingController();
    Get.dialog(
      AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          "triggerPayout".tr,
          style: localizedTextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: AppColor.contentDefault,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Enter payout amount",
              style: localizedTextStyle(
                fontSize: 14,
                color: AppColor.contentDim,
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: amountController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              autofocus: true,
              decoration: InputDecoration(
                hintText: "0.00",
                prefixText: "\$ ",
                filled: true,
                fillColor: AppColor.backgroundAlt,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text(
              "Cancel",
              style: localizedTextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColor.contentDim,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if (amountController.text.isNotEmpty) {
                Get.back();
                controller.triggerPayoutForTheGroup(groupId, amountController.text);
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColor.infoNormal,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              elevation: 0,
            ),
            child: Text(
              "Trigger",
              style: localizedTextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final String groupId = Get.arguments ?? "";

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'groupDetails'.tr,
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
        actions: [
          IconButton(
            icon: const Icon(Icons.share_outlined, size: 22),
            onPressed: () {
              // Share group ID logic
            },
          ),
        ],
      ),
      body: Obx(() => Skeletonizer(
            enabled: controller.isLoading.value,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(controller.groupInfo),
                  const SizedBox(height: 24),
                  _buildStatsGrid(controller.groupInfo),
                  const SizedBox(height: 24),
                  _buildActions(groupId, controller.groupInfo),
                  const SizedBox(height: 32),
                  _buildMembersList(),
                ],
              ),
            ),
          )),
    );
  }

  Widget _buildHeader(RxMap info) {
    return Row(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: AppColor.backgroundAlt,
            image: info["imageUrl"] != null
                ? DecorationImage(
                    image: NetworkImage(info["imageUrl"]),
                    fit: BoxFit.cover,
                  )
                : null,
          ),
          child: info["imageUrl"] == null
              ? const Icon(Icons.group, size: 40, color: AppColor.contentDim)
              : null,
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                info["groupName"] ?? "Loading...",
                style: localizedTextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: AppColor.contentDefault,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                "ID: ${info["id"] ?? "---"}",
                style: localizedTextStyle(
                  fontSize: 14,
                  color: AppColor.contentDim,
                ),
              ),
              const SizedBox(height: 8),
              _buildStatusBadge(info["status"] ?? "PENDING"),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStatusBadge(String status) {
    Color bgColor;
    Color textColor;
    String label = status;

    switch (status) {
      case "IN_PROGRESS":
        bgColor = AppColor.infoLight;
        textColor = AppColor.infoNormal;
        label = "In Progress";
        break;
      case "COMPLETED":
        bgColor = AppColor.successLight;
        textColor = AppColor.successNormal;
        label = "Completed";
        break;
      default:
        bgColor = AppColor.warningLight;
        textColor = AppColor.warningNormal;
        label = "Pending";
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(100),
      ),
      child: Text(
        label,
        style: localizedTextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: textColor,
        ),
      ),
    );
  }

  Widget _buildStatsGrid(RxMap info) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColor.backgroundAlt,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatItem("Contribution", "\$${info["contributionAmount"] ?? 0}"),
          _buildStatItem("Members", "${info["totalMembers"] ?? 0}"),
          _buildStatItem("Start Date", info["startDate"] ?? "TBD"),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Column(
      children: [
        Text(
          label,
          style: localizedTextStyle(
            fontSize: 12,
            color: AppColor.contentDim,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: localizedTextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: AppColor.contentDefault,
          ),
        ),
      ],
    );
  }

  Widget _buildActions(String groupId, RxMap info) {
    // Basic logic to show Join or Payout
    // In a real app, we'd check if the user is already a member
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            onPressed: () => controller.joinGroup(groupId),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColor.infoNormal,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 0,
            ),
            child: Text(
              "Join Group",
              style: localizedTextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          height: 50,
          child: OutlinedButton(
            onPressed: () => _showPayoutDialog(groupId),
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: AppColor.infoNormal),
              foregroundColor: AppColor.infoNormal,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              "Trigger Payout",
              style: localizedTextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMembersList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Group Members",
          style: localizedTextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: AppColor.contentDefault,
          ),
        ),
        const SizedBox(height: 16),
        Obx(() => ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.groupMembers.length,
              separatorBuilder: (context, index) => const Divider(height: 24),
              itemBuilder: (context, index) {
                final member = controller.groupMembers[index];
                final user = member["user"] ?? {};
                return Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: AppColor.backgroundAlt,
                      backgroundImage: user["imageUrl"] != null
                          ? NetworkImage(user["imageUrl"])
                          : null,
                      child: user["imageUrl"] == null
                          ? const Icon(Icons.person, color: AppColor.contentDim)
                          : null,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            user["fullName"] ?? "Anonymous",
                            style: localizedTextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: AppColor.contentDefault,
                            ),
                          ),
                          Text(
                            user["phone"] ?? "",
                            style: localizedTextStyle(
                              fontSize: 14,
                              color: AppColor.contentDim,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (member["isWinner"] == true || member["payoutOrder"] == 1)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColor.successLight,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          member["payoutOrder"] == 1 ? "First Payout" : "Winner",
                          style: localizedTextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            color: AppColor.successNormal,
                          ),
                        ),
                      ),
                  ],
                );
              },
            )),
      ],
    );
  }
}
