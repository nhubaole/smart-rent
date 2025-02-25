import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:smart_rent/core/config/app_colors.dart';
import 'package:smart_rent/core/widget/outline_text_filed_widget.dart';
import '/modules/search/controllers/filter_controller.dart';

// ignore: must_be_immutable
class PriceFilterPage extends StatelessWidget {
  PriceFilterPage({super.key});
  FilterController controller = Get.find<FilterController>();
  final currencyFormat = NumberFormat.currency(locale: 'vi_VN', symbol: '');

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Từ',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: AppColors.secondary20),
                ),
                SizedBox(height: 4.px),
                // TextFormField(
                //   autovalidateMode: AutovalidateMode.onUserInteraction,
                //   controller: controller.fromPriceTextController,
                //   readOnly: true,
                //   decoration: const InputDecoration(
                //     contentPadding:
                //         EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                //     border: OutlineInputBorder(),
                //     hintText: 'Nhập giá',
                //     suffixText: '₫',
                //     focusedBorder: OutlineInputBorder(
                //         borderSide:
                //             BorderSide(color: AppColors.primary40, width: 2)),
                //   ),
                // ),
                OutlineTextFiledWidget(
                  textEditingController: controller.fromPriceTextController,
                  onValidateString: 'Nhập giá',
                  hintText: 'Nhập giá',
                  suffixUnit: '₫',
                  readOnly: true,
                  onTap: () {},
                ),
              ],
            )),
            SizedBox(width: 20.px),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Đến',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: AppColors.secondary20),
                ),
                SizedBox(height: 4.px),
                OutlineTextFiledWidget(
                  textEditingController: controller.toPriceTextController,
                  onValidateString: 'Nhập giá',
                  hintText: 'Nhập giá',
                  suffixUnit: '₫',
                  readOnly: true,
                  onTap: () {},
                ),
              ],
            )),
          ],
        ),
        SizedBox(height: 30.px),
        Obx(
          () => RangeSlider(
            activeColor: AppColors.primary40,
            inactiveColor: AppColors.primary95,
            values: controller.currentRangeValues.value,
            max: 50000000,
            divisions: 50,
            labels: RangeLabels(
              currencyFormat
                  .format(controller.currentRangeValues.value.start.round()),
              currencyFormat
                  .format(controller.currentRangeValues.value.end.round()),
            ),
            onChanged: (RangeValues values) {
              controller.setPrice(values);
            },
          ),
        )
      ],
    );
  }
}
