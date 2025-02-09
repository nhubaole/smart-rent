import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:smart_rent/core/app/app_manager.dart';
import 'package:smart_rent/core/config/app_colors.dart';
import 'package:smart_rent/core/enums/loading_type.dart';
import 'package:smart_rent/core/enums/payment_method.dart';
import 'package:smart_rent/core/extension/datetime_extension.dart';
import 'package:smart_rent/core/extension/double_extension.dart';
import 'package:smart_rent/core/widget/custom_app_bar.dart';
import 'package:smart_rent/core/widget/error_widget.dart';
import 'package:smart_rent/core/widget/loading_widget.dart';
import 'package:smart_rent/core/widget/outline_button_widget.dart';
import 'package:smart_rent/core/widget/scaffold_widget.dart';
import 'package:smart_rent/core/widget/solid_button_widget.dart';
import 'package:smart_rent/modules/contract_detail/contract_detail_controller.dart';

class ContractDetailPage extends GetView<ContractDetailController> {
  const ContractDetailPage({super.key});

  static TextStyle childTextStyle = TextStyle(
    fontSize: 14.sp,
    color: AppColors.secondary40,
    fontWeight: FontWeight.w400,
  );

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      backgroundColor: AppColors.white,
      appBar: CustomAppBar(title: 'detaul_contract'.tr),
      body: Obx(() => _buildContractByStatus()),
      bottomNavigationBar: Obx(
        () => _buildButtonNav(),
      ),
    );
  }

  Widget _buildButtonNav() {
    if (controller.contractType != null && controller.contractType == 1) {
      return Padding(
        padding: EdgeInsets.only(
          left: 16.px,
          right: 16.px,
          bottom: 16.px,
          top: 8.px,
        ),
        child: Row(
          children: [
            Expanded(
              child: OutlineButtonWidget(
                padding: EdgeInsets.zero,
                height: 50.px,
                onTap: controller.isLoading.value == LoadingType.LOADING
                    ? null
                    : controller.onLeftButtonClick,
                text: 'Kết thúc'.tr,
                borderColor: AppColors.error,
                textColor: AppColors.error,
              ),
            ),
            SizedBox(width: 16.px),
            Expanded(
              child: SolidButtonWidget(
                padding: EdgeInsets.zero,
                height: 50.px,
                text: 'Gia hạn'.tr,
                onTap: controller.isLoading.value == LoadingType.LOADING
                    ? null
                    : controller.onRightButtonClick,
              ),
            ),
          ],
        ),
      );
    } else if (controller.contractType != null &&
        controller.contractType == 2) {
      return SizedBox();
    }
    else if (controller.contractType != null &&
        controller.contractType == 2) {
      return SizedBox();
    }
    return Visibility(
      visible: controller.isLoading.value == LoadingType.LOADED,
      child: controller.notiArgument != null
          ? _buildButtonFromNoti()
          : _buildButtonActions(),
    );
  }

  SingleChildScrollView _buildContractDetail() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 16.px),
      child: Column(
        children: [
          // _buildFirstPage(),
          // SizedBox(height: 32.px),
          // _buildSecondPage(),
          // SizedBox(height: 32.px),
          // NEW VERSION
          _buildNationalTitle(),
          SizedBox(height: 8.px),
          _buildMotto(),
          SizedBox(height: 8.px),
          _builtTitleContract(),
          SizedBox(height: 8.px),
          _buildText(
              text:
                  'Hôm nay, ngày ${controller.contractByIdModel?.dateCreated?.ddMMyyyy ?? DateTime.now().ddMMyyyy}, tại ${controller.contractByIdModel?.addressCreated ?? '...'}'),
          SizedBox(height: 8.px),
          _buildText(
              textStyle: childTextStyle.copyWith(fontWeight: FontWeight.bold),
              text: 'Chúng tôi gồm:'),
          _buildText(
            text: '1.Đại diện bên cho thuê phòng trọ (Bên A):',
            textStyle: childTextStyle,
          ),
          _buildText(
              text:
                  'Ông/bà: ${controller.contractByIdModel?.partyA?.name ?? '..'}, Năm sinh: ${controller.contractByIdModel?.partyA?.dob?.ddMMyyyy ?? '...'}'),
          _buildText(
              text:
                  'Nơi đăng ký HK: ${controller.contractByIdModel?.partyA?.registeredPlace ?? '...'}'),
          _buildText(
              text:
                  'CMND/CCCD số: ${controller.contractByIdModel?.partyA?.cccd ?? '...'}, Cấp ngày: ${controller.contractByIdModel?.partyA?.issueDate?.ddMMyyyy ?? '...'}, Nơi cấp: ${controller.contractByIdModel?.partyA?.registeredPlace ?? '...'}'),
          _buildText(
              text:
                  'Điện thoại: ${controller.contractByIdModel?.partyA?.phone}'),
          _buildText(
            text: '2. Bên thuê phòng trọ (Bên B):',
            textStyle: childTextStyle.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          _buildText(
              text:
                  'Ông/bà: ${controller.contractByIdModel?.partyB?.name ?? '...'}, Sinh ngày: ${controller.contractByIdModel?.partyB?.dob?.ddMMyyyy ?? '...'}'),
          _buildText(
              text:
                  'Nơi đăng ký HK thường trú: ${controller.contractByIdModel?.partyB?.registeredPlace ?? '...'}'),
          _buildText(
              text:
                  'CMND số: ${controller.contractByIdModel?.partyB?.cccd ?? '...'}, Cấp ngày: ${controller.contractByIdModel?.partyB?.issueDate?.ddMMyyyy ?? '...'}, Nơi cấp: ${controller.contractByIdModel?.partyB?.registeredPlace ?? '...'}'),
          _buildText(
              text:
                  'Điện thoại: ${controller.contractByIdModel?.partyB?.phone ?? '...'}, Fax:....'),
          _buildText(
              textStyle: childTextStyle.copyWith(fontWeight: FontWeight.bold),
              text:
                  'Sau khi bàn bạc trên tinh thần dân chủ, hai bên cùng có lợi, cùng thống nhất như sau:'),
          _buildText(
              text:
                  'Bên A đồng ý cho bên B thuê 01 phòng ở tại địa chỉ: ${controller.contractByIdModel?.roomAddress?.join(', ') ?? '...'}'),
          _buildText(
              text:
                  'Giá thuê: ${controller.contractByIdModel?.roomPrice?.toStringTotalPrice ?? '...'} đồng/tháng'),
          _buildText(
              text:
                  'Hình thức thanh toán: ${controller.contractByIdModel?.method?.name ?? '...'}'),
          _buildText(
              text:
                  'Tiền điện: ${controller.contractByIdModel?.electricCost?.toStringTotalPrice ?? '...'}  đ/kwh tính theo chỉ số công tơ, thanh toán vào cuối các tháng.'),
          _buildText(
              text:
                  'Tiền nước: ${controller.contractByIdModel?.waterCost?.toStringTotalPrice ?? '...'} đ/người/tháng'),
          _buildText(
              text:
                  'Tièn đặt cọc: ${controller.contractByIdModel?.deposit?.toStringTotalPrice ?? '...'} đồng'),
          _buildText(
              text:
                  'Hợp đồng này có giá trị từ ngày ${controller.contractByIdModel?.startDate?.ddMMyyyy ?? '...'} đến hết ngày ${controller.contractByIdModel?.endDate?.ddMMyyyy ?? '...'}'),
          SizedBox(height: 16.px),
          _buildText(
              textStyle: childTextStyle.copyWith(
                fontWeight: FontWeight.bold,
              ),
              text:
                        'TRÁCH NHIỆM CỦA CÁC BÊN'),
          _buildText(
              textStyle: childTextStyle.copyWith(
                fontWeight: FontWeight.bold,
              ),
              text:
                        '* Trách nhiệm của bên A:'),
          ...controller.contractByIdModel?.responsibilityA
                  ?.split('\n')
                  .map((e) => _buildText(text: e)) ??
              [],
          SizedBox(height: 8.px),
          _buildText(
              textStyle: childTextStyle.copyWith(
                fontWeight: FontWeight.bold,
              ),
              text:
                        '* Trách nhiệm của bên B:'),
          ...controller.contractByIdModel?.responsibilityB
                  ?.split('\n')
                  .map((e) => _buildText(text: e)) ??
              [],
          SizedBox(height: 8.px),
          // _buildText(
          //     textStyle: childTextStyle.copyWith(
          //       fontWeight: FontWeight.bold,
          //     ),
          //     text:
          //               '* Trách nhiệm của chung:'),
          // ...controller.responsiblejointCommonController.text
          //     .split('\n')
          //     .map((e) => _buildText(text: e)),
          _buildText(
              text:
                  'Hợp đồng được lập thành 2 bản, mỗi bên giữ một bản và có giá trị như nhau.'),
          SizedBox(height: 8.px),
          SizedBox(height: 8.px),
          SizedBox(height: 16.px),
          Container(
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1.px,
                        color: AppColors.secondary20,
                      ),
                    ),
                    child: Column(
                      children: [
                        _buildText(
                          text: 'Đại diện bên A',
                          textStyle: childTextStyle.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                          alignment: Alignment.center,
                        ),
                        SizedBox(height: 4.px),
                        _buildText(
                          text: '(Ký ghi rõ họ tên)',
                          alignment: Alignment.center,
                        ),
                        SizedBox(
                          height: 80.px,
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1.px,
                        color: AppColors.secondary20,
                      ),
                    ),
                    child: Column(
                      children: [
                        _buildText(
                          text: 'Đại diện bên B',
                          textStyle: childTextStyle.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                          alignment: Alignment.center,
                        ),
                        SizedBox(height: 4.px),
                        _buildText(
                          text: '(Ký ghi rõ họ tên)',
                          alignment: Alignment.center,
                        ),
                        SizedBox(
                          height: 80.px,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContractByStatus() {
    switch (controller.isLoading.value) {
      case LoadingType.INIT:
      case LoadingType.LOADING:
        return const LoadingWidget();
      case LoadingType.LOADED:
        return _buildContractDetail();
      case LoadingType.ERROR:
        return RefreshIndicator(
          onRefresh: () async {
            await controller.fetchContractById();
          },
          child: const ErrorCustomWidget(
            expandToCanPullToRefresh: true,
          ),
        );
    }
  }

  Widget _buildButtonActions() {
    if (AppManager().currentUser!.role == 1) {
      return SizedBox();
    } 
    return Padding(
      padding: EdgeInsets.only(
        left: 16.px,
        right: 16.px,
        bottom: 16.px,
        top: 8.px,
      ),
      child: Row(
        children: [
          Expanded(
            child: OutlineButtonWidget(
              padding: EdgeInsets.zero,
              height: 50.px,
              onTap: controller.isLoading.value == LoadingType.LOADING
                  ? null
                  : controller.onLeftButtonClick,
              text: 'disagree'.tr,
            ),
          ),
          SizedBox(width: 16.px),
          Expanded(
            child: SolidButtonWidget(
              padding: EdgeInsets.zero,
              height: 50.px,
              text: 'sign_contract'.tr,
              onTap: controller.isLoading.value == LoadingType.LOADING
                  ? null
                  : controller.onRightButtonClick,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButtonFromNoti() {
    return Padding(
      padding: EdgeInsets.only(
        left: 16.px,
        right: 16.px,
        bottom: 16.px,
        top: 8.px,
      ),
      child: Row(
        children: [
          Expanded(
            child: OutlineButtonWidget(
              padding: EdgeInsets.zero,
              height: 50.px,
              onTap: controller.isLoading.value == LoadingType.LOADING
                  ? null
                  : controller.onLeftButtonClick,
              text: 'Kết thúc'.tr,
              borderColor: AppColors.error,
              textColor: AppColors.error,
            ),
          ),
          SizedBox(width: 16.px),
          Expanded(
            child: SolidButtonWidget(
              padding: EdgeInsets.zero,
              height: 50.px,
              text: 'Gia hạn'.tr,
              onTap: controller.isLoading.value == LoadingType.LOADING
                  ? null
                  : controller.onRightButtonClick,
            ),
          ),
        ],
      ),
    );
  }

  Container _buildSecondPage() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8.px),
        border: Border.all(width: 1, color: AppColors.secondary80),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildRentPrice(),
          SizedBox(height: 8.px),
          _buildPaymentMethod(),
          SizedBox(height: 8.px),
          _buildElectrictyFee(),
          SizedBox(height: 8.px),
          _buildWaterFee(),
          SizedBox(height: 8.px),
          _buildInternetFee(),
          SizedBox(height: 8.px),
          _buildContractDuration(),
          SizedBox(height: 32.px),
          _buildResponsilities(),
          SizedBox(height: 8.px),
          _buildLandlordResponsibilities(),
          SizedBox(height: 8.px),
          Text.rich(
            textAlign: TextAlign.start,
            TextSpan(text: 'landlord_duty_1'.tr, style: childTextStyle),
          ),
          SizedBox(height: 8.px),
          Text.rich(
            textAlign: TextAlign.start,
            TextSpan(text: 'landlord_duty_2'.tr, style: childTextStyle),
          ),
          SizedBox(height: 8.px),
          Text.rich(
            textAlign: TextAlign.start,
            TextSpan(
                text: '- ${controller.contractByIdModel?.responsibilityA}',
                style: childTextStyle),
          ),
          SizedBox(height: 8.px),
          Text.rich(
            textAlign: TextAlign.start,
            TextSpan(
              text: 'tenant_responsibilities'.tr,
              style: childTextStyle.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 8.px),
          Text.rich(
            textAlign: TextAlign.start,
            TextSpan(text: 'tenant_duty_1'.tr, style: childTextStyle),
          ),
          SizedBox(height: 8.px),
          Text.rich(
            textAlign: TextAlign.start,
            TextSpan(text: 'tenant_duty_2'.tr, style: childTextStyle),
          ),
          SizedBox(height: 8.px),
          Text.rich(
            textAlign: TextAlign.start,
            TextSpan(text: 'tenant_duty_3'.tr, style: childTextStyle),
          ),
          SizedBox(height: 8.px),
          Text.rich(
            textAlign: TextAlign.start,
            TextSpan(text: 'tenant_duty_4'.tr, style: childTextStyle),
          ),
          SizedBox(height: 8.px),
          Text.rich(
            textAlign: TextAlign.start,
            TextSpan(
                text: '- ${controller.contractByIdModel?.responsibilityB}',
                style: childTextStyle),
          ),
          SizedBox(height: 8.px),
          Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1.px,
                      color: AppColors.secondary20,
                    ),
                  ),
                  child: Column(
                    children: [
                      _buildText(
                        text: 'Đại diện bên A',
                        textStyle: childTextStyle.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                        alignment: Alignment.center,
                      ),
                      SizedBox(height: 4.px),
                      _buildText(
                        text: '(Ký ghi rõ họ tên)',
                        
                        alignment: Alignment.center,
                      ),
                      if (controller
                              .contractByIdModel!.signatureA?.isNotEmpty ==
                          true)
                      SizedBox(
                        height: 80.px,
                        child: Column(
                          children: [
                            Image.memory(
                              fit: BoxFit.contain,
                              base64Decode(
                                    controller.contractByIdModel?.signatureA! ??
                                      ''),
                              width: 60.px,
                              height: 60.px,
                            ),
                            _buildText(
                              text:
                                  controller.contractByIdModel?.partyA?.name ??
                                      '',
                              alignment: Alignment.center,
                            ),
                          ],
                        ),
                      ),
                      if (controller
                              .contractByIdModel!.signatureA?.isNotEmpty ==
                          false)
                        SizedBox(height: 80.px),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1.px,
                      color: AppColors.secondary20,
                    ),
                  ),
                  child: Column(
                    children: [
                      _buildText(
                        text: 'Đại diện bên B',
                        textStyle: childTextStyle.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                        alignment: Alignment.center,
                      ),
                      SizedBox(height: 4.px),
                      _buildText(
                        text: '(Ký ghi rõ họ tên)',
                        alignment: Alignment.center,
                      ),
                      if (controller
                              .contractByIdModel!.signatureB?.isNotEmpty ==
                          true)
                        SizedBox(
                          height: 80.px,
                          child: Column(
                            children: [
                              Image.memory(
                                fit: BoxFit.contain,
                                base64Decode(
                                    controller.contractByIdModel?.signatureB ??
                                        ''),
                                width: 60.px,
                                height: 60.px,
                              ),
                              _buildText(
                                text: controller
                                        .contractByIdModel?.partyB?.name ??
                                    '',
                                alignment: Alignment.center,
                              ),
                            ],
                          ),
                        ),
                      if (controller
                              .contractByIdModel!.signatureB?.isNotEmpty ==
                          false)
                        SizedBox(
                          height: 80.px,
                        )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildText({
    required String text,
    AlignmentGeometry? alignment,
    TextStyle? textStyle,
  }) {
    return Align(
      alignment: alignment ?? Alignment.centerLeft,
      child: Text.rich(
        style: textStyle ?? childTextStyle,
        TextSpan(text: text),
      ),
    );
  }

  Text _buildLandlordResponsibilities() {
    return Text.rich(
      textAlign: TextAlign.start,
      TextSpan(
        text: 'landlord_responsibilities'.tr,
        style: childTextStyle.copyWith(fontWeight: FontWeight.bold),
      ),
    );
  }

  Text _buildResponsilities() {
    return Text.rich(
      textAlign: TextAlign.start,
      TextSpan(
        text: 'responsibilities'.tr,
        style: childTextStyle.copyWith(fontWeight: FontWeight.bold),
      ),
    );
  }

  Text _buildContractDuration() {
    return Text.rich(
      textAlign: TextAlign.start,
      TextSpan(
          text: 'contract_duration'.trParams({
            's_day': '${controller.contractByIdModel?.startDate?.day}',
            's_month': '${controller.contractByIdModel?.startDate?.month}',
            's_year': '${controller.contractByIdModel?.startDate?.year}',
            'e_day': '${controller.contractByIdModel?.endDate?.day}',
            'e_month': '${controller.contractByIdModel?.endDate?.month}',
            'e_year': '${controller.contractByIdModel?.endDate?.year}',
          }),
          style: childTextStyle),
    );
  }

  Text _buildInternetFee() {
    return Text.rich(
      textAlign: TextAlign.start,
      TextSpan(
        text: 'internet_fee'.tr,
        style: childTextStyle,
        children: [
          TextSpan(
              text:
                  '${controller.contractByIdModel?.electricCost?.toStringTotalPrice ?? '--'} VND/ ${'month'.tr}',
              style: childTextStyle)
        ],
      ),
    );
  }

  Text _buildWaterFee() {
    return Text.rich(
      textAlign: TextAlign.start,
      TextSpan(
          text: 'water_fee'.trParams({
            'price':
                controller.contractByIdModel?.waterCost?.toFormatCurrency ??
                    '--',
            'unit': 'VND'
          }),
          style: childTextStyle),
    );
  }

  Text _buildElectrictyFee() {
    return Text.rich(
      textAlign: TextAlign.start,
      TextSpan(
          text: 'electricity_fee'.trParams({
            'price':
                controller.contractByIdModel?.electricCost?.toFormatCurrency ??
                    '--',
            'unit': 'VND'
          }),
          style: childTextStyle),
    );
  }

  Text _buildPaymentMethod() {
    return Text.rich(
      textAlign: TextAlign.start,
      TextSpan(
        text: 'payment_method'.tr,
        style: childTextStyle,
        children: [
          TextSpan(
              text:
                  ' ${controller.contractByIdModel?.method?.name ?? PaymentMethod.cash.name} ',
              style: childTextStyle)
        ],
      ),
    );
  }

  Text _buildRentPrice() {
    return Text.rich(
      textAlign: TextAlign.start,
      TextSpan(
          text: 'rent_price'.trParams({
            'price':
                controller.contractByIdModel?.roomPrice?.toFormatCurrency ??
                    '--'
          }),
          style: childTextStyle),
    );
  }

  Container _buildFirstPage() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
        right: 20.px,
        left: 20.px,
        top: 20.px,
        bottom: 20.px,
      ),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8.px),
        border: Border.all(width: 1, color: AppColors.secondary80),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildNationalTitle(),
          SizedBox(height: 8.px),
          _buildMotto(),
          SizedBox(height: 16.px),
          _builtTitleContract(),
          SizedBox(height: 16.px),
          _buildDateLocation(),
          SizedBox(height: 8.px),
          _buildWeAreIncluding(),
          SizedBox(height: 8.px),
          _buildPartyLandlord(),
          SizedBox(height: 8.px),
          _buildNameLandlord(),
          SizedBox(height: 8.px),
          _buildAddressLandLord(),
          SizedBox(height: 8.px),
          _buildLandlordDetailInfo(),
          SizedBox(height: 8.px),
          _buildPhoneLandlord(),
          SizedBox(height: 8.px),
          _buildPartyTenant(),
          SizedBox(height: 8.px),
          _buildTenantInfo(),
          SizedBox(height: 8.px),
          _buildAddressTenant(),
          SizedBox(height: 8.px),
          _buildTenantDetailInfo(),
          SizedBox(height: 8.px),
          _buildPhoneTenant(),
          SizedBox(height: 8.px),
          _buildAgreementIntro(),
          SizedBox(height: 8.px),
          _buildRentalAgreement(),
        ],
      ),
    );
  }

  Text _buildRentalAgreement() {
    return Text.rich(
      textAlign: TextAlign.start,
      TextSpan(
        text: 'rental_agreement'.tr,
        style: childTextStyle,
        children: [
          TextSpan(
            text: ' ${controller.contractByStatusModel?.roomAddress ?? '--'}',
            style: childTextStyle,
          ),
        ],
      ),
    );
  }

  Text _buildAgreementIntro() {
    return Text.rich(
      textAlign: TextAlign.start,
      TextSpan(
          text: 'agreement_intro'.tr,
          style: childTextStyle.copyWith(fontWeight: FontWeight.bold)),
    );
  }

  Text _buildPhoneTenant() {
    return Text.rich(
      textAlign: TextAlign.start,
      TextSpan(
        text: 'phone_renter'.tr,
        style: childTextStyle,
        children: [
          TextSpan(
            text: ' ${controller.partyB?.phone ?? '--'}',
            style: childTextStyle,
          ),
        ],
      ),
    );
  }

  Text _buildTenantDetailInfo() {
    return Text.rich(
      textAlign: TextAlign.start,
      TextSpan(
        text: 'id_renter'.tr,
        style: childTextStyle,
        children: [
          TextSpan(text: ' ${controller.partyB?.cccd} ', style: childTextStyle),
          TextSpan(
              text: 'issued_date_renter'.tr.trParams({
                'day': controller.partyB?.issueDate?.day.toString() ?? '--',
                'month': controller.partyB?.issueDate?.month.toString() ?? '--',
                'year': controller.partyB?.issueDate?.year.toString() ?? '--',
              }),
              style: childTextStyle),
          TextSpan(text: ' '),
          TextSpan(text: 'issued_place_renter'.tr, style: childTextStyle),
          TextSpan(
              text: ' ${controller.partyB?.issueBy} ', style: childTextStyle),
        ],
      ),
    );
  }

  Text _buildAddressTenant() {
    return Text.rich(
      textAlign: TextAlign.start,
      TextSpan(
          text: '${'address_renter'.tr} ${controller.partyB?.registeredPlace}',
          style: childTextStyle),
    );
  }

  Text _buildTenantInfo() {
    return Text.rich(
      textAlign: TextAlign.start,
      TextSpan(
        text: 'name_renter'.tr,
        style: childTextStyle,
        children: [
          TextSpan(
              text: ' ${controller.partyB?.name ?? '--'} ',
              style: childTextStyle),
          TextSpan(text: 'birth_renter'.tr, style: childTextStyle),
          TextSpan(
              text: ' ${controller.partyB?.dob?.ddMMyyyy ?? '--'}',
              style: childTextStyle),
        ],
      ),
    );
  }

  Text _buildPartyTenant() {
    return Text.rich(
      textAlign: TextAlign.start,
      TextSpan(text: 'renter_info'.tr, style: childTextStyle),
    );
  }

  Text _buildPhoneLandlord() {
    return Text.rich(
      textAlign: TextAlign.start,
      TextSpan(
        text: 'phone_landlord'.tr,
        style: childTextStyle,
        children: [
          TextSpan(
            text: ' ${controller.partyA?.phone ?? '--'}',
            style: childTextStyle,
          ),
        ],
      ),
    );
  }

  Text _buildLandlordDetailInfo() {
    return Text.rich(
      textAlign: TextAlign.start,
      TextSpan(
        text: 'id_landlord'.tr,
        style: childTextStyle,
        children: [
          TextSpan(text: ' ${controller.partyA?.cccd} ', style: childTextStyle),
          TextSpan(
              text: 'issued_date_landlord'.tr.trParams({
                'day': controller.partyA?.issueDate?.day.toString() ?? '--',
                'month': controller.partyA?.issueDate?.month.toString() ?? '--',
                'year': controller.partyA?.issueDate?.year.toString() ?? '--',
              }),
              style: childTextStyle),
          TextSpan(text: ' '),
          TextSpan(text: 'issued_place_landlord'.tr, style: childTextStyle),
          TextSpan(
              text: controller.partyA?.issueBy?.toString() ?? '--',
              style: childTextStyle),
        ],
      ),
    );
  }

  Text _buildAddressLandLord() {
    return Text.rich(
      textAlign: TextAlign.start,
      TextSpan(
          text:
              '${'address_landlord'.tr} ${controller.partyA?.registeredPlace}',
          style: childTextStyle),
    );
  }

  Text _buildNameLandlord() {
    return Text.rich(
      textAlign: TextAlign.start,
      TextSpan(
        text: 'name_landlord'.tr,
        style: childTextStyle,
        children: [
          TextSpan(
              text: ' ${controller.partyA?.name ?? '--'} ',
              style: childTextStyle),
          TextSpan(text: 'birth_landlord'.tr, style: childTextStyle),
          TextSpan(
              text: ' ${controller.partyA?.dob?.ddMMyyyy ?? ''} ',
              style: childTextStyle),
        ],
      ),
    );
  }

  Text _buildPartyLandlord() {
    return Text.rich(
      textAlign: TextAlign.start,
      TextSpan(text: 'landlord_info'.tr, style: childTextStyle),
    );
  }

  Text _buildWeAreIncluding() {
    return Text.rich(
      textAlign: TextAlign.start,
      TextSpan(
        text: 'parties_involved'.tr,
        style: childTextStyle.copyWith(fontWeight: FontWeight.bold),
      ),
    );
  }

  Text _buildDateLocation() {
    return Text.rich(
      textAlign: TextAlign.start,
      TextSpan(
          text: 'date_location'.trParams({
            'day':
                controller.contractByStatusModel?.createdAt?.day.toString() ??
                    '--',
            'month':
                controller.contractByStatusModel?.createdAt?.month.toString() ??
                    '--',
            'year':
                controller.contractByStatusModel?.createdAt?.year.toString() ??
                    '--',
            'address': controller.contractByStatusModel?.roomAddress ?? '--',
          }),
          style: childTextStyle),
    );
  }

  Center _builtTitleContract() {
    return Center(
      child: Text.rich(
        TextSpan(text: 'title'.tr.toUpperCase(), style: childTextStyle),
      ),
    );
  }

  Center _buildMotto() {
    return Center(
      child: Text.rich(
        TextSpan(text: 'motto'.tr.toUpperCase(), style: childTextStyle),
      ),
    );
  }

  Center _buildNationalTitle() {
    return Center(
      child: Text.rich(
        textAlign: TextAlign.center,
        TextSpan(
          text: 'national_title'.tr.toUpperCase(),
          style: TextStyle(
            fontSize: 16.sp,
            color: AppColors.secondary40,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
