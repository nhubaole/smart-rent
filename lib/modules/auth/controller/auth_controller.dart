import 'package:get/get.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();

  var accessToken = Rx<String?>(null);
  var refreshToken = Rx<String?>(null);

  setAccessToken(String value) {
    accessToken.value = value;
  }

  setRefresehToken(String value) {
    refreshToken.value = value;
  }

  clearInfo() {
    accessToken.value = null;
    refreshToken.value = null;
  }
}
