import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:smart_rent/core/widget/outline_text_filed_widget.dart';
// import 'package:quantity_input/quantity_input.dart';

import '../../../core/config/app_colors.dart';
import '/modules/search/controllers/filter_controller.dart';

// ignore: must_be_immutable
class CapacityFilterPage extends StatelessWidget {
  CapacityFilterPage({super.key});
  FilterController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                "Số người",
                style: TextStyle(fontSize: 16, color: AppColors.secondary20),
              ),
            ),
            // Obx(() => QuantityInput(
            //     readOnly: true,
            //     acceptsNegatives: false,
            //     acceptsZero: false,
            //     buttonColor: AppColors.primary60,
            //     decoration: const InputDecoration(
            //       contentPadding:
            //           EdgeInsets.symmetric(horizontal: 10, vertical: 0),
            //       border: OutlineInputBorder(),
            //       focusedBorder: OutlineInputBorder(
            //           borderSide:
            //               BorderSide(color: AppColors.primary40, width: 2)),
            //     ),
            //     value: controller.quantity.value,
            //     onChanged: (value) {
            //       controller.quantity.value =
            //           int.parse(value.replaceAll(',', ''));
            //       controller.setCapacity();
            //     })),

            SizedBox(width: 16.px),
            Expanded(
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      if (controller.quantity.value == 1) return;
                      controller.quantity.value--;
                      controller.setCapacity();
                    },
                    icon: Icon(
                      Icons.remove_circle,
                      color: AppColors.primary60,
                      size: 24.px,
                    ),
                  ),
                  Expanded(
                    child: OutlineTextFiledWidget(
                      textAlign: TextAlign.center,
                      textEditingController: controller.capacityController,
                      onValidateString: 'Nhập giá',
                      readOnly: true,
                      onTap: () {},
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      controller.quantity.value++;
                      controller.setCapacity();
                    },
                    icon: Icon(
                      Icons.add_circle,
                      color: AppColors.primary60,
                      size: 24.px,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          children: [
            Row(
              children: [
                Text(
                  "Giới tính",
                  style: TextStyle(fontSize: 16, color: AppColors.secondary20),
                ),
                SizedBox(width: 16.px),
              ],
            ),
            Expanded(
              child: SizedBox(
                width: 210,
                child: DefaultTabController(
                  length: 3,
                  child: TabBar(
                    indicatorColor: AppColors.primary40,
                    labelColor: AppColors.primary40,
                    unselectedLabelColor: AppColors.secondary40,
                    labelPadding: const EdgeInsets.symmetric(horizontal: 20),
                    isScrollable: true,
                    dividerColor: Colors.transparent,
                    tabs: const <Widget>[
                      Tab(
                        text: 'Nữ',
                      ),
                      Tab(
                        text: 'Nam',
                      ),
                      Tab(
                        text: 'Tất cả',
                      ),
                    ],
                    onTap: (value) {
                      controller.genderIdx.value = value;
                      controller.setCapacity();
                    },
                  ),
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}
