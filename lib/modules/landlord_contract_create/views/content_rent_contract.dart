import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:smart_rent/core/config/app_colors.dart';
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
              textEditingController: TextEditingController(),
              onValidateString: 'Enter',
              textLabel: 'ĐỊA CHỈ PHÒNG TRỌ'.tr,
              hintText: '97 đường số 11, phường Trường Thọ, TP Thủ...',
            ),
            SizedBox(height: 16.px),
            OutlineTextFiledWidget(
              textEditingController: TextEditingController(),
              onValidateString: 'Enter',
              textLabel: 'PHÒNG SỐ'.tr,
              hintText: '3.11',
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
                '*Giá niêm yết: 5 000 000 đ/tháng',
                style: TextStyle(
                  fontSize: 15.sp,
                  color: AppColors.secondary40,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            SizedBox(height: 8.px),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '** Giá yêu cầu: 4 500 000 đ/tháng',
                style: TextStyle(
                  fontSize: 15.sp,
                  color: AppColors.secondary40,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            SizedBox(height: 16.px),
            OutlineTextFiledWidget(
              textEditingController: TextEditingController(),
              onValidateString: 'Enter',
              hintText: '3.11',
              suffixUnit: '| đ/tháng',
            ),
            SizedBox(height: 16.px),
            OutlineTextFiledWidget(
              textEditingController: TextEditingController(),
              onValidateString: 'Enter',
              textLabel: 'HÌNH THỨC THANH TOÁN',
              hintText: '3.11',
            ),
            SizedBox(height: 16.px),
            OutlineTextFiledWidget(
              textEditingController: TextEditingController(),
              onValidateString: 'Enter',
              textLabel: 'TIỀN ĐIỆN',
              hintText: '3.11',
              suffixUnit: '| đ/kwh',
            ),
            SizedBox(height: 16.px),
            OutlineTextFiledWidget(
              textEditingController: TextEditingController(),
              onValidateString: 'Enter',
              textLabel: 'TIỀN NƯỚC',
              hintText: '3.11',
              suffixUnit: '| đ/người',
            ),
            SizedBox(height: 16.px),
            OutlineTextFiledWidget(
              textEditingController: TextEditingController(),
              onValidateString: 'Enter',
              textLabel: 'TIỀN INTERNET',
              hintText: '3.11',
              suffixUnit: '| đ/người',
            ),
            SizedBox(height: 16.px),
            OutlineTextFiledWidget(
              textEditingController: TextEditingController(),
              onValidateString: 'Enter',
              textLabel: 'PHÍ GIỮ XE',
              hintText: '3.11',
              suffixUnit: '| đ/người',
            ),
            SizedBox(height: 16.px),
            OutlineTextFiledWidget(
              textEditingController: TextEditingController(),
              onValidateString: 'Enter',
              textLabel: 'ĐẶT CỌC',
              hintText: '3.11',
              suffixUnit: '| đ/người',
            ),
            SizedBox(height: 16.px),
            OutlineTextFiledWidget(
              textEditingController: TextEditingController(),
              onValidateString: 'Enter',
              textLabel: 'NGÀY THANH TOÁN HÀNG THẮNG',
              hintText: '3.11',
              suffixUnit: '| đ/người',
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
                    textEditingController: controller.formDateController,
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
