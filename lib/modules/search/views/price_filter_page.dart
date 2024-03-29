import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:smart_rent/core/values/app_colors.dart';
import 'package:smart_rent/modules/search/controllers/filter_controller.dart';

// ignore: must_be_immutable
class PriceFilterPage extends StatelessWidget {
  PriceFilterPage({super.key});
  FilterController controller = Get.find();
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
                  "Từ",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: secondary20),
                ),
                const SizedBox(
                  height: 4,
                ),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: controller.fromPriceTextController,
                  readOnly: true,
                  decoration: const InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                    border: OutlineInputBorder(),
                    hintText: 'Nhập giá',
                    suffixText: '₫',
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: primary40, width: 2)),
                  ),
                ),
              ],
            )),
            const SizedBox(
              width: 20,
            ),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Đến",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: secondary20),
                ),
                const SizedBox(
                  height: 4,
                ),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: controller.toPriceTextController,
                  readOnly: true,
                  decoration: const InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                    border: OutlineInputBorder(),
                    hintText: 'Nhập giá',
                    suffixText: '₫',
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: primary40, width: 2)),
                  ),
                ),
              ],
            )),
          ],
        ),
        const SizedBox(
          height: 30,
        ),
        Obx(
          () => RangeSlider(
            activeColor: primary40,
            inactiveColor: primary95,
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
