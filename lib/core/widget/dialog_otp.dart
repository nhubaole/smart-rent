import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';
import 'package:smart_rent/core/model/account/Account.dart';
import 'package:smart_rent/core/model/values/utils.dart';
import 'package:smart_rent/core/values/app_colors.dart';
import 'package:smart_rent/modules/signup/controlllers/sign_up_verify_controller.dart';

class DialogOTP extends StatelessWidget {
  final String phoneNumber;
  final void Function() onPressed;
  final Color backgroundColor;
  final Account user;
  const DialogOTP(
      {super.key,
      required this.onPressed,
      required this.backgroundColor,
      required this.phoneNumber,
      required this.user});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Stack(
        children: [
          CardDialog(
            onPressed: onPressed,
            phoneNumber: phoneNumber,
            user: user,
          ),
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
    required this.phoneNumber,
    required this.onPressed,
    required this.user,
  });

  final String phoneNumber;
  final void Function() onPressed;
  final Account user;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignUpVerifyController());
    bool buttonPressed = false;
    var otp;
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Nhập OTP',
            style: GoogleFonts.ubuntuCondensed(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              children: [
                const TextSpan(
                  text: 'Vui lòng nhập mã OTP được gửi đến\nsố điện thoại ',
                  style: TextStyle(
                    color: secondary20,
                    fontSize: 14,
                  ),
                ),
                TextSpan(
                  text: phoneNumber,
                  style: const TextStyle(
                    color: secondary20,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 8,
            ),
            child: Pinput(
              length: 6,
              defaultPinTheme: defaultPinTheme,
              focusedPinTheme: focusedPinTheme,
              submittedPinTheme: submittedPinTheme,
              validator: (code) {
                otp = code;
                SignUpVerifyController.instance.verifyOTP(otp, user);
              },
              pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
              showCursor: true,
              onCompleted: (pin) {
                otp = pin;
                SignUpVerifyController.instance.verifyOTP(otp, user);
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              OutlinedButton(
                onPressed: () {
                  buttonPressed = true;
                },
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 32,
                  ),
                  foregroundColor: const Color(0xFFEC5B5B),
                  side: const BorderSide(
                    color: Color(0XFFEC5B5B),
                  ),
                ),
                child: const Text('Đồng ý'),
              )
            ],
          )
        ],
      ),
    );
  }
}
