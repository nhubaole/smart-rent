import 'package:get/get.dart';
import '../../../core/model/account/Account.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();

  var currentAccount = Rx<Account?>(null);
  var accessToken = Rx<String?>(null);
  var refreshToken = Rx<String?>(null);

  setAccessToken(String value) {
    accessToken.value = value;
  }

  setRefresehToken(String value) {
    refreshToken.value = value;
  }

  setCurrentAccount(Account value) {
    currentAccount.value = value;
  }

  clearInfo() {
    currentAccount.value = null;
    accessToken.value = null;
    refreshToken.value = null;
  }
}
