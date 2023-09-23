import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_rent/core/values/app_colors.dart';
import 'package:smart_rent/modules/signup/controlllers/sign_up_controllers.dart';

class DialogCustom extends StatelessWidget {
  final String iconPath;
  final String title;
  final String subTitle;
  final void Function() onPressed;
  final Color backgroundColor;
  const DialogCustom({
    super.key,
    required this.onPressed,
    required this.backgroundColor,
    required this.iconPath,
    required this.title,
    required this.subTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CardDialog(
              backgroundColor: backgroundColor,
              iconPath: iconPath,
              title: title,
              subTitle: subTitle,
              onPressed: onPressed),
          Positioned(
            height: 28,
            width: 28,
            top: 0,
            right: 0,
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.all(2),
                shape: const CircleBorder(
                  side: BorderSide(
                    color: Colors.black,
                  ),
                ),
                backgroundColor: const Color(0xFFec5858),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Icon(
                Icons.close,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CardDialog extends StatelessWidget {
  const CardDialog({
    super.key,
    required this.backgroundColor,
    required this.iconPath,
    required this.title,
    required this.subTitle,
    required this.onPressed,
  });

  final Color backgroundColor;
  final String iconPath;
  final String title;
  final String subTitle;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignUpController());
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 32,
        vertical: 16,
      ),
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 24,
          ),
          Image.asset(
            iconPath,
            fit: BoxFit.cover,
          ),
          const SizedBox(
            height: 24,
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: GoogleFonts.ubuntuCondensed(
              color: Colors.black,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            subTitle,
            textAlign: TextAlign.center,
            style: GoogleFonts.ubuntuCondensed(
              color: secondary20,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              OutlinedButton(
                onPressed: onPressed,
                style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 32,
                    ),
                    foregroundColor: const Color(0xFFEC5B5B),
                    side: const BorderSide(
                      color: Color(0XFFEC5B5B),
                    )),
                child: const Text('Đồng ý'),
              ),
            ],
          ),
          const SizedBox(
            height: 24,
          ),
        ],
      ),
    );
  }
}
