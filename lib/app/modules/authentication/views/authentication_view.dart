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
       bottomSheet: SafeArea(
          child: Container(
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
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                padding: const EdgeInsets.fromLTRB(8, 8, 8, 24),
                  child: SafeArea(
                    child:  CustomButtonWidget.buildButtonNewGetStart(
                          title: "continue".tr,
                          borderRadius: 24,
                          activeColor: true,
                          onPress: () {
                            controller.signIn();
                          }
                           
                        ),
                  ),
                ),
              ],
            ),
          ),
        ),
      
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
              Text("សូមស្វាគមន៍មកកាន់E-តុងទីន", style: localizedTextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
              SizedBox(height: 4),
              Text("សូមចូលគណនីរបស់អ្នកដើម្បីប្រើប្រាស់កម្មវិធី", style: localizedTextStyle(fontSize: 16, fontWeight: FontWeight.normal),),
              SizedBox(height: 12,),
              //CustomTextfields
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
                child: Column(
                spacing: 12,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                Text("សូមបញ្ចូលលេខទូរស័ព្ទរបស់អ្នក", style: localizedTextStyle(fontSize: 16, fontWeight: FontWeight.normal),),
                CustomTextFieldWidget(
                  label: "អ្នកប្រើប្រាស់",
                  controller.phoneController,
                  isFillColor: true,
                  isPhoneNumber: true,
                ),
                 Text("សូមបញ្ចូលលេខលេខកូដរបស់អ្នក", style: localizedTextStyle(fontSize: 16, fontWeight: FontWeight.normal),),
                 CustomTextFieldWidget(
                  label: "លេខកូដ",
                  controller.passwordController,
                  isFillColor: true,
                  isObscureText: true,
                ),
                ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
              Text("មិនមានគណនី?", style: localizedTextStyle(fontSize: 16, fontWeight: FontWeight.normal),),
              TextButton(
                onPressed: () {},
                child: Text("ចុះឈ្មោះ", style: localizedTextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: AppColor.alertDarkHover),),
              ),
              ],)
          
        ],),
      )
    );
  }
}
