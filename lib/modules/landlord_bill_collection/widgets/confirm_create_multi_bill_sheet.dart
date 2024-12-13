import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:smart_rent/core/config/app_colors.dart';
import 'package:smart_rent/core/widget/outline_button_widget.dart';
import 'package:smart_rent/core/widget/solid_button_widget.dart';

class ConfirmCreateMultiBillSheet extends StatelessWidget {
  final String period;
  final int billCounter;
  final Function() onConfirm;
  const ConfirmCreateMultiBillSheet({
    super.key,
    required this.period,
    required this.billCounter,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        padding: EdgeInsets.only(
          top: 10.px,
          right: 16.px,
          left: 16.px,
          bottom: 16.px,
        ),
        constraints: BoxConstraints(minHeight: Get.height / 3),
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.px),
            topRight: Radius.circular(20.px),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildHeader(),
            SizedBox(height: 16.px),
            _buildIcon(),
            SizedBox(height: 16.px),
            Text(
              'notification'.tr,
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.normal,
                color: AppColors.secondary20,
              ),
            ),
            SizedBox(height: 16.px),
            _buildTextContent(),
            SizedBox(height: 32.px),
            _buildGroupButtons(),
            SizedBox(height: 16.px),
          ],
        ),
      ),
    );
  }

  Padding _buildTextContent() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 32.px),
      child: Text.rich(
        textAlign: TextAlign.center,
        TextSpan(
          children: [
            TextSpan(
              text: 'confirmation_message'
                  .tr
                  .replaceAll('@period', period)
                  .replaceAll('@quantity', billCounter.toString()),
            ),
          ],
        ),
      ),
    );
  }

  Row _buildGroupButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: OutlineButtonWidget(
            text: 'cancel'.tr,
            onTap: () => Get.back(),
            borderRadius: BorderRadius.circular(100.px),
          ),
        ),
        SizedBox(width: 16.px),
        Expanded(
          child: SolidButtonWidget(
            text: 'confirm'.tr,
            onTap: onConfirm,
            borderRadius: BorderRadius.circular(100.px),
          ),
        )
      ],
    );
  }

  CircleAvatar _buildIcon() {
    return CircleAvatar(
      radius: 40.px,
      backgroundColor: AppColors.primary60,
      child: Icon(
        FontAwesomeIcons.info,
        color: AppColors.white,
        size: 40.px,
      ),
    );
  }

  Row _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.max,
      children: [
        IconButton(
          onPressed: () => Get.isBottomSheetOpen! ? Get.back() : null,
          icon: const Icon(
            Icons.close,
            color: AppColors.secondary20,
          ),
        ),
      ],
    );
  }
}
