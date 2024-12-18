import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:smart_rent/core/di/getit_config.dart';
import 'package:smart_rent/core/repositories/log/log.dart';

class SRMethodChannel {
  static Log log = getIt<Log>();
  static const platform = MethodChannel('com.builtlab.smartrent/reminder');

  static Future<bool> requestCalendarPermission() async {
    if (await Permission.calendarFullAccess.isGranted) {
      return true;
    }

    PermissionStatus status = await Permission.calendarFullAccess.request();

    if (status.isGranted) {
      return true;
    } else if (status.isPermanentlyDenied) {
      openAppSettings();
      return false;
    }

    return false;
  }

  static Future<void> createReminder({
    required String title,
    required String description,
    required String location,
    required DateTime startTime,
    required DateTime endTime,
  }) async {
    try {
      if (!await requestCalendarPermission()) {
        return;
      }
      final result = await platform.invokeMethod(
        'createReminder',
        {
          'title': title,
          'description': description,
          'location': location,
          'startTime': startTime.millisecondsSinceEpoch,
          'endTime': endTime.millisecondsSinceEpoch,
        },
      );

      log.d('[SRMethodChannel][createReminder]', '$result');
    } on PlatformException catch (e) {
      log.e('[SRMethodChannel][createReminder]', '${e.message}');
    }
  }
}
