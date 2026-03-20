
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:homework_app/app/common/style/style.dart';
import 'package:homework_app/app/modules/utils/constants/colors.dart';
import 'package:homework_app/app/modules/utils/helpers/helper.dart';

class CustomButtonWidget {
  // Todo: buildButtonClick
  static Widget buildButtonClick({required String title, required bool activeColor, void Function()? onPress}) {
    return SizedBox(
      width: double.infinity,
      height: 45,
      child: ElevatedButton(
        onPressed: onPress,
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero, // needed for gradient
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          elevation: 0,
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
        ),
        child: Ink(
          decoration: BoxDecoration(
            gradient: activeColor ? AppColor.appBarGradient : null,
            color: activeColor ? null : Colors.white,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Container(
            alignment: Alignment.center,
            child: Text(
              title,
              style: localizedTextStyle(color: activeColor ? AppColor.greyBold : AppColor.violetColor, fontSize: 18, fontWeight: FontWeight.w300),
            ),
          ),
        ),
      ),
    );
  }

  // Todo: buildButtonGetStart
  static Widget buildButtonGetStart({required String title, double borderRadius = 8, bool activeColor = true, void Function()? onPress}) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient:
              activeColor
                  ? LinearGradient(colors: [AppColor.greyBold, AppColor.greyBold])
                  : LinearGradient(colors: [Colors.white, Colors.white]),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent, // Transparent to show gradient
            shadowColor: Colors.transparent, // Remove default shadow
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          onPressed: onPress,
          child: Text(
            title,
            style: localizedTextStyle(color: activeColor ? Colors.white : AppColor.violetColor, fontSize: 13, fontWeight: FontWeight.w300),
          ),
        ),
      ),
    );
  }

  static Widget buildButtonWithIcon({required String title, IconData? icon, bool activeColor = true, void Function()? onPress}) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient:
              activeColor
                  ? AppColor.appBarGradient
                  : LinearGradient(colors: [Colors.white, Colors.white]),
          borderRadius: BorderRadius.circular(8),
          border: activeColor ? Border.all(color: Colors.transparent, width: 0) : Border.all(color: Colors.grey, width: 1),
        ),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent, // Transparent to show gradient
            shadowColor: Colors.transparent, // Remove default shadow
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          onPressed: onPress,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: activeColor ? Colors.white : Colors.grey),
              SizedBox(width: 12),
              Text(title, style: localizedTextStyle(color: activeColor ? Colors.white : Colors.grey, fontSize: 13, fontWeight: FontWeight.w300)),
            ],
          ),
        ),
      ),
    );
  }

  // Todo: buildButtonIcon
  static Widget buildButtonIcon({String? title, String? image, double widthHeight = 50, void Function()? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Wrap(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: widthHeight,
                height: widthHeight,
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl: image!,
                  placeholder: (context, url) {
                    return ClipRRect(borderRadius: BorderRadius.circular(8), child: CupertinoActivityIndicator());
                  },
                  errorWidget:
                      (context, url, error) =>
                          ClipRRect(borderRadius: BorderRadius.circular(8), child: Image.asset("assets/icons/error_icon.png", fit: BoxFit.cover)),
                ),
              ),
              SizedBox(height: 6),
              Text(
                title!,
                style: localizedTextStyle(color: AppColor.contentSubtle, fontWeight: FontWeight.w600, fontSize: 14, height: 1.5),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Todo: settingBtnTile
  static Widget settingBtnTile(
    String text, {
    String? des,
    bool isDivider = true,
    String? icon,
    bool isImage = true,
    bool isDanger = false,
    bool isGreenSchool = false,
    bool isEmail = false,
    String email = "",
    double? height,
    void Function()? onTap,
  }) {
    return Wrap(
      children: [
        Column(
          children: [
            SizedBox(
              height: height ?? 50,
              child: GestureDetector(
                onTap: onTap,
                child: Container(
                  color: Colors.transparent,
                  child: Row(
                    children: [
                      isImage ? SvgPicture.asset("assets/icons/$icon", width: 24, height: 24) : SizedBox(),
                      SizedBox(width: 10),
                      Text(
                        text,
                        style: localizedTextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: isDanger ? Colors.red : (isGreenSchool ? AppColor.greyBold : Colors.black),
                        ),
                      ),
                      Spacer(),
                      Text(des ?? "", style: localizedTextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: AppColor.contentDim)),
                      des != null ? SizedBox(width: 16) : SizedBox(),
                      isEmail
                          ? Text(email, style: localizedTextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: AppColor.greyBold))
                          : SvgPicture.asset("assets/icons/arrow_right.svg", color: AppColor.contentDim),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: isImage ? 40 : 0),
              child: isDivider ? Divider(height: 1, color: Colors.grey.shade300) : SizedBox(),
            ),
          ],
        ),
      ],
    );
  }

  static Widget buildBtnTile(
    String text, {
    String? des,
    String? iconLeft,
    bool isIconLeft = true,
    bool isDivider = true,
    String? icon,
    bool isImage = true,
    bool isIcon = false,
    bool isNotArrow = true,
    bool isDanger = false,
    BoxDecoration? decoration,
    void Function()? onTap,
  }) {
    return Wrap(
      children: [
        Column(
          children: [
            SizedBox(
              height: 50,
              child: GestureDetector(
                onTap: onTap,
                child: Container(
                  decoration: decoration,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      isIcon ? SvgPicture.asset("assets/icons/$icon", width: 24, height: 24) : SizedBox(),
                      SizedBox(width: 10),
                      Text(text, style: localizedTextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: isDanger ? Colors.red : Colors.black)),
                      Text(
                        des ?? "",
                        style: localizedTextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.grey.shade400),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      isIconLeft ? SizedBox() : onlyProfile(iconLeft, 40),
                      isNotArrow ? Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 20) : SizedBox(),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: isImage ? 40 : 0),
              child: isDivider ? Divider(height: 1, color: Colors.grey.shade300) : SizedBox(),
            ),
          ],
        ),
      ],
    );
  }

  // Todo: buildButtonGetStart
  static Widget buildButtonNewGetStart({required String title, double borderRadius = 16, bool activeColor = true, void Function()? onPress, bool isDanger = false, bool isDisabled = false,int? maxLines, TextAlign? textAlign}) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: activeColor ? AppColor.alertDarkHover : isDanger ? AppColor.backgroundDefault : isDisabled ? AppColor.backgroundDisabled : AppColor.backgroundDisabled,
          borderRadius: BorderRadius.circular(borderRadius),
          border: isDanger ? Border.all(color: AppColor.alertNormal, width: 1) : null,
        ),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadius)),
          ),
          onPressed: onPress,
          child: Text(
            title,
            maxLines: maxLines,
            textAlign: textAlign,
            style: localizedTextStyle(
              color: activeColor ? AppColor.contentDefaultInverse : isDanger ? AppColor.alertNormal : AppColor.contentDefaultInverse,
              fontWeight: !activeColor ? FontWeight.w700 : FontWeight.w700,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }
  // Todo: buildButtonGetStart
  static Widget buildButtonTransparent({required String title, double borderRadius = 16, bool activeColor = true, void Function()? onPress}) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: AppColor.outlineSoftest,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadius), side: BorderSide(color: activeColor  ? AppColor.greyBold : AppColor.outlineSoftest)),
          ),
          onPressed: onPress,
          child: Text(
            title,
            style: localizedTextStyle(
              color: activeColor ? AppColor.greyBold : AppColor.contentDefault,
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
