import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:smart_rent/core/app/app_manager.dart';
import 'package:smart_rent/core/config/app_colors.dart';
import 'package:smart_rent/core/extension/datetime_extension.dart';
import 'package:smart_rent/core/model/contract/contract_by_id_model.dart';
import 'package:smart_rent/core/model/user/user_model.dart';

class FormContractWidget extends StatelessWidget {
  final ContractByIdModel? detailContract;
  final UserModel? tenant;
  const FormContractWidget({
    super.key,
    this.detailContract,
    this.tenant,
  });

  static TextStyle boldTextStyle = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w600,
  );

  static TextStyle normalTextStyle = TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.w400,
  );

  UserModel get landLord => AppManager().currentUser!;

  @override
  Widget build(BuildContext context) {
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
        children: [
          _buildNationTitle(),
          SizedBox(height: 16.px),
          _buildToday(),
          SizedBox(height: 8.px),
          _buildWeAre(),
          SizedBox(height: 8.px),
          _buildPartyA(),
          SizedBox(height: 8.px),
          _buildPartyB(),
          SizedBox(height: 8.px),
          _buildContent(),
        ],
      ),
    );
  }

  Widget _buildContent() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Column(
        children: [
          Text.rich(
            TextSpan(
              text:
                  'Sau khi bàn bạc trên tinh thần dân chủ, hai bên cùng có lợi, cùng thống nhất như sau:',
              style: boldTextStyle,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPartyB() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text.rich(
            TextSpan(
              text: '2. Đại diện bên thuê phòng trọ (Bên B)',
              style: normalTextStyle,
            ),
          ),
          SizedBox(height: 8.px),
          Text.rich(
            TextSpan(
              style: normalTextStyle,
              children: [
                TextSpan(
                  text:
                      'Ông bà: ${detailContract?.partyB?.name ?? tenant?.fullName ?? '..........'}. ',
                ),
                TextSpan(
                  text:
                      'Sinh ngày: ${detailContract?.partyB?.dob?.ddMMyyyy ?? tenant?.dob?.ddMMyyyy ?? '..........'}',
                ),
              ],
            ),
          ),
          SizedBox(height: 8.px),
          Text.rich(
            TextSpan(
              text:
                  'Nơi đăng ký hộ khẩu: ${tenant?.dob?.ddMMyyyy ?? '..........'}',
              style: normalTextStyle,
            ),
          ),
          SizedBox(height: 8.px),
          // Text.rich(
          //   TextSpan(
          //     style: normalTextStyle,
          //     children: [
          //       TextSpan(
          //         text:
          //             'CMND số: ${detailContract?.partyB?.cccd ?? tenant?.idCard?.idCard ?? '.............'}',
          //       ),
          //       TextSpan(
          //         text:
          //             'Cấp ngày: ${detailContract?.partyB?.issueDate?.ddMMyyyy ?? tenant?.idCard?.createAt?.ddMMyyyy ?? '.......'}',
          //       ),
          //     ],
          //   ),
          // ),
          SizedBox(height: 8.px),
          Text.rich(
            TextSpan(
              text:
                  'Số điện thoại: ${detailContract?.partyB?.phone ?? tenant?.phoneNumber ?? '..........'}',
              style: normalTextStyle,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPartyA() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text.rich(
            TextSpan(
              text: '1. Đại diện bên cho thuê phòng trọ (Bên A)',
              style: normalTextStyle,
            ),
          ),
          SizedBox(height: 8.px),
          Text.rich(
            TextSpan(
              style: normalTextStyle,
              children: [
                TextSpan(
                  text:
                      'Ông bà: ${detailContract?.partyA?.name ?? landLord.fullName ?? '..........'}. ',
                ),
                TextSpan(
                  text:
                      'Sinh ngày: ${detailContract?.partyA?.dob?.ddMMyyyy ?? landLord.dob?.ddMMyyyy ?? '..........'}',
                ),
              ],
            ),
          ),
          SizedBox(height: 8.px),
          Text.rich(
            TextSpan(
              text: 'Nơi đăng ký hộ khẩu: ${landLord.address ?? '..........'}',
              style: normalTextStyle,
            ),
          ),
          SizedBox(height: 8.px),
          Text.rich(
            TextSpan(
              style: normalTextStyle,
              children: [
                TextSpan(
                  text:
                      'CMND số: ${detailContract?.partyA?.cccd ?? '.............'}',
                ),
                TextSpan(
                  text:
                      'Cấp ngày: ${detailContract?.partyA?.issueDate?.ddMMyyyy ?? '.......'}',
                ),
              ],
            ),
          ),
          SizedBox(height: 8.px),
          Text.rich(
            TextSpan(
              text:
                  'Số điện thoại: ${detailContract?.partyA?.phone ?? landLord.phoneNumber ?? '..........'}',
              style: normalTextStyle,
            ),
          ),
        ],
      ),
    );
  }

  Align _buildWeAre() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text.rich(
        TextSpan(text: 'Chúng tôi gồm có:', style: normalTextStyle),
      ),
    );
  }

  Align _buildToday() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text.rich(
        style: normalTextStyle,
        TextSpan(
          children: [
            TextSpan(
              text: 'Hôm nay, ngày ',
            ),
            TextSpan(
              text: detailContract?.dateCreated?.day.toString() ??
                  DateTime.now().day.toString(),
            ),
            TextSpan(
              text: ' tháng ',
            ),
            TextSpan(
              text: detailContract?.dateCreated?.month.toString() ??
                  DateTime.now().month.toString(),
            ),
            TextSpan(
              text: ' năm ',
            ),
            TextSpan(
              text: detailContract?.dateCreated?.year.toString() ??
                  DateTime.now().year.toString(),
            ),
          ],
        ),
      ),
    );
  }

  Column _buildNationTitle() {
    return Column(
      children: [
        Align(
          alignment: Alignment.center,
          child: Text(
            'CỘNG HOÀ XÃ HỘI CHỦ NGHĨA VIỆT NAM',
            style: boldTextStyle,
          ),
        ),
        SizedBox(height: 8.px),
        Align(
          alignment: Alignment.center,
          child: Text(
            'Độc lập - Tự do - Hạnh phúc',
            style: normalTextStyle,
          ),
        ),
        SizedBox(height: 8.px),
        Align(
          alignment: Alignment.center,
          child: Text(
            'HỢP ĐỒNG THUÊ NHÀ',
            style: boldTextStyle,
          ),
        ),
      ],
    );
  }
}
