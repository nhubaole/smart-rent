import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:smart_rent/core/config/app_colors.dart';
import 'package:smart_rent/core/extension/double_extension.dart';
import 'package:smart_rent/core/helper/help_regex.dart';
import 'package:smart_rent/core/widget/outline_text_filed_widget.dart';
import 'package:smart_rent/modules/landlord_contract_create/landlord_contract_create_controller.dart';

class ContentRentContract extends GetView<LandlordContractCreateController> {
  const ContentRentContract({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.only(
          right: 16.px,
          left: 16.px,
          bottom: MediaQuery.of(context).viewInsets.bottom + 10.px),
      child: Form(
        key: controller.formKeyPageOne,
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Nội dung thuê phòng trọ'.tr,
                style: TextStyle(
                  color: AppColors.primary40,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(height: 16.px),
            OutlineTextFiledWidget(
              textEditingController: controller.addressController,
              onValidateString: 'Enter',
              textLabel: 'ĐỊA CHỈ PHÒNG TRỌ'.tr,
              maxlines: 2,
            ),
            SizedBox(height: 16.px),
            OutlineTextFiledWidget(
              textEditingController: controller.roomNumberController,
              readOnly: true,
              onTap: () {},
              onValidateString: 'Enter',
              textLabel: 'PHÒNG SỐ'.tr,
            ),
            SizedBox(height: 16.px),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'GIÁ CHO THUÊ',
                style: TextStyle(
                  fontSize: 16.sp,
                  color: AppColors.secondary40,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(height: 8.px),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '*Giá niêm yết: ${controller.rentalRequestById.room?.totalPrice?.toFormatCurrency} đ/tháng',
                style: TextStyle(
                  fontSize: 15.sp,
                  color: AppColors.secondary40,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            SizedBox(height: 8.px),
            // Align(
            //   alignment: Alignment.centerLeft,
            //   child: Text(
            //     '** Giá yêu cầu: ${controller.rentalRequest.suggestedPrice?.toFormatCurrency} đ/tháng',
            //     style: TextStyle(
            //       fontSize: 15.sp,
            //       color: AppColors.secondary40,
            //       fontWeight: FontWeight.w400,
            //     ),
            //   ),
            // ),
            SizedBox(height: 16.px),
            OutlineTextFiledWidget(
              textEditingController: controller.retalPriceController,
              textInputType:
                  TextInputType.numberWithOptions(decimal: true, signed: true),
              onValidate: (p0) {
                if (p0 == null || p0.isEmpty) {
                  return 'Vui lòng nhập giá sẽ cho thuê';
                }
                // if (HelpRegex.isNumber(p0.replaceAll('.', '')) == false) {
                //   return 'Vui lòng nhập số';
                // }
                return null;
              },
              hintText: 'Nhập giá sẽ cho thuê',
              suffixUnit: '| đ/tháng',
            ),
            SizedBox(height: 16.px),
            OutlineTextFiledWidget(
              textEditingController: controller.paymentMethodController,
              onValidate: (p0) {
                if (p0 == null || p0.isEmpty) {
                  return 'Vui lòng chọn hình thức thanh toán';
                }
                return null;
              },
              textLabel: 'HÌNH THỨC THANH TOÁN',
              hintText: 'Chuyển khoản',
              onTap: controller.showPaymentMethod,
              readOnly: true,
            ),
            SizedBox(height: 16.px),
            OutlineTextFiledWidget(
              textEditingController: controller.electricPriceController,
              textInputType:
                  TextInputType.numberWithOptions(decimal: true, signed: true),
              onValidate: (p0) {
                if (p0 == null || p0.isEmpty) {
                  return 'Vui lòng nhập giá điện';
                }
                // if (HelpRegex.isNumber(p0) == false) {
                //   return 'Vui lòng nhập số';
                // }
                return null;
              },
              textLabel: 'TIỀN ĐIỆN',
              hintText: 'Nhập giá tiền điện',
              suffixUnit: '| đ/kwh',
            ),
            SizedBox(height: 16.px),
            OutlineTextFiledWidget(
              textEditingController: controller.waterPriceController,
              textInputType:
                  TextInputType.numberWithOptions(decimal: true, signed: true),
              onValidate: (p0) {
                if (p0 == null || p0.isEmpty) {
                  return 'Vui lòng nhập giá nước';
                }
                // if (HelpRegex.isNumber(p0) == false) {
                //   return 'Vui lòng nhập số';
                // }
                return null;
              },
              textLabel: 'TIỀN NƯỚC',
              hintText: 'Nhập giá tiền nước',
              suffixUnit: '| đ/người',
            ),
            SizedBox(height: 16.px),
            OutlineTextFiledWidget(
              textEditingController: controller.internetPriceController,
              textInputType:
                  TextInputType.numberWithOptions(decimal: true, signed: true),
              onValidate: (p0) {
                if (p0 == null || p0.isEmpty) {
                  return 'Vui lòng nhập giá internet';
                }
                // if (HelpRegex.isNumber(p0) == false) {
                //   return 'Vui lòng nhập số';
                // }
                return null;
              },
              textLabel: 'TIỀN INTERNET',
              hintText: 'Nhập giá tiền internet',
              suffixUnit: '| đ/người',
            ),
            SizedBox(height: 16.px),
            OutlineTextFiledWidget(
              textEditingController: controller.parkingPriceController,
              textInputType:
                  TextInputType.numberWithOptions(decimal: true, signed: true),
              onValidate: (p0) {
                if (p0 == null || p0.isEmpty) {
                  return 'Vui lòng nhập phí gửi xe';
                }
                // if (HelpRegex.isNumber(p0) == false) {
                //   return 'Vui lòng nhập số';
                // }
                return null;
              },
              textLabel: 'PHÍ GIỮ XE',
              hintText: 'Nhập giá phí giữ xe',
              suffixUnit: '| đ/người',
            ),
            SizedBox(height: 16.px),
            OutlineTextFiledWidget(
              textEditingController: controller.depositPriceController,
              textInputType:
                  TextInputType.numberWithOptions(decimal: true, signed: true),
              onValidate: (p0) {
                if (p0 == null || p0.isEmpty) {
                  return 'Vui lòng nhập số tiền đặt cọc';
                }
                // if (HelpRegex.isNumber(p0) == false) {
                //   return 'Vui lòng nhập số';
                // }
                return null;
              },
              textLabel: 'ĐẶT CỌC',
              hintText: 'Nhập giá tiền đặt cọc',
              suffixUnit: '| đ/người',
            ),
            SizedBox(height: 16.px),
            OutlineTextFiledWidget(
              textEditingController: controller.formDatePaidPerMonthController,
              onValidateString: 'Enter',
              textLabel: 'NGÀY THANH TOÁN HÀNG THẮNG',
              onTap: () => controller.onTapChoseDatePaidPerMonth(context),
              readOnly: true,
            ),
            SizedBox(height: 16.px),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Thời hạn hợp đồng'.tr,
                style: TextStyle(
                  color: AppColors.primary40,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(height: 16.px),
            Row(
              children: [
                Expanded(
                  child: OutlineTextFiledWidget(
                    onTap: () => controller.onTapChoseFromDate(context),
                    readOnly: true,
                    textEditingController: controller.fromDateController,
                    onValidate: (p0) {
                      return null;
                    },
                    suffixIcon: Icon(
                      Icons.calendar_today_outlined,
                      color: AppColors.secondary20,
                      size: 24.px,
                    ),
                  ),
                ),
                SizedBox(width: 8.px),
                Expanded(
                  child: OutlineTextFiledWidget(
                    onTap: () => controller.onTapChoseToDate(context),
                    readOnly: true,
                    textEditingController: controller.toDateController,
                    onValidate: (p0) {
                      return null;
                    },
                    suffixIcon: Icon(
                      Icons.calendar_today_outlined,
                      color: AppColors.secondary20,
                      size: 24.px,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(width: 8.px),
          ],
        ),
      ),
    );
  }
}
