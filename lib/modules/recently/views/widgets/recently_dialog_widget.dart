import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:smart_rent/core/config/app_colors.dart';
import 'package:smart_rent/core/widget/outline_button_widget.dart';
import 'package:smart_rent/core/widget/solid_button_widget.dart';

class RecentlyDialogWidget extends StatelessWidget {
  const RecentlyDialogWidget({
    super.key,
    this.onConfirm,
    this.onCancel,
  });
  final Function()? onConfirm;
  final Function()? onCancel;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      backgroundColor: Colors.transparent,
      child: Container(
        padding: EdgeInsets.all(16.px),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.warning, color: AppColors.error, size: 48.px),
            SizedBox(height: 16.px),
            Align(
              alignment: Alignment.center,
              child: Text(
                'Bạn có chắc chắn muốn xóa lịch sử đã xem?',
                style: TextStyle(
                  color: AppColors.primary40,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 16.px),
            _buildGroupButtonActions(),
          ],
        ),
      ),
    );
  }

  Row _buildGroupButtonActions() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: OutlineButtonWidget(
            padding: EdgeInsets.symmetric(vertical: 8.px, horizontal: 16.px),
            text: 'Hủy',
            onTap: () {
              Get.back();
              onCancel?.call();
            },
          ),
        ),
        SizedBox(width: 16.px),
        Expanded(
          child: SolidButtonWidget(
            padding: EdgeInsets.symmetric(vertical: 8.px, horizontal: 16.px),
            text: 'Xóa ngay',
            onTap: () {
              Get.back();
              onConfirm?.call();
            },
          ),
        ),
      ],
    );
  }
}
