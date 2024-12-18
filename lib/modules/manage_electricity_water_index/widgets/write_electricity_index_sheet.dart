import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:smart_rent/core/config/app_colors.dart';
import 'package:smart_rent/core/model/billing/billing_list_index_by_landlord_model.dart';
import 'package:smart_rent/core/values/image_assets.dart';
import 'package:smart_rent/core/widget/alert_snackbar.dart';
import 'package:smart_rent/core/widget/outline_button_widget.dart';
import 'package:smart_rent/core/widget/outline_text_filed_widget.dart';

class WriteElectricityIndexSheet extends StatefulWidget {
  final BillingListIndexByLandlordModel billingIndexs;
  final int indexInBill;
  final Function({
    required BillingListIndexByLandlordModel bill,
    required int index,
    required String image,
  }) onSubmit;
  final bool isWater;
  const WriteElectricityIndexSheet({
    super.key,
    required this.billingIndexs,
    required this.indexInBill,
    required this.onSubmit,
    required this.isWater,
  });

  @override
  State<WriteElectricityIndexSheet> createState() =>
      _WriteElectricityIndexSheetState();
}

class _WriteElectricityIndexSheetState
    extends State<WriteElectricityIndexSheet> {
  late TextEditingController numberController;
  String imagePath = '';
  @override
  void initState() {
    numberController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    numberController.dispose();
    super.dispose();
  }
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
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Phòng số ${widget.billingIndexs.indexInfo[widget.indexInBill].roomNumber}',
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 16.sp,
                  color: AppColors.primary60,
                  fontWeight: FontWeight.w500,
                ),  
              ),
            ),
            const Divider(
              color: AppColors.secondary80,
              thickness: 1,
            ),
            _buildInput(),
            SizedBox(height: 12.px),
            // _buildUploadImage(),
            // SizedBox(height: 12.px),
            // _buildButtonSubmit(),
            Row(
              children: [
                Expanded(
                  child: OutlineButtonWidget(
                    text: 'write'.tr,
                    onTap: () {
                      if (numberController.text.isEmpty) {
                        AlertSnackbar.show(
                          title: 'Chưa điền đủ thông tin',
                          message:
                              'Vui lòng điền chỉ số ${widget.isWater ? 'Nước' : 'Điện'}',
                          isError: true,
                        );

                        return;
                      }
                      // if (imagePath.isEmpty) {
                      //   AlertSnackbar.show(
                      //     title: 'Chưa điền đủ thông tin',
                      //     message:
                      //         'Vui lòng chụp ảnh chỉ số ${widget.isWater ? 'Nước' : 'Điện'}',
                      //     isError: true,
                      //   );
                      //   return;
                      // }
                      widget.onSubmit(
                        bill: widget.billingIndexs,
                        index: int.tryParse(numberController.text) ?? 0,
                        image: imagePath,
                      );
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
        borderType: BorderType.RRect,
        radius: Radius.circular(10.px),
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

  Widget _buildInput() {
    return OutlineTextFiledWidget(
      textLabel: 'Số ${widget.isWater ? 'Nước' : 'Điện'}'.tr,
          textEditingController: numberController,
          onValidate: (value) {
            if (value!.isEmpty) {
          return 'Vui lòng nhập số ${widget.isWater ? 'Nước' : 'Điện'}'.tr;
            }
            return null;
          },
          textStyleInput: TextStyle(
            fontSize: 16.sp,
            color: AppColors.secondary20,
            fontWeight: FontWeight.w400,
          ),
          textInputType: TextInputType.number,
      hintText: 'Nhập số ${widget.isWater ? 'nước' : 'điện'}'.tr,
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
            TextSpan(
              text: widget.billingIndexs.address,
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
          'Ghi chỉ số ${widget.isWater ? 'Nước' : 'Điện'}'.tr,
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
