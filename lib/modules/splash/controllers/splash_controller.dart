//splash controller

import 'package:flutter/material.dart';
import 'package:smart_rent/modules/login/views/login_screen.dart';

Future<void> navigatorHomeScreen(BuildContext context) async {
  Future.delayed(
    const Duration(
      seconds: 3,
    ),
    () {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) => const LoginScreen(),
        ),
      );
    },
  );
}
