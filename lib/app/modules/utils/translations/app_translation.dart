
import 'package:get/get.dart';
import 'package:homework_app/app/modules/utils/translations/en_us.dart';
import 'package:homework_app/app/modules/utils/translations/km_kh.dart';
import 'package:homework_app/app/modules/utils/translations/vi_vn.dart';
import 'package:homework_app/app/modules/utils/translations/zh_cn.dart';
import 'package:homework_app/app/modules/utils/translations/zh_tw.dart';

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {'en_US': enUS, 'km_KH': kmKH, 'zh_CN': zhCN, "vi_VN" :viVN, "zh_TW": zhTW};
}
