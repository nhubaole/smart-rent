import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_rent/core/values/KEY_VALUE.dart';
import 'package:smart_rent/core/values/app_colors.dart';
import 'package:smart_rent/modules/manage_account/controllers/nav_controller/notity_setting_controller.dart';

class NotifySettingScreen extends StatefulWidget {
  const NotifySettingScreen({super.key});

  @override
  State<NotifySettingScreen> createState() => _NotifySettingScreenState();
}

class _NotifySettingScreenState extends State<NotifySettingScreen> {
  final NotifySettingController notifyController =
      Get.put(NotifySettingController());
  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    notifyController.initSharedPreferences();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Thông báo',
          style: TextStyle(
            color: primary40,
            fontSize: 22,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Obx(
              () => SwitchListTile(
                value: notifyController.notifyNewRoom.value,
                onChanged: (isChecked) {
                  notifyController.notifyNewRoom.value = isChecked;
                  notifyController.savedShraredPreferences(
                      KeyValue.KEY_NOTIFY_NEWROOM, isChecked);
                },
                title: Text(
                  'Phòng trọ mới',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground),
                ),
                subtitle: Text(
                  'Thông báo khi có phòng trọ mới',
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground),
                ),
                activeColor: Colors.white,
                contentPadding: const EdgeInsets.only(
                  left: 34,
                  right: 22,
                ),
                activeTrackColor: primary60,
              ),
            ),
            Obx(
              () => SwitchListTile(
                value: notifyController.notifyNewMessage.value,
                onChanged: (isChecked) {
                  notifyController.notifyNewMessage.value = isChecked;
                  notifyController.savedShraredPreferences(
                      KeyValue.KEY_NOTIFY_NEWMESSAGE, isChecked);
                },
                title: Text(
                  'Tin nhắn mới',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground),
                ),
                subtitle: Text(
                  'Thông báo khi có tin nhắn mới',
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground),
                ),
                activeColor: Colors.white,
                contentPadding: const EdgeInsets.only(
                  left: 34,
                  right: 22,
                ),
                activeTrackColor: primary60,
              ),
            ),
            Obx(
              () => SwitchListTile(
                value: notifyController.notifyNewLike.value,
                onChanged: (isChecked) {
                  notifyController.notifyNewLike.value = isChecked;
                  notifyController.savedShraredPreferences(
                      KeyValue.KEY_NOTIFY_NEWLIKE, isChecked);
                },
                title: Text(
                  'Lượt thích mới',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground),
                ),
                subtitle: Text(
                  'Thông báo khi có lượt thích mới',
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground),
                ),
                activeColor: Colors.white,
                contentPadding: const EdgeInsets.only(
                  left: 34,
                  right: 22,
                ),
                activeTrackColor: primary60,
              ),
            ),
            Obx(
              () => SwitchListTile(
                value: notifyController.notifyNewSchedule.value,
                onChanged: (isChecked) {
                  notifyController.notifyNewSchedule.value = isChecked;
                  notifyController.savedShraredPreferences(
                      KeyValue.KEY_NOTIFY_NEWSCHEDULE, isChecked);
                },
                title: Text(
                  'Lịch hẹn mới',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground),
                ),
                subtitle: Text(
                  'Thông báo khi có lịch hẹn mới',
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground),
                ),
                activeColor: Colors.white,
                contentPadding: const EdgeInsets.only(
                  left: 34,
                  right: 22,
                ),
                activeTrackColor: primary60,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
