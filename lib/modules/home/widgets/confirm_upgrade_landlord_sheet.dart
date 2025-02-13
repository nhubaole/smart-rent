import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:smart_rent/core/config/app_colors.dart';
import 'package:smart_rent/core/widget/outline_button_widget.dart';

class ConfirmUpgradeLandlordSheet extends StatelessWidget {
  final Function() onConfirm;
  const ConfirmUpgradeLandlordSheet({super.key, required this.onConfirm});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        padding: EdgeInsets.only(
          top: 10.px,
          right: 16.px,
          left: 16.px,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.px),
            topRight: Radius.circular(20.px),
          ),
        ),
        child: Column(
          children: [
            _buildHeader(),
            SizedBox(height: 16.px),
            Icon(
              Icons.info,
              color: AppColors.primary60,
              size: 120.px,
            ),
            SizedBox(height: 16.px),
            Text(
              'Thông báo',
              style: TextStyle(
                color: AppColors.secondary20,
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.px),
            Text.rich(
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.secondary20,
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
              ),
              TextSpan(
                children: [
                  TextSpan(text: 'Bạn cần chuyển sang'),
                  TextSpan(
                    text: ' tài khoản Chủ nhà ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(text: 'để có thể sử dụng tính năng này.'),
                ],
              ),
            ),
            SizedBox(height: 32.px),
            OutlineButtonWidget(
              text: 'Chuyển sang tài khoản Chủ nhà',
              onTap: () {
                Get.back();
                onConfirm();
              },
            ),
          ],
        ),
      ),
    );
  }

  Row _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(child: SizedBox()),
        IconButton(
          onPressed: () {
            FocusManager.instance.primaryFocus?.unfocus();
            Get.isBottomSheetOpen! ? Get.back() : null;
          },
          icon: const Icon(
            Icons.close,
            color: AppColors.secondary20,
          ),
        ),
      ],
    );
  }
}
