

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homework_app/app/data/service/storage_service.dart';



class TranslationService extends GetxService {
  static const String _localeKey = 'locale';

  final _locale = const Locale('en', 'US').obs;
  Locale get locale => _locale.value;

  static const List<Locale> supportedLocales = [Locale('en', 'US'), Locale('km', 'KH'), Locale('zh', 'CN')];

  Future<TranslationService> init() async {
    final savedLocale = StorageService.getString(_localeKey);
    if (savedLocale != null && savedLocale.isNotEmpty) {
      _locale.value = _getLocaleFromString(savedLocale);
    } else {
      _locale.value = const Locale('en', 'US');
    }
    return this;
  }

  void changeLocale(Locale locale) {
    _locale.value = locale;
    Get.updateLocale(locale);
    StorageService.setString(_localeKey, locale.toString());
  }

  Locale _getLocaleFromString(String localeString) {
    for (final locale in supportedLocales) {
      if (locale.toString() == localeString) {
        return locale;
      }
    }
    return const Locale('en', 'US');
  }

  String getLanguageName(Locale locale) {
    switch (locale.languageCode) {
      case 'en':
        return 'english'.tr;
      case 'km':
        return 'khmer'.tr;
      case 'zh':
        return 'chinese'.tr;
      default:
        return 'english'.tr;
    }
  }
}
