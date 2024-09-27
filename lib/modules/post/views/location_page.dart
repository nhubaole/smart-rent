import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/config/app_colors.dart';
import '/core/model/location/city.dart';
import '/core/model/location/district.dart';
import '/core/model/location/ward.dart';
import '/modules/post/controllers/post_controller.dart';

import '../../../core/values/app_colors.dart';

List<String> list = <String>['One', 'Two', 'Three', 'Four'];

class LocationPage extends StatefulWidget {
  const LocationPage({super.key});

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  final PostController controller = Get.find<PostController>();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
        child: SingleChildScrollView(
          child: Form(
            key: controller.formInfoKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Địa chỉ',
                  style: TextStyle(
                      color: AppColors.primary40,
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 20,
                ),

                //---------------------City-------------------------
                const Text(
                  'THÀNH PHỐ',
                  style: TextStyle(
                      color: AppColors.secondary40,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 10,
                ),
                Obx(
                  () => DropdownButtonFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: InputDecoration(
                      focusedBorder: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: AppColors.primary40, width: 2)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4)),
                    ),
                    hint: const Text('Bấm để chọn Thành Phố'),
                    isExpanded: true,
                    isDense: true,
                    items: controller.cities
                        .map(
                          (item) => DropdownMenuItem(
                            value: item,
                            child: Text(item.name),
                          ),
                        )
                        .toList(),
                    onChanged: (value) async {
                      controller.selectedCity.value = value as City;
                      controller.selectedDistrict.value = null;
                      controller.districts.value = await controller
                          .loadDistricts(controller.selectedCity.value!);
                      controller.selectedWard.value = null;
                    },
                    value: controller.selectedCity.value,
                    validator: (value) => controller
                        .fieldValidator(value == null ? '' : value.name),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),

                //---------------------District-------------------------
                const Text(
                  'QUẬN / HUYỆN',
                  style: TextStyle(
                      color: AppColors.secondary40,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 10,
                ),
                Obx(
                  () => DropdownButtonFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: InputDecoration(
                      focusedBorder: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: AppColors.primary40, width: 2)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4)),
                    ),
                    hint: const Text('Bấm để chọn Quận / Huyện'),
                    isExpanded: true,
                    isDense: true,
                    items: controller.districts.value
                        .map(
                          (item) => DropdownMenuItem(
                            value: item,
                            child: Text(item.name),
                          ),
                        )
                        .toList(),
                    onChanged: (value) async {
                      controller.selectedDistrict.value = value as District;
                      controller.selectedWard.value = null;
                      controller.wards.value = await controller
                          .loadWards(controller.selectedDistrict.value!);
                    },
                    value: controller.selectedDistrict.value,
                    validator: (value) => controller
                        .fieldValidator(value == null ? '' : value.name),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),

                //---------------------Ward-------------------------
                const Text(
                  'PHƯỜNG / XÃ',
                  style: TextStyle(
                      color: AppColors.secondary40,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 10,
                ),
                Obx(
                  () => DropdownButtonFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: InputDecoration(
                      focusedBorder: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: AppColors.primary40, width: 2)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4)),
                    ),
                    hint: const Text('Bấm để chọn Phường / Xã'),
                    isExpanded: true,
                    isDense: true,
                    items: controller.wards.value
                        .map(
                          (item) => DropdownMenuItem(
                            value: item,
                            child: Text(item.name),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      controller.selectedWard.value = value as Ward;
                    },
                    value: controller.selectedWard.value,
                    validator: (value) => controller
                        .fieldValidator(value == null ? '' : value.name),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),

                //---------------------Street-------------------------
                const Text(
                  'TÊN ĐƯỜNG',
                  style: TextStyle(
                      color: AppColors.secondary40,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  validator: (value) => controller.fieldValidator(value!),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: controller.streetTextController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Ví dụ: Huỳnh Văn Bánh',
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: AppColors.primary40, width: 2)),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),

                //---------------------Address-------------------------
                const Text(
                  'SỐ NHÀ',
                  style: TextStyle(
                      color: AppColors.secondary40,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  validator: (value) => controller.fieldValidator(value!),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: controller.addressTextController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Ví dụ: 41/1A',
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: AppColors.primary40, width: 2),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
