import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:smart_rent/core/config/app_colors.dart';
import 'package:smart_rent/core/enums/payment_method.dart';
import 'package:smart_rent/core/widget/custom_app_bar.dart';
import 'package:smart_rent/core/widget/scaffold_widget.dart';
import 'package:smart_rent/modules/landlord_contract_create/landlord_contract_create_controller.dart';

class PreviewContract extends GetView<LandlordContractCreateController> {
  const PreviewContract({super.key});

  static TextStyle childTextStyle = TextStyle(
    fontSize: 14.sp,
    color: AppColors.secondary40,
    fontWeight: FontWeight.w400,
  );

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      backgroundColor: AppColors.white,
      body: Obx(() => _buildContractDetail()),
    );
  }

SingleChildScrollView _buildContractDetail() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 16.px),
      child: Column(
        children: [
          _buildFirstPage(),
          SizedBox(height: 32.px),
          _buildSecondPage(),
          SizedBox(height: 32.px),
        ],
      ),
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
            text: ' ${controller.createContractModel.value?.address?.join(", ") ?? '--'}',
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

  Widget _buildPhoneTenant() {
    return Obx(() => Text.rich(
      textAlign: TextAlign.start,
      TextSpan(
        text: 'phone_renter'.tr,
        style: childTextStyle,
        children: [
          TextSpan(
            text: ' ${controller.partyA.value?.phoneNumber ?? '--'}',
            style: childTextStyle,
          ),
        ],
      ),
    ));
  }

  Text _buildTenantDetailInfo() {
    return Text.rich(
      textAlign: TextAlign.start,
      TextSpan(
        text: 'id_renter'.tr,
        style: childTextStyle,
        children: [
          TextSpan(text: '079303041940', style: childTextStyle),
          TextSpan(
              text: 'issued_date_renter'.tr.trParams({
                'day': '06',
                'month': '09',
                'year': '2022',
              }),
              style: childTextStyle),
          TextSpan(text: ' '),
          TextSpan(text: 'issued_place_renter'.tr, style: childTextStyle),
          TextSpan(
              text: 'Cục Cảnh sát Quản lý hành chính và trật tự xã hội', style: childTextStyle),
        ],
      ),
    );
  }

  Text _buildAddressTenant() {
    return Text.rich(
      textAlign: TextAlign.start,
      TextSpan(
          text: '${'address_renter'.tr} ${controller.partyB.value?.address}',
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
              text: ' ${controller.partyB.value?.fullName ?? '--'} ',
              style: childTextStyle),
          TextSpan(text: 'birth_renter'.tr, style: childTextStyle),
          TextSpan(
              text: ' ${controller.partyB.value?.dob ?? '--'}',
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
            text: ' ${controller.partyA.value?.phoneNumber ?? '--'}',
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
          TextSpan(text: ' ${083019245821} ', style: childTextStyle),
          TextSpan(
              text: 'issued_date_landlord'.tr.trParams({
                'day': '10',
                'month': '12',
                'year': '2021',
              }),
              style: childTextStyle),
          TextSpan(text: ' '),
          TextSpan(text: 'issued_place_landlord'.tr, style: childTextStyle),
          TextSpan(
              text: 'Cục Cảnh sát Quản lý hành chính và trật tự xã hội ',
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
              '${'address_landlord'.tr} ${controller.partyA.value?.address}',
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
              text: ' ${controller.partyA.value?.fullName ?? '--'} ',
              style: childTextStyle),
          TextSpan(text: 'birth_landlord'.tr, style: childTextStyle),
          TextSpan(
              text: ' ${controller.partyA.value?.dob ?? ''} ',
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
                DateTime.now().day.toString(),
            'month':
                DateTime.now().month.toString(),
            'year':
                DateTime.now().year.toString(),
            'address': 'Thành phố Hồ Chí Minh',
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
                text: '- ${controller.createContractModel.value?.responsibilityA}',
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
                text: '- ${controller.createContractModel.value?.responsibilityB}',
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
                              .createContractModel.value?.signatureA?.isNotEmpty ==
                          true)
                      SizedBox(
                        height: 80.px,
                        child: Column(
                          children: [
                            Image.memory(
                              fit: BoxFit.contain,
                              base64Decode(
                                    controller.createContractModel.value?.signatureA! ??
                                      ''),
                              width: 60.px,
                              height: 60.px,
                            ),
                            _buildText(
                              text:
                                  controller.createContractModel.value?.partyA.toString() ??
                                      '',
                              alignment: Alignment.center,
                            ),
                          ],
                        ),
                      ),
                      if (controller
                              .createContractModel.value?.signatureA?.isNotEmpty ==
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
            's_day': '${controller.createContractModel.value?.beginDate?.day}',
            's_month': '${controller.createContractModel.value?.beginDate?.month}',
            's_year': '${controller.createContractModel.value?.beginDate?.year}',
            'e_day': '${controller.createContractModel.value?.endDate?.day}',
            'e_month': '${controller.createContractModel.value?.endDate?.month}',
            'e_year': '${controller.createContractModel.value?.endDate?.year}',
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
                  '${controller.createContractModel.value?.electricityCost?.toString() ?? '--'} VND/ ${'month'.tr}',
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
                controller.createContractModel.value?.waterCost?.toString() ??
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
                controller.createContractModel.value?.electricityCost.toString() ??
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
                  ' ${controller.createContractModel.value?.paymentMethod?.name ?? PaymentMethod.cash.name} ',
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
                controller.createContractModel.value?.actualPrice?.toString() ??
                    '--'
          }),
          style: childTextStyle),
    );
  }


  Align _buildHeader() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        'preview_contract_template'.tr,
        style: TextStyle(
          color: AppColors.primary40,
          fontSize: 16.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
