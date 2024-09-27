class AppManager {
  static final AppManager _instance = AppManager._internal();
  factory AppManager() => _instance;

  AppManager._internal();

  String? _currentUserName;
  String? get currentUsername => _currentUserName;
  String? _accessToken;
  String? _refreshToken;
  String? get accressToken => _accessToken;
  String? get refreshToken => _refreshToken;

  bool get isLogged => _currentUserName != null && _accessToken != null;

  setSession({
    required String newUserName,
    required String newAccessToken,
    required String refreshToken,
  }) {
    _currentUserName = newUserName;
    _accessToken = newAccessToken;
    _refreshToken = refreshToken;
  }

  cancelSession() {
    _currentUserName = null;
    _accessToken = null;
  }

  Future<void> forceLogOut() async {}
}
