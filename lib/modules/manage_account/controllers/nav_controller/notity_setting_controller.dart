import 'package:get/get.dart';
import 'package:smart_rent/core/values/KEY_VALUE.dart';

class NotifySettingController extends GetxController {
  //late SharedPreferences prefs;
  var notifyNewRoom = false.obs;
  var notifyNewMessage = false.obs;
  var notifyNewLike = false.obs;
  var notifyNewSchedule = false.obs;

  @override
  void onInit() {
    super.onInit();
  }

  void savedStorage() {}

  bool onValue(String key) {
    return true;
  }
}
