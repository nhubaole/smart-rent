import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/config/app_colors.dart';
import '/core/enums/utilities.dart';
import '/modules/search/controllers/filter_controller.dart';

// ignore: must_be_immutable
class UtilFilterPage extends StatelessWidget {
  UtilFilterPage({super.key});
  FilterController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() => GridView.builder(
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 3,
            mainAxisSpacing: 8.0,
            crossAxisSpacing: 8.0,
          ),
          itemCount: controller.utilList.length,
          itemBuilder: (context, index) {
            return FilledButton.icon(
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.all(0),
                backgroundColor: controller.utilList[index].isChecked
                    ? AppColors.primary98
                    : AppColors.secondary90,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              onPressed: () {
                controller.utilList[index] = controller.utilList[index]
                    .copyWith(isChecked: !controller.utilList[index].isChecked);
                controller.setUtil();
              },
              icon: Icon(
                controller.utilList[index].utility.getIconUtil,
                size: 20,
                color: controller.utilList[index].isChecked
                    ? AppColors.primary40
                    : AppColors.secondary40,
              ),
              label: Text(
                controller.utilList[index].utility.getNameUtil,
                style: TextStyle(
                    fontSize: 12,
                    color: controller.utilList[index].isChecked
                        ? AppColors.primary40
                        : AppColors.secondary40,
                    fontWeight: FontWeight.w500),
              ),
            );
          },
        ));
  }
}
