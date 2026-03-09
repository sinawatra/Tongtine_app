import 'dart:io';

import 'package:b_partner/app/modules/authentication/model/phone_model.dart';
import 'package:b_partner/utils/helpers/helper.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:package_info_plus/package_info_plus.dart';

class TDeviceUtils {
  static void hideKeyboard(BuildContext context) {
    FocusManager.instance.primaryFocus?.unfocus();
    SystemChannels.textInput.invokeMethod('TextInput.hide');
  }

  static void launchUrl(String Url) {}
}

Future<DeviceInfoModel> getDeviceName() async {
  try {
    final info = DeviceInfoPlugin();
    final appInfo = await getAppVersion();

    if (Platform.isAndroid) {
      final android = await info.androidInfo;
      return DeviceInfoModel(platform: "android", deviceModel: android.model, osVersion: android.version.release, appVersion: appInfo );
    } else if (Platform.isIOS) {
      final ios = await info.iosInfo;
      return DeviceInfoModel(platform: "ios", deviceModel: ios.modelName, osVersion: ios.systemVersion, appVersion: appInfo);
    }
    return DeviceInfoModel(platform: "Unknown", deviceModel: "Unknown", osVersion: "Unknown", appVersion: "Unknown");
  } catch (e) {
    return DeviceInfoModel(platform: "Unknown", deviceModel: "Unknown", osVersion: "Unknown", appVersion: "Unknown");
  }
}


Future<String> getAppVersion() async {
  try {
    final info = await PackageInfo.fromPlatform();
    return "${info.version}+${info.buildNumber}";
  } catch (e) {
    return "Unknown";
}
}