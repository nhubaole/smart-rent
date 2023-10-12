import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:smart_rent/core/values/KEY_VALUE.dart';

class NotifySettingController extends GetxController {
  final box = GetStorage();
  //late SharedPreferences prefs;
  var notifyNewRoom = false.obs;
  var notifyNewMessage = false.obs;
  var notifyNewLike = false.obs;
  var notifyNewSchedule = false.obs;

  @override
  void onInit() {
    super.onInit();

    notifyNewRoom.value = box.read(KeyValue.KEY_NOTIFY_NEWROOM) as bool;
    notifyNewMessage.value = box.read(KeyValue.KEY_NOTIFY_NEWMESSAGE) as bool;
    notifyNewLike.value = box.read(KeyValue.KEY_NOTIFY_NEWLIKE) as bool;
    notifyNewSchedule.value = box.read(KeyValue.KEY_NOTIFY_NEWSCHEDULE) as bool;

    print('New room ${box.read(KeyValue.KEY_NOTIFY_NEWROOM)}');
    print('New mess ${box.read(KeyValue.KEY_NOTIFY_NEWMESSAGE)}');
    print('New like ${box.read(KeyValue.KEY_NOTIFY_NEWLIKE)}');
    print('New scehdule ${box.read(KeyValue.KEY_NOTIFY_NEWSCHEDULE)}');
  }

  void savedStorage() {
    box.write(KeyValue.KEY_NOTIFY_NEWROOM, notifyNewRoom.value);
    box.write(KeyValue.KEY_NOTIFY_NEWMESSAGE, notifyNewMessage.value);
    box.write(KeyValue.KEY_NOTIFY_NEWLIKE, notifyNewLike.value);
    box.write(KeyValue.KEY_NOTIFY_NEWSCHEDULE, notifyNewSchedule.value);
    print('saved');
  }

  bool onValue(String key) {
    return box.read(key);
  }
}
