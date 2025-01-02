import 'package:smart_rent/core/app/app_hive.dart';
import 'package:smart_rent/core/config/app_constant.dart';

class AppStorage {
  static bool? getFistTimeInstall() {
    return HiveManager.get(AppConstant.hiveFirstTimeInstall);
  }

  static Future<void> putFirstTimeInstall({bool? value}) async {
    await HiveManager.put(AppConstant.hiveFirstTimeInstall, value ?? true);
  }

  static Future<void> clearFirstTimeInstall() async {
    await HiveManager.delete(AppConstant.hiveFirstTimeInstall);
  }

  static Map<String, dynamic>? getSession() {
    return HiveManager.get(AppConstant.hiveSession);
  }

  static Future<void> putSession(Map<String, dynamic> value) async {
    await HiveManager.put(AppConstant.hiveSession, value);
  }

  static Future<void> clearSession() async {
    await HiveManager.delete(AppConstant.hiveSession);
  }
}
