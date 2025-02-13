import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/config/app_colors.dart';
import '/core/enums/sort.dart';
import '/modules/search/controllers/filter_controller.dart';

// ignore: must_be_immutable
class SortFilterPage extends StatelessWidget {
  SortFilterPage({super.key});
  FilterController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      radioSortItem(Sort.MOST_RELATED),
      const Divider(
        thickness: 0.7,
      ),
      radioSortItem(Sort.LATEST),
      const Divider(
        thickness: 0.7,
      ),
      radioSortItem(Sort.LOWEST_TO_HIGHEST),
      const Divider(
        thickness: 0.7,
      ),
      radioSortItem(Sort.HIGHEST_TO_LOWEST),
      const Divider(
        thickness: 0.7,
      ),
    ]);
  }

  Widget radioSortItem(Sort sort) {
    return Obx(() => RadioListTile<Sort>(
          activeColor: AppColors.primary40,
          visualDensity: const VisualDensity(
            horizontal: VisualDensity.minimumDensity,
            vertical: VisualDensity.minimumDensity,
          ),
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          contentPadding: const EdgeInsets.all(0),
          title: Text(
            sort.getNameSort(),
            style: const TextStyle(color: AppColors.secondary20, fontSize: 16),
          ),
          value: sort,
          // ignore: prefer_null_aware_operators
          groupValue: controller.filter.value.sortFilter == null
              ? null
              : controller.filter.value.sortFilter?.sort,
          onChanged: (Sort? value) {
            controller.setSort(value!);
          },
        ));
  }
}
