import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_rent/core/model/location/city.dart';
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
    controller.selectedCity.value = controller.cities.first;

    return Expanded(
        child: Container(
      width: double.infinity,
      margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
      child: ListView(
        children: [
          Text(
            'Địa chỉ',
            style: TextStyle(
                color: primary40, fontSize: 18, fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: 20,
          ),

          //---------------------City-------------------------
          Text(
            'THÀNH PHỐ',
            style: TextStyle(
                color: secondary40, fontSize: 16, fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: 10,
          ),
          DropdownButtonFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: primary40, width: 2)),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(4)),
            ),
            hint: Text('Bấm để chọn Thành Phố'),
            isExpanded: true,
            isDense: true,
            value: controller.selectedCity.value.name,
            items: controller.cities.map((item) {
              return DropdownMenuItem(
                value: item,
                child: Text(item.name),
              );
            }).toList(),
            onChanged: (selectedItem) => setState(
              () {
                controller.selectedCity.value = selectedItem! as City;
              },
            ),
          ),
          SizedBox(
            height: 16,
          ),

          //---------------------District-------------------------
          Text(
            'QUẬN / HUYỆN',
            style: TextStyle(
                color: secondary40, fontSize: 16, fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: 10,
          ),
          DropdownButtonFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: primary40, width: 2)),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(4)),
            ),
            hint: Text('Bấm để chọn Quận / Huyện'),
            isExpanded: true,
            isDense: true,
            value: dropdownValue,
            items: list.map((item) {
              return DropdownMenuItem(
                value: item,
                child: Text(item),
              );
            }).toList(),
            validator: (value) =>
                value?.isEmpty ?? true ? 'Cannot Empty' : null,
            onChanged: (selectedItem) => setState(
              () {
                dropdownValue = selectedItem!;
              },
            ),
          ),
          SizedBox(
            height: 16,
          ),

          //---------------------Ward-------------------------
          Text(
            'PHƯỜNG / XÃ',
            style: TextStyle(
                color: secondary40, fontSize: 16, fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: 10,
          ),
          DropdownButtonFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: primary40, width: 2)),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(4)),
            ),
            hint: Text('Bấm để chọn Phường / Xã'),
            isExpanded: true,
            isDense: true,
            value: dropdownValue,
            items: list.map((item) {
              return DropdownMenuItem(
                value: item,
                child: Text(item),
              );
            }).toList(),
            validator: (value) =>
                value?.isEmpty ?? true ? 'Cannot Empty' : null,
            onChanged: (selectedItem) => setState(
              () {
                dropdownValue = selectedItem!;
              },
            ),
          ),
          SizedBox(
            height: 16,
          ),

          //---------------------Street-------------------------
          Text(
            'TÊN ĐƯỜNG',
            style: TextStyle(
                color: secondary40, fontSize: 16, fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
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
                color: secondary40, fontSize: 16, fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
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
    ));
  }
}
