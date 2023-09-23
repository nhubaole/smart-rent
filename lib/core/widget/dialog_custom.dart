import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_rent/core/values/app_colors.dart';

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
                padding: const EdgeInsets.all(8),
                shape: const CircleBorder(),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Icon(Icons.close),
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
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(iconPath),
          const SizedBox(
            height: 24,
          ),
          Text(
            title,
            style: GoogleFonts.ubuntuCondensed(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            subTitle,
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
          )
        ],
      ),
    );
  }
}
