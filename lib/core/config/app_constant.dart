import 'package:flutter/material.dart';

abstract class AppConstant {
  static const app_name = 'Smart rent';
  //country_code_language
  static const viVN = 'vi_VN';
  static const enUS = 'en_US';

  //locate
  static const appSupportLocale = [Locale('vi', "VN"), Locale('en', "US")];

  // Hive
  static const hiveBoxName = 'smart_rent';
  static const hiveSessionKey = 'session';
  static const hiveRecentSearchRoomKey = 'recent_search_room';

  // Debound timer
  static const debounceTime = 500;
}
