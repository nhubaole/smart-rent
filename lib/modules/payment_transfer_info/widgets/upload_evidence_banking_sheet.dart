import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:smart_rent/core/config/app_colors.dart';
import 'package:smart_rent/core/values/image_assets.dart';
import 'package:smart_rent/core/widget/outline_button_widget.dart';

class UploadEvidenceBankingSheet extends StatelessWidget {
  final Function() onSave;
  const UploadEvidenceBankingSheet({
    super.key,
    required this.onSave,
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
            Text.rich(
              TextSpan(text: 'success_image'.tr),
            ),
            SizedBox(height: 16.px),
            _buildOptionImage(
              title: 'upload_image_from_library'.tr,
              onTap: () {},
              icon: ImageAssets.icAddGallery,
            ),
            SizedBox(height: 16.px),
            OutlineButtonWidget(
              text: 'save'.tr,
              onTap: () {
                Get.back();
                onSave();
              },
              borderRadius: BorderRadius.circular(100.px),
            ),
            SizedBox(height: 16.px),
          ],
        ),
      ),
    );
  }

  Row _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'upload_proof'.tr,
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
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

  Widget _buildOptionImage({
    required String title,
    String? icon,
    required Function() onTap,
  }) {
    return DottedBorder(
      color: AppColors.secondary60,
      padding: EdgeInsets.all(8.px),
      borderPadding: EdgeInsets.all(8.px),
      radius: Radius.circular(10.px),
      borderType: BorderType.RRect,
      child: Material(
        color: AppColors.transparent,
        child: InkWell(
          splashColor: AppColors.primary60.withOpacity(0.2),
          borderRadius: BorderRadius.circular(10.px),
          onTap: onTap,
          child: Container(
            padding: EdgeInsets.all(8.px),
            alignment: Alignment.center,
            width: double.infinity,
            height: 120.px,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                icon != null
                    ? Image.asset(
                        icon,
                        width: 40.px,
                        height: 40.px,
                      )
                    : Icon(
                        Icons.add_a_photo_outlined,
                        color: AppColors.primary60,
                        size: 40.px,
                      ),
                SizedBox(height: 8.px),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: AppColors.primary60,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
