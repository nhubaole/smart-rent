import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ErrorCustomWidget extends StatelessWidget {
  final Widget? child;
  final Widget? imageWidget;
  final String? title;
  final bool? expandToCanPullToRefresh;
  final double? minHeight;
  const ErrorCustomWidget({
    super.key,
    this.child,
    this.expandToCanPullToRefresh,
    this.title,
    this.minHeight,
    this.imageWidget,
  });


  @override
  Widget build(BuildContext context) {
    final main = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        if (imageWidget != null) imageWidget!,
        Text(title ?? 'Có lỗi xảy ra'),
        if (child != null) child!,
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
