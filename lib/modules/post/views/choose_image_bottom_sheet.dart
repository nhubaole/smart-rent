import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/config/app_colors.dart';
import '/core/values/app_colors.dart';

class ChooseImageBottomSheet extends StatelessWidget {
  const ChooseImageBottomSheet({
    super.key,
    required this.onGallarySelected,
    required this.onCameraSelected,
    required this.messageRequestPermission,
  });

  final Future<void> Function() onCameraSelected;
  final Future<void> Function() onGallarySelected;
  final String messageRequestPermission;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(width: 20),
                const Text(
                  'Chọn ảnh',
                  style: TextStyle(
                      color: AppColors.primary40,
                      fontSize: 20,
                      fontWeight: FontWeight.w700),
                ),
                GestureDetector(
                    onTap: () => Get.back(),
                    child: const Icon(
                      Icons.close,
                      color: AppColors.secondary40,
                    )),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.primary98),
              child: InkWell(
                onTap: () async {
                  await onGallarySelected();
                  Get.back();
                },
                child: Container(
                  padding: const EdgeInsets.all(20),
                  child: const Row(
                    children: [
                      Icon(
                        Icons.image_outlined,
                        color: AppColors.primary60,
                      ),
                      SizedBox(width: 8),
                      Text(
                        'Chọn từ thư viện',
                        style: TextStyle(
                            color: AppColors.primary60,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.primary98),
              child: InkWell(
                onTap: () async {
                  await onCameraSelected();
                  Get.back();
                },
                child: Container(
                  padding: const EdgeInsets.all(16),
                  child: const Row(
                    children: [
                      Icon(
                        Icons.photo_camera_outlined,
                        color: AppColors.primary60,
                      ),
                      SizedBox(width: 8),
                      Text(
                        'Chụp ảnh',
                        style: TextStyle(
                            color: AppColors.primary60,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
