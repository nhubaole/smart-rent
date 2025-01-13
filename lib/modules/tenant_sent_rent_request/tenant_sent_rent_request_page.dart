import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:smart_rent/core/config/app_colors.dart';
import 'package:smart_rent/core/helper/help_regex.dart';
import 'package:smart_rent/core/widget/custom_app_bar.dart';
import 'package:smart_rent/core/widget/outline_text_filed_widget.dart';
import 'package:smart_rent/core/widget/scaffold_widget.dart';
import 'package:smart_rent/core/widget/solid_button_widget.dart';
import 'package:smart_rent/modules/tenant_sent_rent_request/tenant_sent_rent_request_controller.dart';

class TenantSentRentRequestPage
    extends GetView<TenantSentRentRequestController> {
  const TenantSentRentRequestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      resizeToAvoidBottomInset: true,
      appBar: CustomAppBar(title: 'Gửi yêu cầu thuê phòng'.tr),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.only(
        right: 16.px,
        left: 16.px,
        top: 8.px,
      ),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.transparent, width: 0.5.px),
          borderRadius: BorderRadius.all(Radius.circular(10.px)),
        ),
        child: Form(
          key: controller.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildPriceAndQuantityPeople(),
              SizedBox(height: 24.px),
              _buildDetailRequest(context),
              SizedBox(height: 16.px),
              _buildButtonSubmit(),
            ],
          ),
        ),
      ),
    );
  }

  SolidButtonWidget _buildButtonSubmit() {
    return SolidButtonWidget(
      height: 55.px,
      margin: EdgeInsets.symmetric(vertical: 4.px),
      text: 'submit'.tr,
      trailing: Padding(
        padding: EdgeInsets.only(left: 8.px),
        child: Icon(
          Icons.send_rounded,
          size: 16.sp,
          color: AppColors.white,
        ),
      ),
      onTap: controller.onSubmit,
    );
  }

  Widget _buildDetailRequest(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 8.px),
        Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildStartJoinDate(context),
              SizedBox(height: 16.px),
              _buildLeaveDate(context),
              SizedBox(height: 16.px),
              OutlineTextFiledWidget(
                textLabel: 'YÊU CẦU ĐẶC BIỆT'.tr,
                textEditingController: controller.specialSuggestController,
                onValidate: (p0) {
                  return null;
                },
                minlines: 5,
              ),
              SizedBox(height: 16.px),
              Text.rich(
                style: TextStyle(
                  color: AppColors.secondary40,
                  fontWeight: FontWeight.normal,
                  fontSize: 14.sp,
                ),
                TextSpan(
                  text:
                      'Bằng việc gửi yêu cầu thuê phòng, chủ phòng có thể nhìn thấy các thông tin cá nhân của bạn'
                          .tr,
                ),
              ),
              SizedBox(height: 16.px),
              InkWell(
                onTap: () {
                  controller.isCheckboxSubmitStatement.value =
                      !controller.isCheckboxSubmitStatement.value;
                },
                borderRadius: BorderRadius.circular(12.px),
                child: Row(
                  children: [
                    SizedBox(
                      width: 36.px,
                      height: 36.px,
                      child: Checkbox(
                        activeColor: AppColors.primary40,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4.px),
                        ),
                        value: controller.isCheckboxSubmitStatement.value,
                        onChanged: (value) {
                          controller.isCheckboxSubmitStatement.value = value!;
                        },
                      ),
                    ),
                    SizedBox(width: 8.px),
                    Expanded(
                      child: Text.rich(
                        style: TextStyle(
                          color: AppColors.secondary20,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.normal,
                        ),
                        TextSpan(
                            text: 'Tôi đồng ý cung cấp thông tin cho chủ phòng'
                                .tr),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Column _buildStartJoinDate(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'NGÀY BẮT ĐẦU THUÊ',
            style: TextStyle(
              fontSize: 16.sp,
              color: AppColors.secondary40,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        InkWell(
          onTap: () {
            controller.canJoinNow.value = !controller.canJoinNow.value;
          },
          borderRadius: BorderRadius.circular(8.px),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Switch(
                activeTrackColor: AppColors.primary40,
                value: controller.canJoinNow.value,
                onChanged: controller.onChangeJoinNow,
              ),
              SizedBox(width: 8.px),
              Text(
                'Có thể dọn vào ở ngay'.tr,
                style: TextStyle(
                  color: AppColors.primary40,
                  fontWeight: FontWeight.w500,
                  fontSize: 16.sp,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 8.px),
        OutlineTextFiledWidget(
          onTap: () => controller.onTapChoseStartJoinDate(context),
          readOnly: true,
          textEditingController: controller.dateStartJoinController,
          onValidate: (p0) {
            return null;
          },
          suffixIcon: Icon(
            Icons.calendar_today_outlined,
            color: AppColors.secondary40,
            size: 24.px,
          ),
        ),
      ],
    );
  }

  Column _buildLeaveDate(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'NGÀY KẾT THÚC THUÊ',
            style: TextStyle(
              fontSize: 16.sp,
              color: AppColors.secondary40,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        InkWell(
          onTap: () {
            controller.isLeaveDay.value = !controller.isLeaveDay.value;
          },
          borderRadius: BorderRadius.circular(8.px),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Switch(
                activeTrackColor: AppColors.primary40,
                value: controller.isLeaveDay.value,
                onChanged: controller.onChangeLeave,
              ),
              SizedBox(width: 8.px),
              Text(
                'Tôi muốn thuê dài hạn'.tr,
                style: TextStyle(
                  color: AppColors.primary40,
                  fontWeight: FontWeight.w500,
                  fontSize: 16.sp,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 8.px),
        OutlineTextFiledWidget(
          onTap: () => controller.onTapChoseLeaveDate(context),
          readOnly: true,
          textEditingController: controller.dateLeaveController,
          onValidate: (p0) {
            return null;
          },
          suffixIcon: Icon(
            Icons.calendar_today_outlined,
            color: AppColors.secondary40,
            size: 24.px,
          ),
        ),
      ],
    );
  }

  Widget _buildPriceAndQuantityPeople() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        OutlineTextFiledWidget(
          textLabel: 'GIÁ ĐỀ XUẤT'.toUpperCase(),
          textEditingController: controller.suggestPriceController,
          hintText: 'Nhập giá đề xuất',
          suffix: Text('| đ'),
          textInputType:
              TextInputType.numberWithOptions(decimal: true, signed: true),
          onValidate: (value) {
            if (value!.isEmpty) {
              return 'Vui lòng nhập giá đề xuất';
            }

            // if (!HelpRegex.isNumber(value)) {
            //   return 'Vui lòng nhập định dạng số';
            // }
            return null;
          },
        ),
        SizedBox(height: 16.px),
        OutlineTextFiledWidget(
          textLabel: 'SỐ LƯỢNG NGƯỜI Ở'.toUpperCase(),
          textEditingController: controller.peopleWillJoinController,
          hintText: 'Nhập số người/phòng',
          textInputType:
              TextInputType.numberWithOptions(decimal: true, signed: true),
          suffix: Text('| người/phòng'),
          onValidate: (value) {
            if (value!.isEmpty) {
              return 'Vui lòng nhập số người sẽ ở';
            }
            // if (!HelpRegex.isNumber(value)) {
            //   return 'Vui lòng nhập định dạng số';
            // }
            return null;
          },
        ),
      ],
    );
  }
}
