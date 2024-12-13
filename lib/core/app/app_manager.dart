import 'package:get/get.dart';
import 'package:smart_rent/core/app/app_hive.dart';
import 'package:smart_rent/core/config/app_constant.dart';
import 'package:smart_rent/core/model/user_model.dart';
import 'package:smart_rent/modules/auth/login/views/login_screen.dart';

class AppManager {
  static final AppManager instance = AppManager._internal();
  factory AppManager() => instance;

  AppManager._internal();

  UserModel? _currentUser;
  String? get fullName => _currentUser!.fullName;
  int? get userId => _currentUser!.id;
  String? _accessToken;
  String? _refreshToken;
  String? get accessToken => _accessToken;
  String? get refreshToken => _refreshToken;

  bool get isLogged => _currentUser != null && _accessToken != null;

  setSession({
    required UserModel newUser,
    required String newAccessToken,
    required String refreshToken,
  }) async {
    _currentUser = newUser;
    _accessToken = newAccessToken;
    _refreshToken = refreshToken;
    await HiveManager().put(
      AppConstant.hiveSessionKey,
      {
        'currentUser': newUser.toJson(),
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
    Get.offAll(const LoginScreen());
    AppManager().cancelSession();
    await HiveManager().delete(AppConstant.hiveSessionKey);
  }
}
