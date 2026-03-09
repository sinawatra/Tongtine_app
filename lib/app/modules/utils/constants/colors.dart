import 'dart:ui';

import 'package:flutter/material.dart';

class AppColor {
  AppColor._();
  // Suntel Colors
  static const Color suntelLight = Color(0xFFFCEAEB);
  static const Color suntelLightHover = Color(0xFFFADFE1);
  static const Color suntelLightActive = Color(0xFFF5BEC0);
  static const Color suntelNormal = Color(0xFFE02C35);
  static const Color suntelNormalHover = Color(0xFFCA2830);
  static const Color suntelNormalActive = Color(0xFFB3232A);
  static const Color suntelDark = Color(0xFFA82128);
  static const Color suntelDarkHover = Color(0xFF861A20);
  static const Color suntelDarkActive = Color(0xFF651418);
  static const Color suntelDarker = Color(0xFF4E0F13);
  static Color violetColor = Color(0xFF163CC5);

  // bEasy Colors
  static const Color bEasyLight = Color(0xFFEAEFF7);
  static const Color bEasyLightHover = Color(0xFFDFE8F3);
  static const Color bEasyLightActive = Color(0xFFBECFE5);
  static const Color bEasyNormal = Color(0xFF2C63AC);
  static const Color bEasyNormalHover = Color(0xFF234F8A);
  static const Color bEasyNormalActive = Color(0xFF234F8A);
  static const Color bEasyDark = Color(0xFF214A81);
  static const Color bEasyDarkHover = Color(0xFF1A3B67);
  static const Color bEasyDarkActive = Color(0xFF142D4D);
  static const Color bEasyDarker = Color(0xFF0F233C);

  // bNow Colors
  static const Color bNowLight = Color(0xFFFEF8E9);
  static const Color bNowLightHover = Color(0xFFFEF4DE);
  static const Color bNowLightActive = Color(0xFFFDE8BB);
  // static const Color bNowNormal = Color(0xFFF8B625);
  static const Color bNowNormal = Color(0xFFFDB514);
  static const Color bNowNormalHover = Color(0xFFDFA421);
  static const Color bNowNormalActive = Color(0xFFC6921E);
  static const Color bNowDark = Color(0xFFBA891C);
  static const Color bNowDarkHover = Color(0xFF956D16);
  static const Color bNowDarkActive = Color(0xFF705211);
  static const Color bNowDarker = Color(0xFF57400D);

  // Warning Colors
  static const Color warningLight = Color(0xFFFEF7EA);
  static const Color warningLightHover = Color(0xFFFDF3E0);
  static const Color warningLightActive = Color(0xFFFBE7BF);
  static const Color warningNormal = Color(0xFFF1B12F);
  static const Color warningNormalHover = Color(0xFFD99F2A);
  static const Color warningNormalActive = Color(0xFFC18E26);
  static const Color warningDark = Color(0xFFB58523);
  static const Color warningDarkHover = Color(0xFF916A1C);
  static const Color warningDarkActive = Color(0xFF6C5015);
  static const Color warningDarker = Color(0xFF543E10);

  // Alert Colors
  static const Color alertLight = Color(0xFFFEEBEC);
  static const Color alertLightHover = Color(0xFFFDE1E2);
  static const Color alertLightActive = Color(0xFFFBC2C3);
  static const Color alertNormal = Color(0xFFF33A3C);
  static const Color alertNormalHover = Color(0xFFDB3436);
  static const Color alertNormalActive = Color(0xFFC22E30);
  static const Color alertDark = Color(0xFFB62C2D);
  static const Color alertDarkHover = Color(0xFF922324);
  static const Color alertDarkActive = Color(0xFF6D1A1B);
  static const Color alertDarker = Color(0xFF551415);

  // Info Colors
  static const Color infoLight = Color(0xFFEBEFFE);
  static const Color infoLightHover = Color(0xFFE1E7FE);
  static const Color infoLightActive = Color(0xFFC0CEFC);
  static const Color infoNormal = Color(0xFF3460F5);
  static const Color infoNormal2 = Color(0xFF0063F7);
  static const Color infoNormalHover = Color(0xFF2F56DD);
  static const Color infoNormalActive = Color(0xFF2A4DC4);
  static const Color infoDark = Color(0xFF2748B8);
  static const Color infoDarkHover = Color(0xFF1F3A93);
  static const Color infoDarkActive = Color(0xFF172B6E);
  static const Color infoDarker = Color(0xFF122256);

  // Success Colors
  static const Color successLight = Color(0xFFE9F9F1);
  static const Color successLightHover = Color(0xFFDEF6EA);
  static const Color successLightActive = Color(0xFFBAECD3);
  static const Color successNormal = Color(0xFF20C272);
  static const Color successNormalHover = Color(0xFF1DAF67);
  static const Color successNormalActive = Color(0xFF1A9B5B);
  static const Color successDark = Color(0xFF189256);
  static const Color successDarkHover = Color(0xFF137444);
  static const Color successDarkActive = Color(0xFF0E5733);
  static const Color successDarker = Color(0xFF0B4428);

  // Content Colors
  static const Color contentDefault = Color(0xFF1A1A1A);
  static const Color contentSubtle = Color(0xFF3D3D3D);
  static const Color contentDim = Color(0xFF707070);
  static const Color contentPlaceholder = Color(0xFFA3A3A3);
  static const Color contentDisabled = Color(0xFFBFBFBF);
  static const Color contentDefaultInverse = Color(0xFFFFFFFF);

  // Background Colors
  static const Color backgroundDefault = Color(0xFFFFFFFF);
  static const Color backgroundAlt = Color(0xFFF5F5F5);
  static const Color backgroundDisabled = Color(0xFFF5F5F5);
  static const Color backgroundTranslucent = Color(0x3DFFFFFF);
  static const Color backgroundDefaultInverse = Color(0xFF1A1A1A);
  static const Color backgroundAltInverse = Color(0xFF3D3D3D);
  static const Color backgroundTransparencyInverse = Color(0xCC1A1A1A);

  // Outline Colors
  static const Color outlineSoftest = Color(0xFFE8E8E8);
  static const Color outlineSoft = Color(0xFFDBDBDB);
  static const Color outlineDefault = Color(0xFFBFBFBF);
  static const Color outlineBolt = Color(0xFFA3A3A3);
  static const Color outlineBoldest = Color(0xFF8C8C8C);
  static const Color outlineDisabled = Color(0xFFE8E8E8);
  static const Color defaultSystemBlueLight = Color(0xFF007AFF);
  // static const Color outlineSoftest = Color(0xffE8E8E8);
  static Color greyBold = Color(0xFF163CC5);

  static const LinearGradient appBarGradient = LinearGradient(
    colors: [Color(0xFF102C90), Color(0xFF1B4CFA)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const Color white = Color(0xFFFFFFFF);
  


}