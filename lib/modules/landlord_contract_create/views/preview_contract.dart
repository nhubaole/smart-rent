import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:smart_rent/core/config/app_colors.dart';
import 'package:smart_rent/core/extension/datetime_extension.dart';
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
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.only(
          right: 16.px,
          left: 16.px,
          bottom: MediaQuery.of(context).viewInsets.bottom + 10.px),
      child: Column(
        children: [
          _buildHeader(),
          SizedBox(height: 8.px),
          _buildPreviewContract(),
        ],
      ),
    );
  }

  Widget _buildPreviewContract() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 8.px),
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(
              right: 8.px,
              left: 8.px,
              top: 32.px,
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
                SizedBox(height: 8.px),
                _builtTitleContract(),
                SizedBox(height: 8.px),
                _buildText(
                  text: 'Số: ${controller.contractByIdModel?.id}',
                  alignment: Alignment.center,
                ),
                SizedBox(height: 8.px),
                _buildText(
                    text:
                        '- Căn cứ hợp đồng thuê số ${controller.contractByIdModel?.id} đã ký ngày ${controller.contractByIdModel?.startDate?.ddMMyyyy}'),
                SizedBox(height: 8.px),
                _buildText(
                    text:
                        '- Căn cứ phụ lục hợp đồng số ${controller.contractByIdModel?.id} đã ký ngày ${controller.contractByIdModel?.startDate?.ddMMyyyy}'),
                SizedBox(height: 8.px),
                _buildText(text: '- Căn cứ nhu cầu và khả năng của hai bên.'),
                SizedBox(height: 8.px),
                _buildText(
                    text:
                        'Hôm nay, ngày ${DateTime.now().ddMMyyyy}, tại ${controller.contractByIdModel?.addressCreated}'),
                SizedBox(height: 8.px),
                _buildText(
                    text:
                        'Thỏa thuận dưới đây được thành lập giữa các bên bao gồm:'),
                SizedBox(height: 8.px),
                _buildText(
                  text: 'BÊN A - BÊN CHO THUÊ:',
                  textStyle: childTextStyle.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.px),
                _buildText(
                    text:
                        'Họ và tên: ${controller.user.fullName}, Sinh ngày: ${controller.user.dob?.ddMMyyyy}'),
                SizedBox(height: 8.px),
                _buildText(
                    text:
                        'CMND số: ${controller.user.fullName}, Sinh ngày: ${controller.user.dob?.ddMMyyyy}'),
                SizedBox(height: 8.px),
                _buildText(
                    text:
                        'Địa chỉ: ${controller.user.address}, Sinh ngày: ${controller.user.dob?.ddMMyyyy}'),
                SizedBox(height: 8.px),
                _buildText(
                    text:
                        'Căn cứ theo Giấy chứng nhận quyền sở hữu nhà ở và quyền sử dụng đất ở: Số @@@@ do @@@ cấp ngày @@/@@/@@'),
                SizedBox(height: 8.px),
                _buildText(
                  text: 'BÊN B - BÊN THUÊ:',
                  textStyle: childTextStyle.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.px),
                _buildText(
                    text:
                        'Họ và tên: ${controller.user.fullName}, Sinh ngày: ${controller.user.dob?.ddMMyyyy}'),
                SizedBox(height: 8.px),
                _buildText(
                    text:
                        'CMND số: ${controller.user.fullName}, Sinh ngày: ${controller.user.dob?.ddMMyyyy}'),
                SizedBox(height: 8.px),
                _buildText(
                    text:
                        'Địa chỉ: ${controller.user.address}, Sinh ngày: ${controller.user.dob?.ddMMyyyy}'),
                SizedBox(height: 8.px),
                _buildText(
                    text:
                        'Căn cứ theo Giấy chứng nhận quyền sở hữu nhà ở và quyền sử dụng đất ở: Số @@@@ do @@@ cấp ngày @@/@@/@@'),
                SizedBox(height: 8.px),
                _buildText(
                    text:
                        'Sau khi bàn bạc thảo luận, hai bên đã thống nhất ký kết phụ lục gia hạn hợp đồng thuê nhà với các điều khoản như sau'),
                SizedBox(height: 8.px),
                _buildText(
                  text: 'ĐIỀU 1: NỘI DUNG',
                  textStyle: childTextStyle.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.px),
                _buildText(
                    text:
                        '1. Gia hạn thời gian thuê: từ ngày ${controller.formDateController.text} đến hết ngày ${controller.toDateController.text}. Sau thời hạn gia hạn này, nếu Bên B tiếp tục thuê thì phảo thông báo cho Bên A chậm nhất là @@ trước khi chấm dứt hợp động thuê. Nếu Bên A đồng ý thì các bên sẽ thỏa thuận tiếp tục gia hạn bằng phụ lục hợp đồng khác hoặc ký một hợp đồng mới theo thỏa thuận được hai bên thống nhất.'),
                SizedBox(height: 8.px),
                _buildText(
                    text:
                        '2. Giá cho thuê trong thời hạn từ ngày ${controller.formDateController.text} đến ${controller.toDateController.text} là @@'),
                SizedBox(height: 8.px),
                _buildText(
                    text:
                        '3. Các điều khoản trong Hợp đòng thuê nhà số ${controller.contractByIdModel?.id} đã ký ngày ${controller.contractByIdModel?.dateCreated?.ddMMyyyy} và các phụ lục số @@ không thay đổi'),
                SizedBox(height: 8.px),
                _buildText(
                  text: 'ĐIỀU 2: ĐIỀU KHOẢN THI HÀNH',
                  textStyle: childTextStyle.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.px),
                _buildText(
                    text:
                        '- Phụ lục hợp đồng này là một bộ phận không tách rời của Hợp đồng thuê nhà số ${controller.contractByIdModel?.id}, đã ký ngày ${controller.contractByIdModel?.dateCreated?.ddMMyyyy}'),
                SizedBox(height: 8.px),
                _buildText(
                    text:
                        '- Phụ lục hợp đồng này có hiệu lực từ ngày ${controller.formDateController.text}.'),
                SizedBox(height: 8.px),
                _buildText(
                    text:
                        '- Phụ lục hợp đồng này được thành lập @@ bản, mỗi bên giữ 1 bản và có giá trị pháp lý như nhau'),
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

  Center _builtTitleContract() {
    return Center(
      child: Text.rich(
        TextSpan(
            text: 'Phụ lục hợp đồng thuê trọ'.tr.toUpperCase(),
            style: childTextStyle),
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
