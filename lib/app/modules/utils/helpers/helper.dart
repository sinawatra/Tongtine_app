import 'package:b_partner/utils/constants/colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Helper {

  static String formatDate(
    DateTime? date, {
    String pattern = 'yyyy-MM-dd',
  }) {
    if (date == null) return '';
    return DateFormat(pattern).format(date);
  }

  /// Convert nullable DateTime to ISO string (for API)
  static String toIso(DateTime? date) {
    return date?.toIso8601String() ?? '';
  }
  // Todo: onlyProfile

}

Widget onlyProfile(String? avatar, double size) {
  return SizedBox(
    width: size,
    height: size,
    child: Stack(
      children: [
        ClipOval(
          child: Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: AppColor.outlineSoftest, width: 1)),
            child:
                avatar != null && avatar != ""
                    ? CachedNetworkImage(
                      width: size,
                      height: size,
                      fit: BoxFit.cover,
                      imageUrl: avatar,
                      errorWidget: (context, url, error) => Image.asset("assets/icons/default_profile_icon.png"),
                      placeholder: (context, url) => Container(color: AppColor.backgroundDefault),
                    )
                    : SizedBox(width: size, height: size, child: Image.asset("assets/icons/default_profile_icon.png")),
          ),
        ),
      ],
    ),
  );
}


popBack(context) {
  Navigator.pop(context);
}


bool isValidUrl(String? url) {
  if (url == null) return false;
  if (url.isEmpty) return false;
  if (url == "null") return false;
  if (!url.startsWith("http")) return false;
  return true;
}



class Result<T> {
  final T? data;
  final String? error;

  const Result.success(this.data) : error = null;
  const Result.failure(this.error) : data = null;

  R fold<R>({
    required R Function(T data) onSuccess,
    required R Function(String error) onFailure,
  }) {
    if (data != null) return onSuccess(data as T);
    return onFailure(error!);
  }
}




 dayOfTheWeek(int day) {
  switch (day) {
    case 0:
      return "Sunday";
    case 1:
      return "Monday";
    case 2:
      return "Tuesday";
    case 3:
      return "Wednesday";
    case 4:
      return "Thursday";
    case 5:
      return "Friday";
    case 6:
      return "Saturday";
    default:
      return "None";
  }
}

String toUtc(String input) {
  final parts = input.split('/');
  if (parts.length != 3) return '';

  final day = int.parse(parts[0]);
  final month = int.parse(parts[1]);
  final year = int.parse(parts[2]);

  final utcDate = DateTime.utc(year, month, day);
  return utcDate.toIso8601String(); 
}

String formatDob(String isoDate) {
  if(isoDate.isEmpty) return '';
  final date = DateTime.parse(isoDate).toLocal(); 
  final dd = date.day.toString().padLeft(2, '0');
  final mm = date.month.toString().padLeft(2, '0');
  final yyyy = date.year.toString();
  return '$dd-$mm-$yyyy';
}

String? pendingPayload;
String? fcmToken;
String? apnsToken;
String? deviceName;