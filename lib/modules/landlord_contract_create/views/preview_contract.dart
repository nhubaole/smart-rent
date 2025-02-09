import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:smart_rent/core/config/app_colors.dart';
import 'package:smart_rent/core/extension/datetime_extension.dart';
import 'package:smart_rent/core/extension/double_extension.dart';
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
                    text:
                        'Hôm nay, ngày ${controller.contractByIdModel?.dateCreated?.ddMMyyyy ?? DateTime.now().ddMMyyyy}, tại ${controller.contractByIdModel?.addressCreated ?? '...'}'),
                SizedBox(height: 8.px),
                _buildText(
                    textStyle:
                        childTextStyle.copyWith(fontWeight: FontWeight.bold),
                    text: 'Chúng tôi gồm:'),
                _buildText(
                  text: '1.Đại diện bên cho thuê phòng trọ (Bên A):',
                  textStyle: childTextStyle,
                ),
                _buildText(
                    text:
                        'Ông/bà: ${controller.contractByIdModel?.partyA?.name ?? controller.user.fullName ?? '..'}, Năm sinh: ${controller.contractByIdModel?.partyA?.dob?.ddMMyyyy ?? controller.user.dob?.ddMMyyyy ?? '...'}'),
                _buildText(text: 'Nơi đăng ký HK: ${controller.user.address}'),
                _buildText(
                    text:
                        'CMND/CCCD số: ${controller.contractByIdModel?.partyA?.cccd ?? '...'}, Cấp ngày: ${controller.contractByIdModel?.partyA?.issueDate?.ddMMyyyy ?? '...'}, Nơi cấp: ${controller.contractByIdModel?.partyA?.registeredPlace ?? '...'}'),
                _buildText(text: 'Điện thoại: ${controller.user.phoneNumber}'),
                _buildText(
                  text: '2. Bên thuê phòng trọ (Bên B):',
                  textStyle: childTextStyle.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                _buildText(
                    text:
                        'Ông/bà: ${controller.contractByIdModel?.partyB?.name ?? controller.rentalRequestById.sender?.fullName ?? '...'}, Sinh ngày: ${controller.contractByIdModel?.partyB?.dob?.ddMMyyyy ?? controller.rentalRequestById.sender?.dob?.ddMMyyyy ?? '...'}'),
                _buildText(
                    text:
                        'Nơi đăng ký HK thường trú: ${controller.rentalRequestById.sender?.address ?? '...'}'),
                _buildText(
                    text:
                        'CMND số: ${controller.contractByIdModel?.partyB?.cccd ?? '...'}, Cấp ngày: ${controller.contractByIdModel?.partyB?.issueDate?.ddMMyyyy ?? '...'}, Nơi cấp: ${controller.contractByIdModel?.partyB?.registeredPlace ?? '...'}'),
                _buildText(
                    text:
                        'Điện thoại: ${controller.rentalRequestById.sender?.phoneNumber ?? '...'}, Fax:....'),
                _buildText(
                    textStyle:
                        childTextStyle.copyWith(fontWeight: FontWeight.bold),
                    text:
                        'Sau khi bàn bạc trên tinh thần dân chủ, hai bên cùng có lợi, cùng thống nhất như sau:'),
                _buildText(
                    text:
                        'Bên A đồng ý cho bên B thuê 01 phòng ở tại địa chỉ: ${controller.contractByIdModel?.roomAddress?.join(', ') ?? controller.rentalRequestById.room?.addresses?.join(', ') ?? '...'}'),
                _buildText(
                    text:
                        'Giá thuê: ${controller.contractByIdModel?.roomPrice?.toStringTotalPrice ?? controller.rentalRequestById.room?.totalPrice?.toStringTotalPrice ?? '...'} đồng/tháng'),
                _buildText(
                    text:
                        'Hình thức thanh toán: ${controller.contractByIdModel?.method?.name ?? controller.paymentMethodController.text}'),
                _buildText(
                    text:
                        'Tiền điện: ${controller.contractByIdModel?.electricCost?.toStringTotalPrice ?? controller.electricPriceController.text} đ/kwh tính theo chỉ số công tơ, thanh toán vào cuối các tháng.'),
                _buildText(
                    text:
                        'Tiền nước: ${controller.contractByIdModel?.waterCost?.toStringTotalPrice ?? controller.waterPriceController.text} đ/người/tháng'),
                _buildText(
                    text:
                        'Tièn đặt cọc: ${controller.contractByIdModel?.deposit?.toStringTotalPrice ?? controller.depositPriceController.text} đồng'),
                _buildText(
                    text:
                        'Hợp đồng này có giá trị từ ngày ${controller.contractByIdModel?.startDate?.ddMMyyyy ?? controller.fromDateController.text} đến hết ngày ${controller.contractByIdModel?.endDate?.ddMMyyyy ?? controller.toDateController.text}'),
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
                ...controller.responsiblePartyAController.text
                    .split('\n')
                    .map((e) => _buildText(text: e)),
                SizedBox(height: 8.px),
                _buildText(
                  textStyle: childTextStyle.copyWith(
                    fontWeight: FontWeight.bold,
                    ),
                    text:
                        '* Trách nhiệm của bên B:'),
                ...controller.responsiblePartyBController.text
                    .split('\n')
                    .map((e) => _buildText(text: e)),
                SizedBox(height: 8.px),
                _buildText(
                  textStyle: childTextStyle.copyWith(
                    fontWeight: FontWeight.bold,
                    ),
                    text:
                        '* Trách nhiệm của chung:'),
                ...controller.responsiblejointCommonController.text
                    .split('\n')
                    .map((e) => _buildText(text: e)),
                _buildText(
                    text:
                        'Hợp đồng được lập thành 2 bản, mỗi bên giữ một bản và có giá trị như nhau.'),
                SizedBox(height: 8.px),
                // OLD VERSION
                // _buildText(
                //     text:
                //         '1. Gia hạn thời gian thuê: từ ngày ${controller.formDateController.text} đến hết ngày ${controller.toDateController.text}. Sau thời hạn gia hạn này, nếu Bên B tiếp tục thuê thì phảo thông báo cho Bên A chậm nhất là @@ trước khi chấm dứt hợp động thuê. Nếu Bên A đồng ý thì các bên sẽ thỏa thuận tiếp tục gia hạn bằng phụ lục hợp đồng khác hoặc ký một hợp đồng mới theo thỏa thuận được hai bên thống nhất.'),
                // SizedBox(height: 8.px),
                // _buildText(
                //     text:
                //         '2. Giá cho thuê trong thời hạn từ ngày ${controller.formDateController.text} đến ${controller.toDateController.text} là @@'),
                // SizedBox(height: 8.px),
                // _buildText(
                //     text:
                //         '3. Các điều khoản trong Hợp đòng thuê nhà số ${controller.contractByIdModel?.id} đã ký ngày ${controller.contractByIdModel?.dateCreated?.ddMMyyyy} và các phụ lục số @@ không thay đổi'),
                // SizedBox(height: 8.px),
                // _buildText(
                //   text: 'ĐIỀU 2: ĐIỀU KHOẢN THI HÀNH',
                //   textStyle: childTextStyle.copyWith(
                //     fontWeight: FontWeight.bold,
                //   ),
                // ),
                // SizedBox(height: 8.px),
                // _buildText(
                //     text:
                //         '- Phụ lục hợp đồng này là một bộ phận không tách rời của Hợp đồng thuê nhà số ${controller.contractByIdModel?.id}, đã ký ngày ${controller.contractByIdModel?.dateCreated?.ddMMyyyy}'),
                // SizedBox(height: 8.px),
                // _buildText(
                //     text:
                //         '- Phụ lục hợp đồng này có hiệu lực từ ngày ${controller.formDateController.text}.'),
                // SizedBox(height: 8.px),
                // _buildText(
                //     text:
                //         '- Phụ lục hợp đồng này được thành lập @@ bản, mỗi bên giữ 1 bản và có giá trị pháp lý như nhau'),

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
            style: childTextStyle.copyWith(fontWeight: FontWeight.bold)),
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