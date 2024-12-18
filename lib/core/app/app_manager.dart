import 'package:get/get.dart';
import 'package:smart_rent/core/app/app_hive.dart';
import 'package:smart_rent/core/config/app_constant.dart';
import 'package:smart_rent/core/model/user/user_model.dart';
import 'package:smart_rent/core/routes/app_routes.dart';

class AppManager {
  static final AppManager instance = AppManager._internal();
  factory AppManager() => instance;

  AppManager._internal();

  UserModel? _currentUser;
  UserModel? get currentUser => _currentUser;
  String? get fullName => _currentUser!.fullName;
  int? get userId => _currentUser!.id;
  String? _accessToken;
  String? _refreshToken;
  String? get accessToken => _accessToken;
  String? get refreshToken => _refreshToken;

  bool get isLogged => _currentUser != null && _accessToken != null;

  setSession({
    UserModel? newUser,
    String? newAccessToken,
    String? refreshToken,
  }) async {
    _currentUser = newUser ?? _currentUser;
    _accessToken = newAccessToken ?? _accessToken;
    _refreshToken = refreshToken ?? _refreshToken;
    await HiveManager.put(
      AppConstant.hiveSessionKey,
      {
        'currentUser': newUser?.toJson(),
        'accessToken': newAccessToken,
        'refreshToken': refreshToken,
      },
    );
  }

  cancelSession() {
    _currentUser = null;
    _accessToken = null;
  }

  Future<void> forceLogOut() async {
    // Get.offAll(const LoginScreen());
    Get.offAllNamed(AppRoutes.login);
    AppManager().cancelSession();
    await HiveManager.delete(AppConstant.hiveSessionKey);
  }
}
