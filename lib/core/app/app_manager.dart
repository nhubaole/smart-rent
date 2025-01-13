import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_upgrade_version/flutter_upgrade_version.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart' as package_info_plus;
import 'package:smart_rent/core/app/app_hive.dart';
import 'package:smart_rent/core/app/app_storage.dart';
import 'package:smart_rent/core/config/app_constant.dart';
import 'package:smart_rent/core/model/user/user_model.dart';
import 'package:smart_rent/core/repositories/auth/auth_repo_impl.dart';
import 'package:smart_rent/core/repositories/user/user_repo_iml.dart';
import 'package:smart_rent/core/routes/app_routes.dart';

class AppManager {
  static final AppManager instance = AppManager._internal();
  factory AppManager() => instance;

  AppManager._internal();

  late package_info_plus.PackageInfo packageInfo;

  String? _phoneNumber;
  String? _password;

  UserModel? _currentUser;
  UserModel? get currentUser => _currentUser;
  String? get fullName => _currentUser!.fullName;
  int? get userId => _currentUser!.id;
  String? _accessToken;
  String? _refreshToken;
  String? get accessToken => _accessToken;
  String? get refreshToken => _refreshToken;

  bool get isLogged => _currentUser != null && _accessToken != null;

  // PackageInfo
  String get appName => packageInfo.appName;
  String get packageName => packageInfo.packageName;
  String get version => packageInfo.version;
  String get buildNumber => packageInfo.buildNumber;

  Future<void> init() async {
    packageInfo = await package_info_plus.PackageInfo.fromPlatform();
  }

  setSession({
    UserModel? newUser,
    String? newAccessToken,
    String? refreshToken,
    String? phoneNumber,
    String? password,
  }) async {
    _currentUser = newUser ?? _currentUser;
    _accessToken = newAccessToken ?? _accessToken;
    _refreshToken = refreshToken ?? _refreshToken;
    _phoneNumber = phoneNumber ?? _phoneNumber;
    _password = password ?? _password;
    // await HiveManager.put(
    //   AppConstant.hiveSessionKey,
    //   {
    //     'currentUser': _currentUser?.toJson(),
    //     'accessToken': _accessToken,
    //     'refreshToken': _refreshToken,
    //   },
    // );
    await AppStorage.putSession(
      {
        'currentUser': _currentUser?.toJson(),
        'accessToken': _accessToken,
        'refreshToken': _refreshToken,
        'phoneNumber': _phoneNumber,
        'password': _password,
      },
    );
  }

  cancelSession() {
    _currentUser = null;
    _accessToken = null;
  }

  Future<void> forceLogOut() async {
    // Get.offAll(const LoginScreen());
    if (Get.currentRoute != AppRoutes.login) {
      Get.offAllNamed(AppRoutes.login);
    }
    AppManager().cancelSession();
    await HiveManager.delete(AppConstant.hiveSessionKey);
  }

  Future<void> refreshSession({
    required String phone,
    required String password,
  }) async {
    final result = await AuthRepoImpl().login(
      phoneNumber: phone,
      password: password,
    );
    if (result.isSuccess()) {
      setSession(newAccessToken: result.data['accessToken']);
      final userModel = await UserRepoIml().getCurrentUser(
        accessToken: result.data['accessToken'],
      );
      if (userModel.isSuccess()) {
        setSession(
          newUser: userModel.data,
          newAccessToken: result.data['accessToken'],
          refreshToken: result.data['refreshToken'],
          phoneNumber: phone,
          password: password,
        );
      } else {
        forceLogOut();
      }
    } else {
      forceLogOut();
    }
  }

  updateApp() async {
    if (Platform.isAndroid) {
      InAppUpdateManager manager = InAppUpdateManager();
      AppUpdateInfo? appUpdateInfo = await manager.checkForUpdate();
      if (appUpdateInfo == null) return;
      if (appUpdateInfo.updateAvailability ==
          UpdateAvailability.developerTriggeredUpdateInProgress) {
        //If an in-app update is already running, resume the update.
        String? message =
            await manager.startAnUpdate(type: AppUpdateType.immediate);
        debugPrint(message ?? '');
      } else if (appUpdateInfo.updateAvailability ==
          UpdateAvailability.updateAvailable) {
        ///Update available
        if (appUpdateInfo.immediateAllowed) {
          String? message =
              await manager.startAnUpdate(type: AppUpdateType.immediate);
          debugPrint(message ?? '');
        } else if (appUpdateInfo.flexibleAllowed) {
          String? message =
              await manager.startAnUpdate(type: AppUpdateType.flexible);
          debugPrint(message ?? '');
        } else {
          debugPrint(
              'Update available. Immediate & Flexible Update Flow not allow');
        }
      }
    }
  }
}
