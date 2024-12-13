import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../core/config/app_colors.dart';
import '/core/enums/gender.dart';
import '/core/enums/room_type.dart';
import '/modules/post/controllers/post_controller.dart';

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
        margin: EdgeInsets.fromLTRB(4.w, 2.w, 4.w, 2.w),
        child: SingleChildScrollView(
          child: Form(
            key: controller.formInfoKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Thông tin phòng',
                  style: TextStyle(
                      color: AppColors.primary40,
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 4.h,
                ),
                _buildTypeRoom(),
                SizedBox(
                  height: 3.h,
                ),
                _buildCapacity(),
                SizedBox(
                  height: 4.h,
                ),
                _buildGender(),
                SizedBox(
                  height: 3.h,
                ),
                _buildArea(),
                SizedBox(
                  height: 4.h,
                ),
                const Text(
                  'Chi phí',
                  style: TextStyle(
                      color: AppColors.primary40,
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 2.h),
                _buildPrice(),
                SizedBox(height: 2.h),
                _buildDeposit(),
                SizedBox(height: 2.h),
                _buildElectricityPrice(),
                SizedBox(height: 2.h),
                _buildWaterPrice(),
                SizedBox(height: 2.h),
                _buildInternetPrice(),
                SizedBox(height: 2.h),
                _buildParkingPrice(),
                SizedBox(height: 2.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Column _buildParkingPrice() {
    return Column(
      children: [
        Obx(() => CheckboxListTile(
              contentPadding: const EdgeInsets.all(0),
              title: const Text('Có chỗ để xe'),
              value: controller.hasParking.value,
              onChanged: (bool? value) {
                controller.hasParking.value = value!;
              },
              controlAffinity: ListTileControlAffinity.leading,
              visualDensity: const VisualDensity(
                horizontal: VisualDensity.minimumDensity,
                vertical: VisualDensity.minimumDensity,
              ),
              activeColor: AppColors.primary40,
            )),
        const SizedBox(
          height: 10,
        ),
        Obx(() => controller.hasParking.value
            ? Column(
                children: [
                  Row(
                    children: [
                      const Expanded(
                        child: Text(
                          'PHÍ GIỮ XE',
                          style: TextStyle(
                              color: AppColors.secondary40,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      Builder(builder: (context) {
                        final WidgetStateProperty<Color?> trackColor =
                            WidgetStateProperty.resolveWith<Color?>(
                          (Set<WidgetState> states) {
                            if (states.contains(WidgetState.selected)) {
                              return AppColors.primary40;
                            }
                            return AppColors.secondary80;
                          },
                        );
                        final WidgetStateProperty<Color?> overlayColor =
                            WidgetStateProperty.resolveWith<Color?>(
                          (Set<WidgetState> states) {
                            // Material color when switch is selected.
                            if (states.contains(WidgetState.selected)) {
                              return AppColors.primary40.withOpacity(0.54);
                            }
                            return null;
                          },
                        );

                        return Obx(() => Switch(
                              // This bool value toggles the switch.
                              value: controller.isParkingFree.value,
                              overlayColor: overlayColor,
                              trackColor: trackColor,
                              thumbColor: const WidgetStatePropertyAll<Color>(
                                  Colors.white),
                              onChanged: (bool value) {
                                value
                                    ? controller.parkingFeeTextController.text =
                                        '0'
                                    : controller.parkingFeeTextController.text =
                                        '';
                                controller.isParkingFree.value = value;
                              },
                            ));
                      }),
                      const SizedBox(
                        width: 10,
                      ),
                      Obx(() => Text(
                            'Miễn phí',
                            style: TextStyle(
                                color: controller.isParkingFree.value
                                    ? AppColors.primary40
                                    : AppColors.secondary40,
                                fontSize: 14,
                                fontWeight: FontWeight.w500),
                          ))
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Obx(() => TextFormField(
                        enabled: !controller.isParkingFree.value,
                        validator: (value) => controller.fieldValidator(value!),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: controller.parkingFeeTextController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Nhập số tiền',
                          suffixText: '₫',
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: AppColors.primary40, width: 2)),
                        ),
                      )),
                  const SizedBox(
                    height: 16,
                  ),
                ],
              )
            : const SizedBox())
      ],
    );
  }

  Column _buildInternetPrice() {
    return Column(
      children: [
        Row(
          children: [
            const Expanded(
              child: Text(
                'TIỀN INTERNET/WIFI',
                style: TextStyle(
                    color: AppColors.secondary40,
                    fontSize: 16,
                    fontWeight: FontWeight.w500),
              ),
            ),
            Builder(builder: (context) {
              final WidgetStateProperty<Color?> trackColor =
                  WidgetStateProperty.resolveWith<Color?>(
                (Set<WidgetState> states) {
                  if (states.contains(WidgetState.selected)) {
                    return AppColors.primary40;
                  }
                  return AppColors.secondary80;
                },
              );
              final WidgetStateProperty<Color?> overlayColor =
                  WidgetStateProperty.resolveWith<Color?>(
                (Set<WidgetState> states) {
                  // Material color when switch is selected.
                  if (states.contains(WidgetState.selected)) {
                    return AppColors.primary40.withOpacity(0.54);
                  }
                  return null;
                },
              );

              return Obx(() => Switch(
                    value: controller.isInternetFree.value,
                    overlayColor: overlayColor,
                    trackColor: trackColor,
                    thumbColor:
                        const WidgetStatePropertyAll<Color>(Colors.white),
                    onChanged: (bool value) {
                      value
                          ? controller.internetCostTextController.text = '0'
                          : controller.internetCostTextController.text = '';
                      controller.isInternetFree.value = value;
                    },
                  ));
            }),
            const SizedBox(
              width: 10,
            ),
            Obx(
              () => Text(
                'Miễn phí',
                style: TextStyle(
                    color: controller.isInternetFree.value
                        ? AppColors.primary40
                        : AppColors.secondary40,
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
              ),
            )
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Obx(() => TextFormField(
              enabled: !controller.isInternetFree.value,
              validator: (value) => controller.fieldValidator(value!),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              controller: controller.internetCostTextController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Nhập số tiền',
                suffixText: '₫',
                focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: AppColors.primary40, width: 2)),
              ),
            )),
        const SizedBox(
          height: 16,
        ),
      ],
    );
  }

  Column _buildWaterPrice() {
    return Column(
      children: [
        Row(
          children: [
            const Expanded(
              child: Text(
                'TIỀN NƯỚC',
                style: TextStyle(
                    color: AppColors.secondary40,
                    fontSize: 16,
                    fontWeight: FontWeight.w500),
              ),
            ),
            Builder(builder: (context) {
              final WidgetStateProperty<Color?> trackColor =
                  WidgetStateProperty.resolveWith<Color?>(
                (Set<WidgetState> states) {
                  if (states.contains(WidgetState.selected)) {
                    return AppColors.primary40;
                  }
                  return AppColors.secondary80;
                },
              );
              final WidgetStateProperty<Color?> overlayColor =
                  WidgetStateProperty.resolveWith<Color?>(
                (Set<WidgetState> states) {
                  // Material color when switch is selected.
                  if (states.contains(WidgetState.selected)) {
                    return AppColors.primary40.withOpacity(0.54);
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
                        const WidgetStatePropertyAll<Color>(Colors.white),
                    onChanged: (bool value) {
                      value
                          ? controller.waterCostTextController.text = '0'
                          : controller.waterCostTextController.text = '';
                      controller.isWaterFree.value = value;
                    },
                  ));
            }),
            const SizedBox(
              width: 10,
            ),
            Obx(() => Text(
                  'Miễn phí',
                  style: TextStyle(
                      color: controller.isWaterFree.value
                          ? AppColors.primary40
                          : AppColors.secondary40,
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
                ))
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Obx(() => TextFormField(
              enabled: !controller.isWaterFree.value,
              validator: (value) => controller.fieldValidator(value!),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              controller: controller.waterCostTextController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Nhập số tiền',
                suffixText: '₫',
                focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: AppColors.primary40, width: 2)),
              ),
            )),
        const SizedBox(
          height: 16,
        ),
      ],
    );
  }

  Column _buildElectricityPrice() {
    return Column(
      children: [
        Row(
          children: [
            const Expanded(
              child: Text(
                'TIỀN ĐIỆN',
                style: TextStyle(
                    color: AppColors.secondary40,
                    fontSize: 16,
                    fontWeight: FontWeight.w500),
              ),
            ),
            Builder(builder: (context) {
              final WidgetStateProperty<Color?> trackColor =
                  WidgetStateProperty.resolveWith<Color?>(
                (Set<WidgetState> states) {
                  if (states.contains(WidgetState.selected)) {
                    return AppColors.primary40;
                  }
                  return AppColors.secondary80;
                },
              );
              final WidgetStateProperty<Color?> overlayColor =
                  WidgetStateProperty.resolveWith<Color?>(
                (Set<WidgetState> states) {
                  // Material color when switch is selected.
                  if (states.contains(WidgetState.selected)) {
                    return AppColors.primary40.withOpacity(0.54);
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
                        const WidgetStatePropertyAll<Color>(Colors.white),
                    onChanged: (bool value) {
                      value
                          ? controller.electricityCostTextController.text = '0'
                          : controller.electricityCostTextController.text = '';
                      controller.isElectricityFree.value = value;
                    },
                  ));
            }),
            const SizedBox(
              width: 10,
            ),
            Obx(
              () => Text(
                'Miễn phí',
                style: TextStyle(
                    color: controller.isElectricityFree.value
                        ? AppColors.primary40
                        : AppColors.secondary40,
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Obx(() => TextFormField(
              enabled: !controller.isElectricityFree.value,
              validator: (value) => controller.fieldValidator(value!),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              controller: controller.electricityCostTextController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Nhập số tiền',
                suffixText: '₫',
                focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: AppColors.primary40, width: 2)),
              ),
            )),
        const SizedBox(
          height: 16,
        ),
      ],
    );
  }

  Column _buildDeposit() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'ĐẶT CỌC',
          style: TextStyle(
              color: AppColors.secondary40,
              fontSize: 16,
              fontWeight: FontWeight.w500),
        ),
        SizedBox(
          height: 2.h,
        ),
        TextFormField(
          validator: (value) => controller.fieldValidator(value!),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          controller: controller.depositTextController,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Nhập số tiền đặt cọc',
            suffixText: '₫',
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.primary40, width: 2)),
          ),
        ),
      ],
    );
  }

  Column _buildPrice() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'GIÁ CHO THUÊ',
          style: TextStyle(
              color: AppColors.secondary40,
              fontSize: 16,
              fontWeight: FontWeight.w500),
        ),
        SizedBox(
          height: 2.h,
        ),
        TextFormField(
          validator: (value) => controller.fieldValidator(value!),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          controller: controller.priceTextController,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Nhập giá cho thuê',
            suffixText: '₫/phòng',
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.primary40, width: 2)),
          ),
        ),
      ],
    );
  }

  Column _buildArea() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'DIỆN TÍCH',
          style: TextStyle(
              color: AppColors.secondary40,
              fontSize: 16,
              fontWeight: FontWeight.w500),
        ),
        SizedBox(
          height: 2.w,
        ),
        TextFormField(
          validator: (value) => controller.fieldValidator(value!),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          controller: controller.areaTextController,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Nhập diện tích phòng',
            suffixText: ' | m2',
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.primary40, width: 2)),
          ),
        ),
      ],
    );
  }

  Column _buildGender() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'GIỚI TÍNH',
          style: TextStyle(
              color: AppColors.secondary40,
              fontSize: 16,
              fontWeight: FontWeight.w500),
        ),
        SizedBox(
          height: 2.w,
        ),
        _buildGenderOption(),
      ],
    );
  }

  Column _buildCapacity() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'SỨC CHỨA',
          style: TextStyle(
              color: AppColors.secondary40,
              fontSize: 16,
              fontWeight: FontWeight.w500),
        ),
        SizedBox(
          height: 2.w,
        ),
        TextFormField(
          validator: (value) => controller.fieldValidator(value!),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          controller: controller.capacityTextController,
          keyboardType: TextInputType.number,
          maxLines: 1,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            suffixStyle: TextStyle(
                color: AppColors.secondary20,
                fontSize: 14,
                fontWeight: FontWeight.w500),
            hintStyle: TextStyle(
                color: AppColors.secondary20,
                fontSize: 14,
                fontWeight: FontWeight.w400),
            hintText: 'Nhập số người/phòng',
            suffixText: ' | người/phòng',
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.primary40, width: 2)),
          ),
        ),
      ],
    );
  }

  Column _buildTypeRoom() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'LOẠI PHÒNG',
          style: TextStyle(
              color: AppColors.secondary40,
              fontSize: 16,
              fontWeight: FontWeight.w500),
        ),
        SizedBox(
          height: 2.w,
        ),
        _buildTypeRoomOption(),
      ],
    );
  }

  Widget _buildTypeRoomOption() {
    return Column(
      children: <Widget>[
        radioTypeItem(RoomType.DORMITORY_HOMESTAY),
        const Divider(
          thickness: 0.7,
        ),
        radioTypeItem(RoomType.ROOM),
        const Divider(
          thickness: 0.7,
        ),
        radioTypeItem(RoomType.WHOLE_HOUSE),
        const Divider(
          thickness: 0.7,
        ),
        radioTypeItem(RoomType.APARTMENT),
        const Divider(
          thickness: 0.7,
        ),
      ],
    );
  }

  Widget _buildGenderOption() {
    return Column(
      children: <Widget>[
        radioGenderItem(Gender.ALL),
        const Divider(
          thickness: 0.7,
        ),
        radioGenderItem(Gender.MALE),
        const Divider(
          thickness: 0.7,
        ),
        radioGenderItem(Gender.FEMALE),
        const Divider(
          thickness: 0.7,
        ),
      ],
    );
  }

  Obx radioTypeItem(RoomType type) {
    return Obx(
      () => RadioListTile<RoomType>(
        activeColor: AppColors.primary40,
        visualDensity: const VisualDensity(
          horizontal: VisualDensity.minimumDensity,
          vertical: VisualDensity.minimumDensity,
        ),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        contentPadding: const EdgeInsets.all(0),
        title: Text(
          type.getNameRoomType(),
          style: const TextStyle(color: AppColors.secondary20, fontSize: 16),
        ),
        value: type,
        groupValue: InfoRoomType.fromString(controller.room.value.roomType!),
        onChanged: (RoomType? value) {
          controller.onSelectRoomType(value!);
        },
      ),
    );
  }

  Obx radioGenderItem(Gender gender) {
    return Obx(
      () => RadioListTile<Gender>(
        activeColor: AppColors.primary40,
        visualDensity: const VisualDensity(
          horizontal: VisualDensity.minimumDensity,
          vertical: VisualDensity.minimumDensity,
        ),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        contentPadding: const EdgeInsets.all(0),
        title: Text(
          gender.getNameGender(),
          style: const TextStyle(color: AppColors.secondary20, fontSize: 16),
        ),
        value: gender,
        groupValue: InfoGender.fromInt(controller.room.value.gender!),
        onChanged: (Gender? value) {
          controller.onSelectGender(value!);
        },
      ),
    );
  }
}
