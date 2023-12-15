import 'dart:convert';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:smart_rent/blank.dart';

class FirebaseFCM {
  final _fibaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotifications() async {
    NotificationSettings settings = await _fibaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    print('User granted permission: ${settings.authorizationStatus}');
    final fCMToken = await _fibaseMessaging.getToken();

    print(fCMToken);
    initPushNotifications();
  }

  Future<String> getCurrentToken() async {
    final token = await _fibaseMessaging.getToken();
    return token!.toString();
  }

  void handleMessageForeground(RemoteMessage? message) {
    if (message == null) return;

    // Get.to(
    //   () => Blank(
    //     message: message,
    //   ),
    // );

    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 10,
        channelKey: 'basic_channel',
        title: message.notification!.title,
        body: message.notification!.body,
        payload: {
          'type': message.data['type'],
          'id': message.data['id'],
        },
      ),
      actionButtons: [
        NotificationActionButton(
            key: 'AGREED1', label: 'I agree', autoDismissible: true),
        NotificationActionButton(
            key: 'AGREED2', label: 'I agree too', autoDismissible: true),
      ],
    );
  }

  void handleMessage(RemoteMessage? message) {
    if (message == null) return;
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 10,
        channelKey: 'basic_channel',
        title: message.notification!.title,
        body: message.notification!.body,
      ),
      actionButtons: [
        NotificationActionButton(
          key: 'AGREED1',
          label: 'I agree',
          autoDismissible: true,
        ),
        NotificationActionButton(
            key: 'AGREED2', label: 'I agree too', autoDismissible: true),
      ],
    );

    // Get.to(() => NotificationScreen(
    //       message: message,
    //     ));
  }

  Future initPushNotifications() async {
    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
    FirebaseMessaging.onMessage.listen(handleMessageForeground);
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
  }

  Future<String> sendNotificationHTTP(
    String senderUid,
    String receiverUid,
    String receiverTokenFCM,
    String typeNoti,
    String title,
    String body,
  ) async {
    String res = 'Something went wrong';
    try {
      _fibaseMessaging.getToken().then((value) async {
        var data = {
          'to': receiverTokenFCM,
          'priority': 'high',
          'notification': {
            'title': title,
            'body': body,
          }
        };
        var response = await http.post(Uri.parse(dotenv.get('fcm_google_url')),
            body: jsonEncode(data),
            headers: {
              'Content-Type': 'application/json; charset=UTF-8',
              'Authorization': 'key=${dotenv.get('server_key')}',
            });
        print(response.statusCode);
      });
    } catch (e) {
      Get.snackbar('title', e.toString());
    }
    return res;
  }
}
