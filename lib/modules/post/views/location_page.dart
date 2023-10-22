import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_rent/core/model/location/city.dart';
import 'package:smart_rent/core/model/location/district.dart';
import 'package:smart_rent/core/model/location/ward.dart';
import 'package:smart_rent/modules/post/controllers/post_controller.dart';

import '../../../core/values/app_colors.dart';

List<String> list = <String>['One', 'Two', 'Three', 'Four'];

class LocationPage extends StatefulWidget {
  const LocationPage({super.key});

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  String dropdownValue = list.first;
  final PostController controller = Get.find<PostController>();

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
            width: double.infinity,
            margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: SingleChildScrollView(
                child: Form(
              key: controller.formInfoKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Địa chỉ',
                    style: TextStyle(
                        color: primary40,
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 20,
                  ),

                  //---------------------City-------------------------
                  Text(
                    'THÀNH PHỐ',
                    style: TextStyle(
                        color: secondary40,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Obx(
                    () => DropdownButtonFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: primary40, width: 2)),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4)),
                      ),
                      hint: Text('Bấm để chọn Thành Phố'),
                      isExpanded: true,
                      isDense: true,
                      items: controller.cities
                          .map((item) => DropdownMenuItem(
                              child: Text(item.name), value: item))
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
                  SizedBox(
                    height: 16,
                  ),

                  //---------------------District-------------------------
                  Text(
                    'QUẬN / HUYỆN',
                    style: TextStyle(
                        color: secondary40,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Obx(
                    () => DropdownButtonFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: primary40, width: 2)),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4)),
                      ),
                      hint: Text('Bấm để chọn Quận / Huyện'),
                      isExpanded: true,
                      isDense: true,
                      items: controller.districts.value
                          .map((item) => DropdownMenuItem(
                              child: Text(item.name), value: item))
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
                  SizedBox(
                    height: 16,
                  ),

                  //---------------------Ward-------------------------
                  Text(
                    'PHƯỜNG / XÃ',
                    style: TextStyle(
                        color: secondary40,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Obx(
                    () => DropdownButtonFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: primary40, width: 2)),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4)),
                      ),
                      hint: Text('Bấm để chọn Phường / Xã'),
                      isExpanded: true,
                      isDense: true,
                      items: controller.wards.value
                          .map((item) => DropdownMenuItem(
                              child: Text(item.name), value: item))
                          .toList(),
                      onChanged: (value) {
                        controller.selectedWard.value = value as Ward;
                      },
                      value: controller.selectedWard.value,
                      validator: (value) => controller
                          .fieldValidator(value == null ? '' : value.name),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),

                  //---------------------Street-------------------------
                  Text(
                    'TÊN ĐƯỜNG',
                    style: TextStyle(
                        color: secondary40,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    validator: (value) => controller.fieldValidator(value!),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: controller.streetTextController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Ví dụ: Huỳnh Văn Bánh',
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: primary40, width: 2)),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),

                  //---------------------Address-------------------------
                  Text(
                    'SỐ NHÀ',
                    style: TextStyle(
                        color: secondary40,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    validator: (value) => controller.fieldValidator(value!),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: controller.addressTextController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Ví dụ: 41/1A',
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: primary40, width: 2)),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                ],
              ),
            ))));
  }
}
