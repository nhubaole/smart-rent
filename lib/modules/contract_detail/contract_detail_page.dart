import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:smart_rent/core/config/app_colors.dart';
import 'package:smart_rent/core/widget/custom_app_bar.dart';
import 'package:smart_rent/modules/contract_detail/contract_detail_controller.dart';

class DetailContractPage extends GetView<ContractDetailController> {
  const DetailContractPage({super.key});

  static TextStyle childTextStyle = TextStyle(
    fontSize: 14.sp,
    color: AppColors.secondary40,
    fontWeight: FontWeight.w400,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: CustomAppBar(title: 'detaul_contract'.tr),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            _buildFirstPage(),
            SizedBox(height: 32.px),
            _buildSecondPage(),
            SizedBox(height: 32.px),
          ],
        ),
      ),
      bottomNavigationBar: _buildButtonActions(),
    );
  }

  Padding _buildButtonActions() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.px, vertical: 16.px),
      child: Row(
        children: [
          Expanded(
            child: InkWell(
              borderRadius: BorderRadius.circular(20.px),
              onTap: () {},
              child: Container(
                height: 50,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.px),
                  border: Border.all(width: 1.5, color: AppColors.primary60),
                ),
                child: Text(
                  'disagree'.tr,
                  style: const TextStyle(
                      color: AppColors.primary60, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          SizedBox(width: 16.px),
          Expanded(
            child: InkWell(
              borderRadius: BorderRadius.circular(20.px),
              onTap: () => controller.onContractSign(),
              child: Container(
                height: 50,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.px),
                  color: AppColors.primary40,
                ),
                child: Text(
                  'sign_contract'.tr,
                  style: const TextStyle(
                      color: AppColors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container _buildSecondPage() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 8.px),
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
      TextSpan(text: 'contract_duration'.tr, style: childTextStyle),
    );
  }

  Text _buildInternetFee() {
    return Text.rich(
      textAlign: TextAlign.start,
      TextSpan(
        text: 'internet_fee'.tr,
        style: childTextStyle,
        children: [
          TextSpan(text: '______________________', style: childTextStyle)
        ],
      ),
    );
  }

  Text _buildWaterFee() {
    return Text.rich(
      textAlign: TextAlign.start,
      TextSpan(text: 'water_fee'.tr, style: childTextStyle),
    );
  }

  Text _buildElectrictyFee() {
    return Text.rich(
      textAlign: TextAlign.start,
      TextSpan(text: 'electricity_fee'.tr, style: childTextStyle),
    );
  }

  Text _buildPaymentMethod() {
    return Text.rich(
      textAlign: TextAlign.start,
      TextSpan(
        text: 'payment_method'.tr,
        style: childTextStyle,
        children: [
          TextSpan(text: '______________________', style: childTextStyle)
        ],
      ),
    );
  }

  Text _buildRentPrice() {
    return Text.rich(
      textAlign: TextAlign.start,
      TextSpan(text: 'rent_price'.tr, style: childTextStyle),
    );
  }

  Container _buildFirstPage() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 8.px),
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
            text: '______________________',
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
            text: '______________________',
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
          TextSpan(text: '________', style: childTextStyle),
          TextSpan(text: 'issued_date_renter'.tr, style: childTextStyle),
          TextSpan(text: '_________', style: childTextStyle),
          TextSpan(text: 'issued_place_renter'.tr, style: childTextStyle),
          TextSpan(text: '_________', style: childTextStyle),
        ],
      ),
    );
  }

  Text _buildAddressTenant() {
    return Text.rich(
      textAlign: TextAlign.start,
      TextSpan(text: 'address_renter'.tr, style: childTextStyle),
    );
  }

  Text _buildTenantInfo() {
    return Text.rich(
      textAlign: TextAlign.start,
      TextSpan(
        text: 'name_renter'.tr,
        style: childTextStyle,
        children: [
          TextSpan(text: '______________________', style: childTextStyle),
          TextSpan(text: 'birth_renter'.tr, style: childTextStyle),
          TextSpan(text: '______________________', style: childTextStyle),
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
            text: '______________________',
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
          TextSpan(text: '________', style: childTextStyle),
          TextSpan(text: 'issued_date_landlord'.tr, style: childTextStyle),
          TextSpan(text: '_________', style: childTextStyle),
          TextSpan(text: 'issued_place_landlord'.tr, style: childTextStyle),
          TextSpan(text: '_________', style: childTextStyle),
        ],
      ),
    );
  }

  Text _buildAddressLandLord() {
    return Text.rich(
      textAlign: TextAlign.start,
      TextSpan(text: 'address_landlord'.tr, style: childTextStyle),
    );
  }

  Text _buildNameLandlord() {
    return Text.rich(
      textAlign: TextAlign.start,
      TextSpan(
        text: 'name_landlord'.tr,
        style: childTextStyle,
        children: [
          TextSpan(text: '______________________', style: childTextStyle),
          TextSpan(text: 'birth_landlord'.tr, style: childTextStyle),
          TextSpan(text: '______________________', style: childTextStyle),
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
      TextSpan(text: 'date_location'.tr, style: childTextStyle),
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
