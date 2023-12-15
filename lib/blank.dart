import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
          ],
        ),
      ),
    );
  }
}
