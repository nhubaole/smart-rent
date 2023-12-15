import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_rent/core/resources/firebase_fcm.dart';

class Blank extends StatelessWidget {
  const Blank({
    super.key,
    required this.message,
  });
  final RemoteMessage message;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Blank'),
      ),
      body: Center(
        child: Column(
          children: [
            Text(message.notification!.title.toString()),
            Text(message.notification!.body.toString()),
            Text(message.data['content_type'].toString()),
            Text(message.data['value'].toString()),
            Text(message.messageId.toString()),
            Text(message.contentAvailable.toString()),
            Text(message.messageType.toString()),
            Text(message.senderId.toString()),
            OutlinedButton(
              onPressed: () async {
                FirebaseFCM().sendNotificationHTTP(
                  'x47CBjhEVvVD4sBVWMDkYHYgfcg1',
                  'x47CBjhEVvVD4sBVWMDkYHYgfcg1',
                  'ezQGy8_US6y_5MwjsgzPhW:APA91bHEIe6LEWkj42tPH6UURPBtvrgkgIuiVGDnZ2Km7Bwy8_Fp-UZn9mmZLSP8AuqVmVOXBmIqxZRcNFn-BSkR49zjqfOKWYwq6NlYYCyGJxxzvaPD18EbPWLYGZcPpFi-SqtvQ4z4',
                  'Save Data',
                  'This is content',
                  true,
                  'https://images.unsplash.com/photo-1682687982298-c7514a167088?q=80&w=2670&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                  'BILLING',
                );
              },
              child: const Text('Send Noti'),
            ),
          ],
        ),
      ),
    );
  }
}
