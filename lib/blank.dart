import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_rent/core/values/app_colors.dart';
import 'package:smart_rent/modules/root_view/views/root_screen.dart';

class Blank extends StatelessWidget {
  const Blank({
    super.key,
    required this.message,
    required this.screen,
  });
  final String message;
  final Widget screen;
  @override
  Widget build(BuildContext context) {
    Future<void> showDialogLoading(String message) async {
      Get.dialog(
        PopScope(
          canPop: false,
          child: Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  const CircularProgressIndicator(
                    color: primary60,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    message,
                    style: const TextStyle(color: primary60),
                  ),
                ],
              ),
            ),
          ),
        ),
        barrierDismissible: false,
      );
      await Future.delayed(const Duration(seconds: 2));
      Get.offAll(const RootScreen());
    }

    Future.delayed(const Duration(seconds: 0), () async {
      await showDialogLoading(message);
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Blank'),
      ),
      body: const Text('Blank'),
    );
  }
}
