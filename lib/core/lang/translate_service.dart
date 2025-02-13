import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

import '../config/app_constant.dart';
import 'en_us.dart';
import 'vi_vn.dart';

class TranslationService extends Translations {
  static Locale get locale => AppConstant.appSupportLocale.first;
  static Locale get fallbackLocale => AppConstant.appSupportLocale.last;

  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': enUS,
        'vi_VN': viVN,
      };
}
