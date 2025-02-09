import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:smart_rent/core/config/app_colors.dart';
import 'package:smart_rent/core/helper/help_regex.dart';
import 'package:smart_rent/core/widget/alert_snackbar.dart';
import 'package:smart_rent/core/widget/outline_button_widget.dart';
import 'package:smart_rent/core/widget/outline_text_filed_widget.dart';

class ChoseScopeRadiusSheet extends StatelessWidget {
  const ChoseScopeRadiusSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController textEditingController = TextEditingController();
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        padding: EdgeInsets.only(
          top: 10.px,
          right: 16.px,
          left: 16.px,
          bottom: 16.px,
        ),
        constraints: BoxConstraints(minHeight: Get.height / 4),
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
            OutlineTextFiledWidget(
              textEditingController: textEditingController,
              textInputType: TextInputType.numberWithOptions(decimal: false),
              onValidate: (p0) => null,
              hintText: 'Nhập khoảng cách',
              suffixUnit: ' | km',
            ),
            SizedBox(height: 16.px),
            OutlineButtonWidget(
              text: 'Chọn',
              onTap: () {
                if (textEditingController.text.isEmpty) {
                  AlertSnackbar.show(
                      title: 'Lỗi nhập liệu',
                      message: 'Vui lòng nhập khoảng cách',
                      isError: true);
                  return;
                }

                if (!HelpRegex.isDistance(textEditingController.text)) {
                  AlertSnackbar.show(
                      title: 'Lỗi nhập liệu',
                      message: 'Khoảng cách không hợp lệ',
                      isError: true);
                  return;
                }

                Get.back(result: double.parse(textEditingController.text));
              },
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
        Text(
          'Phạm vi bán kính',
          style: TextStyle(
            color: AppColors.secondary40,
            fontWeight: FontWeight.w500,
            fontSize: 18.sp,
          ),
        ),
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
