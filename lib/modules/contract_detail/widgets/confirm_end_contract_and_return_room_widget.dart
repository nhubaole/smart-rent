import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:smart_rent/core/config/app_colors.dart';
import 'package:smart_rent/core/widget/outline_button_widget.dart';
import 'package:smart_rent/core/widget/solid_button_widget.dart';

class ConfirmEndContractAndReturnRoom extends StatelessWidget {
  final Function() onCancel;
  final Function() onConfirm;
  const ConfirmEndContractAndReturnRoom({
    super.key,
    required this.onCancel,
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
            Icon(
              Icons.info,
              color: AppColors.primary60,
              size: 100.px,
            ),
            SizedBox(height: 16.px),
            Center(
              child: Text(
                'Thông báo',
                style: TextStyle(
                  color: AppColors.secondary20,
                  fontWeight: FontWeight.w600,
                  fontSize: 20.sp,
                ),
              ),
            ),
            SizedBox(height: 16.px),
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: 16.px),
              child: Text(
                'Bạn có chắc chắn muốn kết thúc hợp đồng và tiến hành trả phòng?',
                style: TextStyle(
                  color: AppColors.secondary20,
                  fontWeight: FontWeight.w400,
                  fontSize: 16.sp,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 16.px),
            Row(
              children: [
                Expanded(
                  child: OutlineButtonWidget(
                    onTap: () {
                      Get.back();
                      onCancel();
                    },
                    text: 'Hủy',
                  ),
                ),
                SizedBox(width: 16.px),
                Expanded(
                  child: SolidButtonWidget(
                    text: 'Chắn chắn',
                    onTap: () {
                      Get.back();
                      onConfirm();
                    },
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Row _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(),
        IconButton(
          onPressed: () =>
              Get.isBottomSheetOpen! ? Get.back<bool>(result: false) : null,
          icon: const Icon(
            Icons.close,
            color: AppColors.secondary20,
          ),
        ),
      ],
    );
  }
}
