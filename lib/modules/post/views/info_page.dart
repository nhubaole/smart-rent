import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_rent/core/enums/gender.dart';
import 'package:smart_rent/core/enums/room_type.dart';
import 'package:smart_rent/core/values/app_colors.dart';
import 'package:smart_rent/modules/post/controllers/post_controller.dart';

class InfoPage extends StatefulWidget {
  const InfoPage({super.key});

  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
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
              'Thông tin phòng',
              style: TextStyle(
                  color: primary40, fontSize: 18, fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 20,
            ),

            //---------------------Room type-------------------------
            Text(
              'LOẠI PHÒNG',
              style: TextStyle(
                  color: secondary40,
                  fontSize: 16,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 10,
            ),
            typeOption(),
            SizedBox(
              height: 16,
            ),

            //---------------------Capacity-------------------------
            Text(
              'SỨC CHỨA',
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
              controller: controller.capacityTextController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Nhập số người/phòng',
                suffixText: 'người/phòng',
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: primary40, width: 2)),
              ),
            ),
            SizedBox(
              height: 16,
            ),

            //---------------------Gender-------------------------
            Text(
              'GIỚI TÍNH',
              style: TextStyle(
                  color: secondary40,
                  fontSize: 16,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 10,
            ),
            genderOption(),
            SizedBox(
              height: 16,
            ),

            //---------------------Area-------------------------
            Text(
              'DIỆN TÍCH',
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
              controller: controller.areaTextController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Nhập diện tích phòng',
                suffixText: 'm2',
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: primary40, width: 2)),
              ),
            ),
            SizedBox(
              height: 20,
            ),

            Text(
              'Chi phí',
              style: TextStyle(
                  color: primary40, fontSize: 18, fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 20,
            ),

            //---------------------Price-------------------------
            Text(
              'GIÁ CHO THUÊ',
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
              controller: controller.priceTextController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Nhập giá cho thuê',
                suffixText: '₫/phòng',
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: primary40, width: 2)),
              ),
            ),
            SizedBox(
              height: 16,
            ),

            //---------------------Deposit-------------------------
            Text(
              'ĐẶT CỌC',
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
              controller: controller.depositTextController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Nhập số tiền đặt cọc',
                suffixText: '₫',
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: primary40, width: 2)),
              ),
            ),
            SizedBox(
              height: 16,
            ),

            //---------------------Electricity-------------------------
            Row(
              children: [
                Expanded(
                  child: Text(
                    'TIỀN ĐIỆN',
                    style: TextStyle(
                        color: secondary40,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                Builder(builder: (context) {
                  final MaterialStateProperty<Color?> trackColor =
                      MaterialStateProperty.resolveWith<Color?>(
                    (Set<MaterialState> states) {
                      if (states.contains(MaterialState.selected)) {
                        return primary40;
                      }
                      return secondary80;
                    },
                  );
                  final MaterialStateProperty<Color?> overlayColor =
                      MaterialStateProperty.resolveWith<Color?>(
                    (Set<MaterialState> states) {
                      // Material color when switch is selected.
                      if (states.contains(MaterialState.selected)) {
                        return primary40.withOpacity(0.54);
                      }
                      return null;
                    },
                  );

                  return Obx(() => Switch(
                        // This bool value toggles the switch.
                        value: controller.isElectricityFree.value,
                        overlayColor: overlayColor,
                        trackColor: trackColor,
                        thumbColor:
                            const MaterialStatePropertyAll<Color>(Colors.white),
                        onChanged: (bool value) {
                          value
                              ? controller.electricityCostTextController.text =
                                  '0'
                              : controller.electricityCostTextController.text =
                                  '';
                          controller.isElectricityFree.value = value;
                        },
                      ));
                }),
                SizedBox(
                  width: 10,
                ),
                Obx(() => Text(
                      'Miễn phí',
                      style: TextStyle(
                          color: controller.isElectricityFree.value
                              ? primary40
                              : secondary40,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ))
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Obx(() => TextFormField(
                  enabled: !controller.isElectricityFree.value,
                  validator: (value) => controller.fieldValidator(value!),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: controller.electricityCostTextController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Nhập số tiền',
                    suffixText: '₫',
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: primary40, width: 2)),
                  ),
                )),
            SizedBox(
              height: 16,
            ),

            //---------------------Water-------------------------
            Row(
              children: [
                Expanded(
                  child: Text(
                    'TIỀN NƯỚC',
                    style: TextStyle(
                        color: secondary40,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                Builder(builder: (context) {
                  final MaterialStateProperty<Color?> trackColor =
                      MaterialStateProperty.resolveWith<Color?>(
                    (Set<MaterialState> states) {
                      if (states.contains(MaterialState.selected)) {
                        return primary40;
                      }
                      return secondary80;
                    },
                  );
                  final MaterialStateProperty<Color?> overlayColor =
                      MaterialStateProperty.resolveWith<Color?>(
                    (Set<MaterialState> states) {
                      // Material color when switch is selected.
                      if (states.contains(MaterialState.selected)) {
                        return primary40.withOpacity(0.54);
                      }
                      return null;
                    },
                  );

                  return Obx(() => Switch(
                        // This bool value toggles the switch.
                        value: controller.isWaterFree.value,
                        overlayColor: overlayColor,
                        trackColor: trackColor,
                        thumbColor:
                            const MaterialStatePropertyAll<Color>(Colors.white),
                        onChanged: (bool value) {
                          value
                              ? controller.waterCostTextController.text = '0'
                              : controller.waterCostTextController.text = '';
                          controller.isWaterFree.value = value;
                        },
                      ));
                }),
                SizedBox(
                  width: 10,
                ),
                Obx(() => Text(
                      'Miễn phí',
                      style: TextStyle(
                          color: controller.isWaterFree.value
                              ? primary40
                              : secondary40,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ))
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Obx(() => TextFormField(
                  enabled: !controller.isWaterFree.value,
                  validator: (value) => controller.fieldValidator(value!),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: controller.waterCostTextController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Nhập số tiền',
                    suffixText: '₫',
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: primary40, width: 2)),
                  ),
                )),
            SizedBox(
              height: 16,
            ),

            //---------------------Internet-------------------------
            Row(
              children: [
                Expanded(
                  child: Text(
                    'TIỀN INTERNET/WIFI',
                    style: TextStyle(
                        color: secondary40,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                Builder(builder: (context) {
                  final MaterialStateProperty<Color?> trackColor =
                      MaterialStateProperty.resolveWith<Color?>(
                    (Set<MaterialState> states) {
                      if (states.contains(MaterialState.selected)) {
                        return primary40;
                      }
                      return secondary80;
                    },
                  );
                  final MaterialStateProperty<Color?> overlayColor =
                      MaterialStateProperty.resolveWith<Color?>(
                    (Set<MaterialState> states) {
                      // Material color when switch is selected.
                      if (states.contains(MaterialState.selected)) {
                        return primary40.withOpacity(0.54);
                      }
                      return null;
                    },
                  );

                  return Obx(() => Switch(
                        value: controller.isInternetFree.value,
                        overlayColor: overlayColor,
                        trackColor: trackColor,
                        thumbColor:
                            const MaterialStatePropertyAll<Color>(Colors.white),
                        onChanged: (bool value) {
                          value
                              ? controller.internetCostTextController.text = '0'
                              : controller.internetCostTextController.text = '';
                          controller.isInternetFree.value = value;
                        },
                      ));
                }),
                SizedBox(
                  width: 10,
                ),
                Obx(() => Text(
                      'Miễn phí',
                      style: TextStyle(
                          color: controller.isInternetFree.value
                              ? primary40
                              : secondary40,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ))
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Obx(() => TextFormField(
                  enabled: !controller.isInternetFree.value,
                  validator: (value) => controller.fieldValidator(value!),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: controller.internetCostTextController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Nhập số tiền',
                    suffixText: '₫',
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: primary40, width: 2)),
                  ),
                )),
            SizedBox(
              height: 16,
            ),

            //---------------------Parking-------------------------
            Obx(() => CheckboxListTile(
                  contentPadding: EdgeInsets.all(0),
                  title: Text('Có chỗ để xe'),
                  value: controller.hasParking.value,
                  onChanged: (bool? value) {
                    controller.hasParking.value = value!;
                  },
                  controlAffinity: ListTileControlAffinity.leading,
                  visualDensity: const VisualDensity(
                    horizontal: VisualDensity.minimumDensity,
                    vertical: VisualDensity.minimumDensity,
                  ),
                  activeColor: primary40,
                )),
            SizedBox(
              height: 10,
            ),
            Obx(() => controller.hasParking.value
                ? Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              'PHÍ GIỮ XE',
                              style: TextStyle(
                                  color: secondary40,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          Builder(builder: (context) {
                            final MaterialStateProperty<Color?> trackColor =
                                MaterialStateProperty.resolveWith<Color?>(
                              (Set<MaterialState> states) {
                                if (states.contains(MaterialState.selected)) {
                                  return primary40;
                                }
                                return secondary80;
                              },
                            );
                            final MaterialStateProperty<Color?> overlayColor =
                                MaterialStateProperty.resolveWith<Color?>(
                              (Set<MaterialState> states) {
                                // Material color when switch is selected.
                                if (states.contains(MaterialState.selected)) {
                                  return primary40.withOpacity(0.54);
                                }
                                return null;
                              },
                            );

                            return Obx(() => Switch(
                                  // This bool value toggles the switch.
                                  value: controller.isParkingFree.value,
                                  overlayColor: overlayColor,
                                  trackColor: trackColor,
                                  thumbColor:
                                      const MaterialStatePropertyAll<Color>(
                                          Colors.white),
                                  onChanged: (bool value) {
                                    value
                                        ? controller
                                            .parkingFeeTextController.text = '0'
                                        : controller
                                            .parkingFeeTextController.text = '';
                                    controller.isParkingFree.value = value;
                                  },
                                ));
                          }),
                          SizedBox(
                            width: 10,
                          ),
                          Obx(() => Text(
                                'Miễn phí',
                                style: TextStyle(
                                    color: controller.isParkingFree.value
                                        ? primary40
                                        : secondary40,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500),
                              ))
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Obx(() => TextFormField(
                            enabled: !controller.isParkingFree.value,
                            validator: (value) =>
                                controller.fieldValidator(value!),
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            controller: controller.parkingFeeTextController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Nhập số tiền',
                              suffixText: '₫',
                              focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: primary40, width: 2)),
                            ),
                          )),
                      SizedBox(
                        height: 16,
                      ),
                    ],
                  )
                : SizedBox())
          ],
        ),
      )),
    ));
  }

  Widget typeOption() {
    return Column(
      children: <Widget>[
        radioTypeItem(RoomType.DORMITORY_HOMESTAY),
        Divider(
          thickness: 0.7,
        ),
        radioTypeItem(RoomType.ROOM),
        Divider(
          thickness: 0.7,
        ),
        radioTypeItem(RoomType.WHOLE_HOUSE),
        Divider(
          thickness: 0.7,
        ),
        radioTypeItem(RoomType.APARTMENT),
        Divider(
          thickness: 0.7,
        ),
      ],
    );
  }

  Widget genderOption() {
    return Column(
      children: <Widget>[
        radioGenderItem(Gender.ALL),
        Divider(
          thickness: 0.7,
        ),
        radioGenderItem(Gender.MALE),
        Divider(
          thickness: 0.7,
        ),
        radioGenderItem(Gender.FEMALE),
        Divider(
          thickness: 0.7,
        ),
      ],
    );
  }

  Obx radioTypeItem(RoomType type) {
    return Obx(() => RadioListTile<RoomType>(
          activeColor: primary40,
          visualDensity: const VisualDensity(
            horizontal: VisualDensity.minimumDensity,
            vertical: VisualDensity.minimumDensity,
          ),
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          contentPadding: EdgeInsets.all(0),
          title: Text(
            type.getNameRoomType(),
            style: TextStyle(color: secondary20, fontSize: 16),
          ),
          value: type,
          groupValue: controller.room.value.roomType,
          onChanged: (RoomType? value) {
            controller.onSelectRoomType(value!);
          },
        ));
  }

  Obx radioGenderItem(Gender gender) {
    return Obx(() => RadioListTile<Gender>(
          activeColor: primary40,
          visualDensity: const VisualDensity(
            horizontal: VisualDensity.minimumDensity,
            vertical: VisualDensity.minimumDensity,
          ),
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          contentPadding: EdgeInsets.all(0),
          title: Text(
            gender.getNameGender(),
            style: TextStyle(color: secondary20, fontSize: 16),
          ),
          value: gender,
          groupValue: controller.room.value.gender,
          onChanged: (Gender? value) {
            controller.onSelectGender(value!);
          },
        ));
  }
}
