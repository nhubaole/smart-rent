import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smart_rent/core/enums/utilities.dart';
import 'package:smart_rent/core/model/room/util_item.dart';
import 'package:smart_rent/core/widget/button_fill.dart';
import 'package:smart_rent/modules/post/controllers/post_controller.dart';
import 'package:smart_rent/modules/post/views/choose_image_bottom_sheet.dart';

import '../../../core/values/app_colors.dart';

class UtilitiesPage extends StatefulWidget {
  const UtilitiesPage({super.key});

  @override
  State<UtilitiesPage> createState() => _UtilitiesPageState();
}

class _UtilitiesPageState extends State<UtilitiesPage> {
  final PostController controller = Get.find<PostController>();

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
      width: double.infinity,
      margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
      child: ListView(
        children: [
          Text(
            'Thông tin hình ảnh và tiện ích',
            style: TextStyle(
                color: primary40, fontSize: 18, fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: 20,
          ),

          //---------------------Image-------------------------
          Text(
            'HÌNH ẢNH',
            style: TextStyle(
                color: secondary40, fontSize: 16, fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: 10,
          ),
          GestureDetector(
              onTap: () async => controller.handleChooseImage(context),
              child: Obx(
                () => DottedBorder(
                  borderType: BorderType.RRect,
                  radius: Radius.circular(10),
                  dashPattern: [2, 2],
                  color: secondary40,
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(20),
                    child: controller.pickedImages.value!.isEmpty
                        ? UploadInstruction()
                        : Column(
                            children: [
                              GridView.builder(
                                shrinkWrap: true,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 4,
                                  mainAxisSpacing: 8.0,
                                  crossAxisSpacing: 20.0,
                                ),
                                itemCount:
                                    controller.pickedImages.value?.length,
                                itemBuilder: (context, index) {
                                  return ImageItem(controller
                                      .pickedImages.value!
                                      .elementAt(index));
                                },
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                'Đăng thêm hình ảnh',
                                style: TextStyle(
                                    color: primary40,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                  controller.validImageTotal.value
                                      ? '(Tối thiểu 4 ảnh, tối đa 20 ảnh)'
                                      : 'Vui lòng chọn tối thiểu 4 ảnh, tối đa 20 ảnh',
                                  style: TextStyle(
                                    color: controller.validImageTotal.value ? secondary40 : red50,
                                    fontSize: 12,
                                  ))
                            ],
                          ),
                  ),
                ),
              )),
          SizedBox(
            height: 16,
          ),

          //---------------------Utilities-------------------------
          Text(
            'TIỆN ÍCH',
            style: TextStyle(
                color: secondary40, fontSize: 16, fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: 10,
          ),
          Obx(
            () => GridView.builder(
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 3,
                mainAxisSpacing: 8.0,
                crossAxisSpacing: 8.0,
              ),
              itemCount: controller.utilList.length,
              itemBuilder: (context, index) {
                return FilledButton.icon(
                  style: FilledButton.styleFrom(
                    padding: EdgeInsets.all(0),
                    backgroundColor: controller.utilList[index].isChecked
                        ? primary98
                        : secondary90,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  onPressed: () {
                    controller.utilList[index] = controller.utilList[index]
                        .copyWith(
                            isChecked: !controller.utilList[index].isChecked);
                  },
                  icon: Icon(
                    controller.utilList[index].utility.getIconUtil(),
                    size: 20,
                    color: controller.utilList[index].isChecked
                        ? primary40
                        : secondary40,
                  ),
                  label: Text(
                    controller.utilList[index].utility.getNameUtil(),
                    style: TextStyle(
                        fontSize: 12,
                        color: controller.utilList[index].isChecked
                            ? primary40
                            : secondary40,
                        fontWeight: FontWeight.w500),
                  ),
                );
              },
            ),
          ),
          SizedBox(
            height: 16,
          ),
        ],
      ),
    ));
  }

  Widget UploadInstruction() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Icon(
          Icons.add_photo_alternate_outlined,
          size: 52,
          color: primary60,
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          'Bấm vào đây để đăng hình ảnh nhé!',
          softWrap: true,
          maxLines: 2,
          style: TextStyle(
              color: primary60, fontSize: 16, fontWeight: FontWeight.w500),
          textAlign: TextAlign.center,
        )
      ],
    );
  }

  Widget ImageItem(XFile element) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: double.infinity,
          margin: EdgeInsets.only(top: 4, right: 4),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: secondary80, width: 2)),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.file(
              File(element.path),
              fit: BoxFit.fill,
            ),
          ),
        ),
        Positioned(
          top: 0,
          right: 0,
          child: InkWell(
            onTap: () {
              controller.pickedImages.value
                  ?.removeWhere((e) => e.path == element.path);
              controller.pickedImages.update((val) {});
            },
            child: Container(
              padding: EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: secondary80,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                Icons.close,
                color: secondary40,
                size: 16,
              ),
            ),
          ),
        )
      ],
    );
  }
}
