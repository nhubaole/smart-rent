import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:smart_rent/core/config/app_colors.dart';
import 'package:smart_rent/core/model/location/city.dart';
import 'package:smart_rent/core/model/location/district.dart';
import 'package:smart_rent/core/model/location/ward.dart';
import 'package:smart_rent/core/widget/outline_text_filed_widget.dart';
import 'package:smart_rent/modules/post/post_controller.dart';

List<String> list = <String>['One', 'Two', 'Three', 'Four'];

class LocationPage extends StatefulWidget {
  const LocationPage({super.key});

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  final PostRoomController controller = Get.find<PostRoomController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Form(
          key: controller.formKeyLocation,
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
              SizedBox(height: 20.px),
              //---------------------City-------------------------
              const Text(
                'THÀNH PHỐ',
                style: TextStyle(
                    color: AppColors.secondary40,
                    fontSize: 16,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 10.px),
              Obx(
                () => DropdownButtonFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColors.primary40,
                        width: 1,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.px),
                      borderSide: const BorderSide(
                        color: AppColors.secondary80,
                      ),
                    ),
                  ),
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: AppColors.secondary20,
                    fontWeight: FontWeight.w500,
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
              SizedBox(height: 16.px),
              //---------------------District-------------------------
              const Text(
                'QUẬN / HUYỆN',
                style: TextStyle(
                    color: AppColors.secondary40,
                    fontSize: 16,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 10.px),
              Obx(
                () => DropdownButtonFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: AppColors.secondary20,
                    fontWeight: FontWeight.w500,
                  ),
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColors.primary40,
                        width: 1,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.px),
                      borderSide: const BorderSide(
                        color: AppColors.secondary80,
                      ),
                    ),
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
              SizedBox(height: 16.px),
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
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: AppColors.secondary20,
                    fontWeight: FontWeight.w500,
                  ),
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColors.primary40,
                        width: 1,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.px),
                      borderSide: const BorderSide(
                        color: AppColors.secondary80,
                      ),
                    ),
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
              SizedBox(height: 16.px),
              //---------------------Street-------------------------
              const Text(
                'TÊN ĐƯỜNG',
                style: TextStyle(
                    color: AppColors.secondary40,
                    fontSize: 16,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 10.px),
              // TextFormField(
              //   validator: (value) => controller.fieldValidator(value!),
              //   autovalidateMode: AutovalidateMode.onUserInteraction,
              //   controller: controller.streetTextController,
              //   decoration: const InputDecoration(
              //     border: OutlineInputBorder(),
              //     hintText: 'Ví dụ: Huỳnh Văn Bánh',
              //     focusedBorder: OutlineInputBorder(
              //         borderSide:
              //             BorderSide(color: AppColors.primary40, width: 2)),
              //   ),
              // ),
              OutlineTextFiledWidget(
                textEditingController: controller.streetTextController,
                textInputType: TextInputType.numberWithOptions(
                    decimal: true, signed: true),
                hintText: 'Ví dụ: Huỳnh Văn Bánh',
                onValidate: (p0) {
                  if (p0 == null || p0.isEmpty) {
                    return 'Vui lòng nhập số tên đường';
                  }

                  return null;
                },
              ),
              SizedBox(height: 16.px),

              //---------------------Address-------------------------
              const Text(
                'SỐ NHÀ',
                style: TextStyle(
                    color: AppColors.secondary40,
                    fontSize: 16,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 10.px),
              // TextFormField(
              //   validator: (value) => controller.fieldValidator(value!),
              //   autovalidateMode: AutovalidateMode.onUserInteraction,
              //   controller: controller.addressTextController,
              //   decoration: const InputDecoration(
              //     border: OutlineInputBorder(),
              //     hintText: 'Ví dụ: 41/1A',
              //     focusedBorder: OutlineInputBorder(
              //       borderSide:
              //           BorderSide(color: AppColors.primary40, width: 2),
              //     ),
              //   ),
              // ),
              OutlineTextFiledWidget(
                textEditingController: controller.addressTextController,
                textInputType: TextInputType.numberWithOptions(
                    decimal: true, signed: true),
                hintText: 'Ví dụ: 41/1A',
                onValidate: (p0) {
                  if (p0 == null || p0.isEmpty) {
                    return 'Vui lòng nhập số tên đường';
                  }

                  return null;
                },
              ),
              SizedBox(height: 16.px),
            ],
          ),
        ),
      ),
    );
  }
}
