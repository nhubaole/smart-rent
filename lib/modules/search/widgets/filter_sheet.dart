import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:smart_rent/core/config/app_colors.dart';
import 'package:smart_rent/core/enums/filter_type.dart';
import 'package:smart_rent/core/widget/outline_button_widget.dart';
import 'package:smart_rent/core/widget/solid_button_widget.dart';

class FilterSheet extends StatelessWidget {
  final FilterType filterType;
  final Widget child;
  final Function()? onClose;
  final Function() onApply;
  final Function() onReset;
  const FilterSheet({
    super.key,
    required this.child,
    this.onClose,
    required this.onApply,
    required this.onReset,
    required this.filterType,
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
          children: [
            _buildHeader(),
            Expanded(child: child),
            Row(
              children: [
                Expanded(
                  child: OutlineButtonWidget(
                    padding: EdgeInsets.zero,
                    height: 50.px,
                    onTap: () {
                      onReset();
                      Get.isBottomSheetOpen!
                          ? Get.back<bool>(result: false)
                          : null;
                    },
                    text: 'Xóa bộ lọc',
                  ),
                ),
                SizedBox(width: 8.px),
                Expanded(
                  child: SolidButtonWidget(
                    padding: EdgeInsets.zero,
                    height: 50.px,
                    onTap: () {
                      onApply();
                      Get.isBottomSheetOpen!
                          ? Get.back<bool>(result: false)
                          : null;
                    },
                    text: 'Áp dụng',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Row _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text.rich(
          // style: TextStyle(
          //   fontWeight: FontWeight.bold,
          //   fontSize: 16,
          //   color: AppColors.secondary40,
          // ),
          TextSpan(
            children: [
              WidgetSpan(
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 8.px, vertical: 4.px),
                  child: Text(
                    'Bộ lọc',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16.sp,
                      color: AppColors.secondary40,
                    ),
                  ),
                ),
              ),
              TextSpan(text: ' '),
              WidgetSpan(
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 8.px, vertical: 4.px),
                  decoration: BoxDecoration(
                    color: AppColors.primary40,
                    borderRadius:
                        BorderRadius.circular(8.px), // Rounded corners
                  ),
                  child: Text(
                    filterType.getNameFilterType,
                    style: TextStyle(color: AppColors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
        IconButton(
          onPressed: () {
            if (onClose != null) {
              onClose!();
            }
            Get.isBottomSheetOpen! ? Get.back<bool>(result: false) : null;
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
