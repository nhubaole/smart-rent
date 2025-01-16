import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:smart_rent/core/config/app_colors.dart';

class ErrorCustomWidget extends StatelessWidget {
  final Widget? child;
  final Widget? imageWidget;
  final String? title;
  final bool? expandToCanPullToRefresh;
  final double? minHeight;
  final Widget? retryButton;
  const ErrorCustomWidget({
    super.key,
    this.child,
    this.expandToCanPullToRefresh,
    this.title,
    this.minHeight,
    this.imageWidget,
    this.retryButton,
  });


  @override
  Widget build(BuildContext context) {
    final main = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        if (imageWidget != null) imageWidget!,
        if (imageWidget == null)
          Column(
            children: [
              Icon(
                Icons.warning_amber,
                color: AppColors.red,
                size: 32.px,
              ),
              SizedBox(height: 16.px),
            ],
          ),
        Text(title ?? 'Mất kết nối'),
        if (child != null) child!,
        if (expandToCanPullToRefresh == true)
          retryButton ?? SizedBox(height: 16.px),
      ],
    );
    if (expandToCanPullToRefresh == true) {
      return SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          alignment: Alignment.center,
          constraints: BoxConstraints(minHeight: minHeight ?? Get.height),
          child: main,
        ),
      );
    }
    return main;
  }
}
