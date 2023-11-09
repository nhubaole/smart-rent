import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_rent/core/values/KEY_VALUE.dart';

class NotifySettingController extends GetxController {
  late SharedPreferences prefs;

  //late SharedPreferences prefs;
  var notifyNewRoom = false.obs;
  var notifyNewMessage = false.obs;
  var notifyNewLike = false.obs;
  var notifyNewSchedule = false.obs;

  get currentAccount => null;

  @override
  onInit() {
    super.onInit();
    initSharedPreferences();
  }

  Future<void> initSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
    prefs.containsKey(KeyValue.KEY_NOTIFY_NEWROOM)
        ? notifyNewRoom.value = prefs.getBool(KeyValue.KEY_NOTIFY_NEWROOM)!
        : true;
    prefs.containsKey(KeyValue.KEY_NOTIFY_NEWMESSAGE)
        ? notifyNewMessage.value =
            prefs.getBool(KeyValue.KEY_NOTIFY_NEWMESSAGE)!
        : true;
    prefs.containsKey(KeyValue.KEY_NOTIFY_NEWLIKE)
        ? notifyNewLike.value = prefs.getBool(KeyValue.KEY_NOTIFY_NEWLIKE)!
        : true;
    prefs.containsKey(KeyValue.KEY_NOTIFY_NEWSCHEDULE)
        ? notifyNewSchedule.value =
            prefs.getBool(KeyValue.KEY_NOTIFY_NEWSCHEDULE)!
        : true;
  }

  void savedShraredPreferences(String keyValue, bool status) async {
    //Get.snackbar('ontify', status.toString());
    await prefs.setBool(keyValue, status);
  }
}
