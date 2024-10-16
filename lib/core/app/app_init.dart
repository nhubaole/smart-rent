import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:smart_rent/core/app/app_hive.dart';
import 'package:smart_rent/core/config/app_constant.dart';
import 'package:smart_rent/core/di/getit_config.dart';

class AppInit {
  static init() async {
    WidgetsFlutterBinding.ensureInitialized();
    await HiveManager().init(AppConstant.hiveBoxName);
    AwesomeNotifications().initialize(
      null,
      [
        NotificationChannel(
          channelKey: 'basic_channel',
          channelName: 'Basic notifications',
          channelDescription: 'Notification channel for basic tests',
          defaultColor: Colors.teal,
          ledColor: Colors.teal,
          playSound: true,
          enableVibration: true,
        )
      ],
      debug: true,
    );
    await configureDependencies();
    await dotenv.load(fileName: ".env");
  }
}
