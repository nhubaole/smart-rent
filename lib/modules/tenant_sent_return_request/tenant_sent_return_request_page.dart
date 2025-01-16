import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:smart_rent/core/config/app_colors.dart';
import 'package:smart_rent/core/extension/datetime_extension.dart';
import 'package:smart_rent/core/extension/double_extension.dart';
import 'package:smart_rent/core/widget/custom_app_bar.dart';
import 'package:smart_rent/core/widget/outline_text_filed_widget.dart';
import 'package:smart_rent/core/widget/scaffold_widget.dart';
import 'package:smart_rent/core/widget/solid_button_widget.dart';
import 'package:smart_rent/modules/tenant_sent_return_request/tenant_sent_return_request_controller.dart';

class TenantSentReturnRequestPage
    extends GetView<TenantSentReturnRequestController> {
  const TenantSentReturnRequestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      resizeToAvoidBottomInset: true,
      appBar: CustomAppBar(title: 'rent_return'.tr),
      body: _buildBody(),
    );
  }

  SingleChildScrollView _buildBody() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.only(
        right: 16.px,
        left: 16.px,
        top: 8.px,
      ),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.transparent,
            width: 0.5.px,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(10.px),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildConfirmInfo(),
            SizedBox(height: 24.px),
            _buildReturnDate(),
            SizedBox(height: 16.px),
            SolidButtonWidget(
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
            ),
          ],
        ),
      ),
    );
  }

  Column _buildReturnDate() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTextLabel(
          text: 'return_date'.tr,
          color: AppColors.secondary40,
        ),
        SizedBox(height: 8.px),
        Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () => controller.onChangeFollowPerContractTerm(
                        !controller.isFollowPerContractTerm.value),
                    borderRadius: BorderRadius.circular(8.px),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Switch(
                          activeTrackColor: AppColors.primary40,
                          value: controller.isFollowPerContractTerm.value,
                          onChanged: (value) {
                            controller.onChangeFollowPerContractTerm(value);
                            // controller.isFollowPerContractTerm.value = value;
                          },
                        ),
                        SizedBox(width: 8.px),
                        Text(
                          'per_contract_term'.tr,
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
                    onTap: controller.onTapTextFiledReturnDate,
                    readOnly: true,
                    textEditingController: controller.returnDateController,
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
              ),
              SizedBox(height: 16.px),
              OutlineTextFiledWidget(
                textLabel: 'reason'.tr,
                textEditingController: controller.reasonController,
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
                  text: 'commitment_statement'.tr,
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
                        TextSpan(text: 'commitment_agree'.tr),
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

  Widget _buildConfirmInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTextLabel(text: 'confirmation_info'.tr),
        SizedBox(height: 16.px),
        _buildTextType(
            text: 'room'.tr,
            value: '${controller.contractByStatusModel?.roomNumber}'),
        SizedBox(height: 16.px),
        _buildTextType(
          text: 'address'.tr,
          value: controller.contractByStatusModel?.roomAddress ?? '',
        ),
        SizedBox(height: 16.px),
        _buildTextType(
            text: 'Giá thuê'.tr,
            value:
                '${controller.contractByIdModel!.roomPrice?.toStringTotalthis(symbol: 'đ')}'),
        SizedBox(height: 16.px),
        _buildTextType(
          text: 'start_date'.tr,
          value: '${controller.contractByIdModel!.dateCreated?.ddMMyyyy}',
          leadingIcon: Icon(
            Icons.calendar_today_outlined,
            color: AppColors.secondary40,
            size: 24.px,
          ),
        ),
        SizedBox(height: 16.px),
        _buildTextLabel(text: 'return_request'.tr),
      ],
    );
  }

  Widget _buildTextType({
    required String text,
    required String value,
    Widget? leadingIcon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
          style: TextStyle(
            color: AppColors.secondary20,
            fontWeight: FontWeight.w500,
            fontSize: 16.sp,
          ),
        ),
        SizedBox(height: 4.px),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (leadingIcon != null)
              Row(
                children: [
                  leadingIcon,
                  SizedBox(width: 8.px),
                ],
              ),
            Expanded(
              child: Text.rich(
                TextSpan(text: value),
                style: TextStyle(
                  color: AppColors.secondary40,
                  fontWeight: FontWeight.w500,
                  fontSize: 16.sp,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTextLabel({
    required String text,
    TextStyle? style,
    Color? color,
  }) {
    return Text(
      text,
      style: style ??
          TextStyle(
            color: color ?? AppColors.primary40,
            fontWeight: FontWeight.w500,
            fontSize: 16.sp,
          ),
    );
  }
}
