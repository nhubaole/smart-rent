import 'dart:async';

import 'package:flutter/material.dart';
import '../../../../core/config/app_colors.dart';
import '/core/values/app_colors.dart';

import '../widgets/text_field_otp.dart';

class DialogOTP extends StatefulWidget {
  final String phoneNumber;
  final Function(String) callBack;

  const DialogOTP({
    super.key,
    required this.phoneNumber,
    required this.callBack,
  });

  @override
  State<DialogOTP> createState() => _DialogOTPState();
}

class _DialogOTPState extends State<DialogOTP> {
  Duration duration = const Duration(minutes: 5);
  late Timer timer;

  @override
  void initState() {
    super.initState();

    // timer = Timer.periodic(
    //   const Duration(seconds: 1),
    //   (Timer timer) {
    //     setState(() {
    //       if (duration.inSeconds > 0) {
    //         duration = Duration(seconds: duration.inSeconds - 1);
    //       } else {
    //         timer.cancel();
    //       }
    //     });
    //   },
    // );

    if (mounted) {
      timer = Timer.periodic(
        const Duration(seconds: 1),
        (Timer timer) {
          setState(() {
            if (duration.inSeconds > 0) {
              duration = Duration(seconds: duration.inSeconds - 1);
            } else {
              timer.cancel();
            }
          });
        },
      );
    }
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String minutes = duration.inMinutes.toString().padLeft(2, '0');
    String seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Container(
        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16, top: 8),
        height: 300.0,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            _buildTopComponent(context),
            _buildDetailPhone(),
            const SizedBox(height: 20),
            OtpTextField(
              fieldHeight: 60,
              numberOfFields: 4,
              focusedBorderColor: Colors.transparent,
              disabledBorderColor: Colors.transparent,
              borderColor: Colors.transparent,
              enabledBorderColor: Colors.transparent,
              onSubmit: (value) {
                widget.callBack(value);
              },
              alignment: Alignment.center,
            ),
            const SizedBox(height: 20),
            _buildTimer(),
            duration.inSeconds == 0
                ? TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Gửi lại OTP',
                      style: TextStyle(
                        color: AppColors.primary60,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }

  Text _buildTimer() {
    return Text.rich(
      TextSpan(
        children: [
          const TextSpan(
            text: 'Có thể lấy lại OTP sau ',
            style: TextStyle(
              color: AppColors.primary40,
            ),
          ),
          TextSpan(
            text:
                '${duration.inMinutes < 10 ? '0${duration.inMinutes}' : duration.inMinutes}:${duration.inSeconds % 60 < 10 ? '0${duration.inSeconds % 60}' : duration.inSeconds % 60}',
            style: const TextStyle(
              color: Colors.red,
            ),
          ),
          const TextSpan(
            text: ' s',
            style: TextStyle(
              color: AppColors.primary40,
            ),
          ),
        ],
      ),
    );
  }

  Text _buildDetailPhone() {
    return Text.rich(
      TextSpan(
        children: [
          const TextSpan(
            text: 'Vui lòng nhập mã OTP được gửi đến số điện thoại ',
            style: TextStyle(
              color: Colors.black54,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
          TextSpan(
            text: widget.phoneNumber,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Row _buildTopComponent(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Nhập OTP',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
        IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.close,
          ),
        ),
      ],
    );
  }
}
