import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
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
          _buildFirstPage(),
          SizedBox(height: 32.px),
          _buildSecondPage(),
          SizedBox(height: 32.px),
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
      padding: EdgeInsets.only(
        right: 8.px,
        left: 8.px,
        top: 8.px,
        bottom: 16.px,
      ),
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
        ],
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
            'price': controller
                    .contractByIdModel?.electricCost?.toFormatCurrency ??
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
                  ' ${controller.contractByIdModel?.method?.name ?? PaymentMethod.no.name} ',
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
        right: 8.px,
        left: 8.px,
        top: 8.px,
        bottom: 32.px,
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
              text:
                  ' ${controller.partyA?.dob?.ddMMyyyy ?? ''} ',
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
