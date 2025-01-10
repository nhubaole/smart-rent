import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:smart_rent/core/config/app_colors.dart';
import 'package:smart_rent/core/widget/cache_image_widget.dart';

class ViewImageDialog extends StatefulWidget {
  final String? url;
  final List<String>? urls;
  final EdgeInsetsGeometry? margin;
  final bool? isLocal;
  final BoxFit? fit;
  const ViewImageDialog({
    super.key,
    required this.url,
    this.margin,
    required this.urls,
    this.isLocal,
    this.fit = BoxFit.cover,
  }) : assert(url != null || urls != null);

  @override
  State<ViewImageDialog> createState() => _ViewImageDialogState();

  static show({
    String? url,
    List<String>? urls,
    bool isSafeArea = true,
    bool barrierDismissible = false,
    Function()? onTapDialog,
    bool? isLocal = false,
    BoxFit? fit,
  }) async {
    await Get.dialog(
      barrierDismissible: isSafeArea,
      useSafeArea: barrierDismissible,
      GestureDetector(
        onTap: onTapDialog ?? () => Get.back(),
        child: ViewImageDialog(
          url: url,
          urls: urls,
          isLocal: isLocal,
          fit: fit,
        ),
      ),
    );
  }
}

class _ViewImageDialogState extends State<ViewImageDialog> {
  int currentIndex = 0;
  late PageController pageController;
  @override
  void initState() {
    pageController = PageController(initialPage: currentIndex);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.url != null) {
      return _buildImageWithPlatform();
    }
    return _buildWidgetWithListImage();
  }

  Widget _buildWidgetWithListImage() {
    return SafeArea(
      child: Container(
        height: Get.height / 2,
        margin: widget.margin ?? EdgeInsets.all(16.px),
        decoration: const BoxDecoration(
          color: Color.fromARGB(0, 14, 9, 9),
        ),
        child: _buildImageNetwork(),
      ),
    );
  }

  Widget _buildImageLocal() {
    return SafeArea(
      child: Container(
        height: Get.height / 2,
        margin: widget.margin ?? EdgeInsets.all(16.px),
        decoration: const BoxDecoration(
          color: Color.fromARGB(0, 14, 9, 9),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10.px),
          child: Image.file(
            File(widget.url!),
            fit: widget.fit,
          ),
        ),
      ),
    );
  }

  Stack _buildImageNetwork() {
    return Stack(
      children: [
        PageView.builder(
          controller: pageController,
          onPageChanged: (value) {
            setState(() {
              currentIndex = value;
            });
          },
          itemCount: widget.urls!.length,
          itemBuilder: (context, index) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(10.px),
              child: CacheImageWidget(
                imageUrl: widget.urls![index],
                shouldExtendCache: false,
              ),
            );
          },
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: Container(
            margin: EdgeInsets.all(16.px),
            padding: EdgeInsets.all(6.px),
            decoration: BoxDecoration(
              color: AppColors.primary40,
              borderRadius: BorderRadius.circular(4.px),
            ),
            child: Text(
              '${currentIndex + 1}/${widget.urls!.length}',
              style: TextStyle(
                color: AppColors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.none,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildImageWithPlatform() {
    return widget.isLocal! ? _buildImageLocal() : _buildWidgetWithOneImage();
  }

  Widget _buildWidgetWithOneImage() {
    return Container(
      margin: widget.margin ?? EdgeInsets.all(16.px),
      decoration: const BoxDecoration(
        color: AppColors.transparent,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.px),
        child: CacheImageWidget(
          imageUrl: widget.url!,
          shouldExtendCache: true,
        ),
      ),
    );
  }
}
