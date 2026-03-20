import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homework_app/app/modules/home/components/custom_card.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Home'),
      ),
      body:  CustomScrollView(
        slivers: [
         SliverAnimatedList(
          initialItemCount:controller.tontineGroup.value.length,
          itemBuilder: (context, index, animation) {
          return TontineCard(
            groupName: controller.tontineGroup[index]["groupName"],
            startDate: controller.tontineGroup[index]["startDate"],
            totalMembers: controller.tontineGroup[index]["totalMembers"],
            contributionAmount: controller.tontineGroup[index]["contributionAmount"],
            status: controller.tontineGroup[index]["status"],
          );
         }),
        ],
      )
    );
  }
}
