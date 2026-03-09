
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homework_app/app/common/style/style.dart';
import 'package:homework_app/app/common/widgets/custom_lazyindexstack.dart';
import 'package:homework_app/app/modules/appscreen/controllers/appscreen_controller.dart';
import 'package:homework_app/app/modules/home/views/home_view.dart';
import 'package:homework_app/app/modules/utils/constants/colors.dart';
import 'package:homework_app/app/modules/utils/constants/image_constant.dart';



class AppscreenView extends GetView<AppscreenController> {
  const AppscreenView({super.key});

  @override
  Widget build(BuildContext context) {
    final screens = <Widget>[
      const HomeView(),
      // const EarningView(),
      // const MessageView(),
      // const ProfileView(), // Removed const as it was not const in original
    ];

    return Obx(() {
      final index = controller.currentIndex.value;
      return Scaffold(
        body: LazyIndexedStack(index: index, children: screens),
        bottomNavigationBar: _BottomNavBar(
          currentIndex: index,
          onChanged: controller.changeTab,
        ),
      );
    });
  }
}

class _BottomNavBar extends StatelessWidget {
  const _BottomNavBar({required this.currentIndex, required this.onChanged});
  final int currentIndex;
  final ValueChanged<int> onChanged;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      decoration: BoxDecoration(
        color: Get.theme.scaffoldBackgroundColor,
        boxShadow: const [
          BoxShadow(
            color: Color(0x191C1C1C),
            blurRadius: 12,
            offset: Offset(0, 2),
          ),
        ],
    ),
      child: SafeArea(
        top: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: _NavItem(
                label: "Home".tr,
                noSelectIcon: ImageConstants.homeIconNoSelect,
                selectIcon: ImageConstants.homeIconSelect,
                active: currentIndex == 0,
                onTap: () => onChanged(0),
              ),
            ),
            Expanded(
              child: _NavItem(
                label: "Earnings".tr,
                noSelectIcon: ImageConstants.earningNoSelect,
                selectIcon: ImageConstants.earningSelect,
                active: currentIndex == 1,
                onTap: () => onChanged(1),
              ),
            ),
            Expanded(
              child: _NavItem(
                label: "Messages".tr,
                noSelectIcon: ImageConstants.messageNoSelect,
                selectIcon: ImageConstants.messageSelect,
                active: currentIndex == 2,
                onTap: () => onChanged(2),
              ),
            ),
            Expanded(
              child: _NavItem(
                label: "Profile".tr,
                noSelectIcon: ImageConstants.profileNoSelect,
                selectIcon: ImageConstants.profileSelect,
                active: currentIndex == 3,
                onTap: () => onChanged(3),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.label,
    required this.selectIcon,
    required this.noSelectIcon,
    required this.active,
    required this.onTap,
  });
  final String label;
  final String selectIcon;
  final String noSelectIcon;
  final bool active;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    final activeColor = AppColor.greyBold;
    final inactiveColor = AppColor.contentSubtle;
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 70,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              active ? selectIcon : noSelectIcon,
              height: active ? 32 : 24,
              width: active ? 32 : 24,
            ),
            const SizedBox(height: 6),
            Text(
              label,
              textAlign: TextAlign.center,
              style: localizedTextStyle(
                color: active ? activeColor : inactiveColor,
                fontSize: 14,
                fontWeight: active ? FontWeight.w600 : FontWeight.w500,
                height: 1.43,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
