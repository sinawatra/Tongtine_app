import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homework_app/app/common/style/style.dart';
import 'package:homework_app/app/common/widgets/custom_button_submit.dart';
import 'package:homework_app/app/common/widgets/custom_text_field.dart';
import 'package:homework_app/app/modules/utils/constants/colors.dart';

import '../controllers/authentication_controller.dart';

class AuthenticationView extends GetView<AuthenticationController> {
  const AuthenticationView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      bottomSheet: Container(
        // margin: EdgeInsets.only(bottom: MediaQuery.of(context).viewPadding.bottom),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 8,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            8,
            8,
            8,
            MediaQuery.of(context).viewInsets.bottom > 0
                ? 8
                : MediaQuery.of(context).viewPadding.bottom + 8,
          ),
          child: Obx(() {
            return CustomButtonWidget.buildButtonNewGetStart(
              title: controller.appStartState.value == StartPageState.login
                  ? "ចូលគណនី"
                  : "ចុះឈ្មោះ",
              borderRadius: 24,
              activeColor: true,
              onPress: () {
                if (controller.appStartState.value == StartPageState.login) {
                  controller.signIn();
                } else {
                  controller.signUp();
                }
              },
            );
          }),
        ),
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "សូមស្វាគមន៍មកកាន់E-តុងទីន",
              style: localizedTextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4),
            Text(
              "សូមចូលគណនីរបស់អ្នកដើម្បីប្រើប្រាស់កម្មវិធី",
              style: localizedTextStyle(fontSize: 16, fontWeight: FontWeight.normal),
            ),
            SizedBox(height: 12),
            //CustomTextfields
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
              child: Obx(() {
                return Column(
                  spacing: 12,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (controller.appStartState.value == StartPageState.register) ...[
                      Text(
                        "សូមបញ្ចូលលេខឈ្មោះពេញរបស់អ្នក",
                        style: localizedTextStyle(fontSize: 16, fontWeight: FontWeight.normal),
                      ),
                      CustomTextFieldWidget(
                        label: "ឈ្មោះពេញ",
                        controller.fullNameController,
                        isFillColor: true,
                        isPhoneNumber: false,
                      ),
                    ],
                    Text(
                      "សូមបញ្ចូលលេខទូរស័ព្ទរបស់អ្នក",
                      style: localizedTextStyle(fontSize: 16, fontWeight: FontWeight.normal),
                    ),
                    CustomTextFieldWidget(
                      label: "អ្នកប្រើប្រាស់",
                      controller.phoneController,
                      isFillColor: true,
                      isPhoneNumber: true,
                    ),
                    Text(
                      "សូមបញ្ចូលលេខលេខកូដរបស់អ្នក",
                      style: localizedTextStyle(fontSize: 16, fontWeight: FontWeight.normal),
                    ),
                    CustomTextFieldWidget(
                      label: "លេខកូដ",
                      controller.passwordController,
                      isFillColor: true,
                      isObscureText: true,
                      isPhoneNumber: false,
                    ),
                  ],
                );
              }),
            ),
            Obx(() {
              return Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (controller.appStartState.value == StartPageState.login) ...[
                    Text(
                      "មិនមានគណនី?",
                      style: localizedTextStyle(fontSize: 16, fontWeight: FontWeight.normal),
                    ),
                  ],
                  if (controller.appStartState.value == StartPageState.register) ...[
                    Text(
                      "មានគណនីរួចហើយ?",
                      style: localizedTextStyle(fontSize: 16, fontWeight: FontWeight.normal),
                    ),
                  ],
                  TextButton(
                    onPressed: () {
                      if (controller.appStartState.value == StartPageState.login) {
                        controller.appStartState.value = StartPageState.register;
                      } else {
                        controller.appStartState.value = StartPageState.login;
                      }
                    },
                    child: Obx(() {
                      return Text(
                        controller.appStartState.value == StartPageState.login
                            ? "ចុះឈ្មោះ"
                            : "ចូលគណនី",
                        style: localizedTextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color: AppColor.alertDarkHover,
                        ),
                      );
                    }),
                  ),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }
}
