import 'package:b_partner/common/styles/style.dart';
import 'package:b_partner/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class TTextTheme {
  TTextTheme._();

  // 🌞 Light mode text styles
  static TextTheme lightTextTheme = TextTheme(
    displaySmall: localizedTextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w600,
      color: AppColor.contentDefault,
    ),
    headlineLarge: localizedTextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    ),
    headlineMedium: localizedTextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w600,
      color: AppColor.contentDefault,
    ),
    headlineSmall: localizedTextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w600,
      color: AppColor.contentDefault,
    ),
    titleMedium:  localizedTextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: AppColor.contentSubtle,
    ),
    titleSmall: localizedTextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: AppColor.contentSubtle,
    ),
    bodyMedium: localizedTextStyle(
      fontSize: 14,
      fontWeight: FontWeight.normal,
      color: AppColor.contentSubtle,
    ),
    bodySmall: localizedTextStyle(
      fontSize: 12,
      fontWeight: FontWeight.normal,
      color: AppColor.contentSubtle,
    ),
  );

  // 🌙 Dark mode text styles
  static TextTheme darkTextTheme =  TextTheme(
    headlineLarge: localizedTextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
    titleMedium: localizedTextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: Colors.white70,
    ),
    bodyMedium: localizedTextStyle(
      fontSize: 14,
      fontWeight: FontWeight.normal,
      color: Colors.white60,
    ),
  );
}
