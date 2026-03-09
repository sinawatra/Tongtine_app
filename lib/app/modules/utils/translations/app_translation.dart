import 'package:b_partner/utils/translations/en_us.dart';
import 'package:b_partner/utils/translations/km_kh.dart';
import 'package:b_partner/utils/translations/vi_vn.dart';
import 'package:b_partner/utils/translations/zh_cn.dart';
import 'package:b_partner/utils/translations/zh_tw.dart';
import 'package:get/get.dart';

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {'en_US': enUS, 'km_KH': kmKH, 'zh_CN': zhCN, "vi_VN" :viVN, "zh_TW": zhTW};
}
