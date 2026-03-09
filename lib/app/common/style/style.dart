// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle localizedTextStyle({
  FontWeight fontWeight = FontWeight.w400,
  double? fontSize,
  Color? color,
  FontStyle? fontStyle,
  double? height,
  TextDecoration? decoration,
}) {
  final lang = (Get.locale?.languageCode ?? 'en').toLowerCase();
  switch (lang) {
    case 'km':
      return GoogleFonts.kantumruyPro(
        fontWeight: fontWeight,
        fontSize: 15,
        color: color,
        fontStyle: FontStyle.normal,
        height: height,
        decoration: decoration,
      );
    case 'zh_cn':
    case 'zh_tw':
    case 'vi':
      return TextStyle(
        fontFamily: 'MiSans',
        fontWeight: fontWeight,
        fontSize: fontSize,
        color: color,
        fontStyle: FontStyle.normal,
        height: height,
        decoration: decoration,
      );
    case 'en':
    return GoogleFonts.inter(
        fontWeight: fontWeight,
        fontSize: fontSize,
        color: color,
        fontStyle: FontStyle.normal,
        height: height,
        decoration: decoration,
      );
    default:
      return GoogleFonts.inter(
        fontWeight: fontWeight,
        fontSize: fontSize,
        color: color,
        fontStyle: FontStyle.normal,
        height: height,
        decoration: decoration,
      );
  }
}

