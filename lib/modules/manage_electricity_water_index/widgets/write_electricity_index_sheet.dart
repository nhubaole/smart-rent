import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:smart_rent/core/config/app_colors.dart';
import 'package:smart_rent/core/values/image_assets.dart';
import 'package:smart_rent/core/widget/outline_button_widget.dart';
import 'package:smart_rent/core/widget/text_form_field_input.dart';

class WriteElectricityIndexSheet extends StatelessWidget {
  const WriteElectricityIndexSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        padding: EdgeInsets.only(
          top: 10.px,
          right: 16.px,
          left: 16.px,
          bottom: 16.px,
        ),
        constraints: BoxConstraints(minHeight: Get.height / 3),
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.px),
            topRight: Radius.circular(20.px),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildHeader(),
            SizedBox(height: 16.px),
            _buildAddress(),
            SizedBox(height: 12.px),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'room_3',
                textAlign: TextAlign.start,
              ),
            ),
            const Divider(
              color: AppColors.secondary80,
              thickness: 1,
            ),
            _buildInput(),
            SizedBox(height: 12.px),
            _buildUploadImage(),
            SizedBox(height: 12.px),
            // _buildButtonSubmit(),
            Row(
              children: [
                Expanded(
                  child: OutlineButtonWidget(
                    text: 'write'.tr,
                    onTap: () {
                      print('object');
                    },
                  ),
                )
              ],
            ),
            SizedBox(height: 12.px),
          ],
        ),
      ),
    );
  }

  Row _buildButtonSubmit() {
    return Row(
      children: [
        Expanded(
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              splashColor: AppColors.primary60.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20.px),
              onTap: () {
                print('object');
              },
              child: Container(
                height: 50,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.px),
                  border: Border.all(width: 1, color: AppColors.primary60),
                ),
                child: Text(
                  'write'.tr,
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: AppColors.primary60,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Column _buildUploadImage() {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'image'.tr.toUpperCase(),
            style: TextStyle(
              fontSize: 16.sp,
              color: AppColors.secondary20,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        SizedBox(height: 12.px),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              flex: 2,
              child: _buildOptionImage(
                title: 'upload_image_from_library'.tr,
                onTap: () {},
                icon: ImageAssets.icAddGallery,
              ),
            ),
            Expanded(
              child: Center(
                child: Text('or'.tr),
              ),
            ),
            Expanded(
              flex: 2,
              child: _buildOptionImage(
                title: 'take_picture'.tr,
                onTap: () {},
              ),
            ),
          ],
        ),
      ],
    );
  }

  Center _buildOptionImage({
    required String title,
    String? icon,
    required Function() onTap,
  }) {
    return Center(
      child: DottedBorder(
        color: AppColors.secondary60,
        padding: EdgeInsets.all(8.px),
        borderPadding: EdgeInsets.all(8.px),
        child: Material(
          color: AppColors.transparent,
          child: InkWell(
            splashColor: AppColors.primary60.withOpacity(0.2),
            borderRadius: BorderRadius.circular(0.px),
            onTap: onTap,
            child: Container(
              padding: EdgeInsets.all(8.px),
              alignment: Alignment.center,
              width: 120.px,
              height: 120.px,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  icon != null
                      ? Image.asset(
                          icon,
                          width: 40.px,
                          height: 40.px,
                        )
                      : Icon(
                          Icons.add_a_photo_outlined,
                          color: AppColors.primary60,
                          size: 40.px,
                        ),
                  SizedBox(height: 8.px),
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: AppColors.primary60,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Column _buildInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'electricity_number'.tr.toUpperCase(),
            style: TextStyle(
              fontSize: 16.sp,
              color: AppColors.secondary20,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        SizedBox(height: 12.px),
        TextFormFieldInput(
          textEditingController: TextEditingController(),
          textInputType: TextInputType.number,
          textStyle: TextStyle(
            fontSize: 16.sp,
            color: AppColors.secondary20,
            fontWeight: FontWeight.w400,
          ),
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            hintText: 'enter_electricity_number'.tr,
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: AppColors.secondary60,
                width: 1,
              ),
            ),
          ),
          borderRadius: BorderRadius.circular(8.px),
          borderColor: AppColors.secondary60,
          onSaved: (newValue) {},
          onValidate: (value) {
            if (value!.isEmpty) {
              return 'please_enter_electricity_number'.tr;
            }
            return null;
          },
          autoCorrect: false,
          textCapitalization: TextCapitalization.none,
        ),
      ],
    );
  }

  Row _buildAddress() {
    return Row(
      children: [
        const Icon(
          Icons.location_on_outlined,
          color: AppColors.secondary60,
        ),
        SizedBox(width: 8.px),
        Expanded(
          child: Text.rich(
            style: TextStyle(
              fontSize: 16.sp,
              color: AppColors.secondary20,
              fontWeight: FontWeight.w400,
            ),
            const TextSpan(
              text: 'Số 9 Nguyễn Văn Huyên, Dịch Vọng, Cầu Giấy, Hà Nội',
            ),
          ),
        ),
      ],
    );
  }

  Row _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'write_electricity_number'.tr,
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        IconButton(
          onPressed: () => Get.isBottomSheetOpen! ? Get.back() : null,
          icon: const Icon(
            Icons.close,
            color: AppColors.secondary20,
          ),
        ),
      ],
    );
  }
}
