import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:smart_rent/core/config/app_colors.dart';
import 'package:smart_rent/core/helper/help_regex.dart';
import 'package:smart_rent/core/values/image_assets.dart';
import 'package:smart_rent/core/widget/cache_image_widget.dart';
import 'package:smart_rent/core/widget/custom_app_bar.dart';
import 'package:smart_rent/core/widget/outline_text_filed_widget.dart';
import 'package:smart_rent/core/widget/scaffold_widget.dart';
import 'package:smart_rent/core/widget/solid_button_widget.dart';
import 'package:smart_rent/modules/user_profile/user_profile_controller.dart';

class UserProfileDetailPage extends GetView<UserProfileController> {
  const UserProfileDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      appBar: CustomAppBar(title: 'Thông tin cá nhân'),
      body: _buildBody(context),
      bottomNavigationBar: SolidButtonWidget(
        margin: EdgeInsets.symmetric(horizontal: 16.px, vertical: 4.px),
        padding: EdgeInsets.zero,
        height: 50.px,
        text: 'Cập nhật',
        onTap: controller.onUpdateUserProfile,
      ),
    );
  }

  SingleChildScrollView _buildBody(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 16.px),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 16.px),
          Center(child: _buildInfoUser()),
          SizedBox(height: 16.px),
          Form(
            key: controller.formKey,
            child: Column(
              children: [
                _buildInfoTextField(context),
                SizedBox(height: 16.px),
                _buildPaymentInfo(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentInfo() {
    final textStyleInput = TextStyle(
      fontSize: 16.sp,
      color: AppColors.primary40,
      fontWeight: FontWeight.w600,
    );
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Thông tin thanh toán',
            style: TextStyle(
              color: AppColors.secondary20,
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        SizedBox(height: 16.px),
        Container(
          padding: EdgeInsets.all(8.px),
          decoration: BoxDecoration(
            color: AppColors.red90,
            borderRadius: BorderRadius.circular(8.px),
            border: Border.all(
              color: AppColors.red70,
              width: 1.px,
            ),
          ),
          child: Text.rich(
            style: TextStyle(
              color: AppColors.red60,
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
            TextSpan(
                text:
                    'Vui lòng cập nhật thông tin tài khoản ngân hàng của bạn để nhận  các khoản thanh toán một cách thuận tiện và nhanh chóng!'),
          ),
        ),
        SizedBox(height: 16.px),
        OutlineTextFiledWidget(
          inSideContainer: true,
          textLabel: 'Số tài khoản',
          textEditingController: controller.numberCreditCardController,
          onValidate: (p0) {
            return null;
          },
          textStyleInput: textStyleInput,
        ),
        SizedBox(height: 16.px),
        OutlineTextFiledWidget(
          inSideContainer: true,
          textLabel: 'Tên tài khoản (Tiếng Việt không dấu, viết hoa)',
          textEditingController: controller.nameCreditCardController,
          onValidate: (p0) {
            if (p0 == null || p0.isEmpty) {
              return 'Vui lòng nhập tên tài khoản';
            }

            if (HelpRegex.isVietnameseNoDiacritics(p0)) {
              return 'Tên tài khoản không hợp lệ';
            }
            return null;
          },
          textStyleInput: textStyleInput,
        ),
        SizedBox(height: 16.px),
        OutlineTextFiledWidget(
          inSideContainer: true,
          textLabel: 'Ngân hàng',
          textEditingController: controller.bandNameController,
          onTap: controller.onChoseBank,
          readOnly: true,
          onValidate: (p0) {
            return null;
          },
          textStyleInput: textStyleInput,
        ),
        SizedBox(height: 16.px),
      ],
    );
  }

  Widget _buildInfoTextField(BuildContext context) {
    final textStyleInput = TextStyle(
      fontSize: 16.sp,
      color: AppColors.primary40,
      fontWeight: FontWeight.w600,
    );
    return Column(
      children: [
        OutlineTextFiledWidget(
          inSideContainer: true,
          textLabel: 'Họ và tên',
          textEditingController: controller.fullNameController,
          onValidate: (p0) {
            return null;
          },
          textStyleInput: textStyleInput,
        ),
        SizedBox(height: 16.px),
        OutlineTextFiledWidget(
          inSideContainer: true,
          textLabel: 'Số điện thoại',
          textEditingController: controller.phoneController,
          onValidate: (p0) {
            return null;
          },
          textStyleInput: textStyleInput,
        ),
        SizedBox(height: 16.px),
        OutlineTextFiledWidget(
          inSideContainer: true,
          textLabel: 'Địa chỉ',
          textEditingController: controller.fullNameController,
          onValidate: (p0) {
            return null;
          },
          textStyleInput: textStyleInput,
        ),
        SizedBox(height: 16.px),
        Row(
          children: [
            Expanded(
              child: OutlineTextFiledWidget(
                inSideContainer: true,
                textLabel: 'Giới tính',
                textEditingController: controller.genderController,
                onValidate: (p0) {
                  return null;
                },
                textStyleInput: textStyleInput,
              ),
            ),
            SizedBox(width: 16.px),
            Expanded(
              child: OutlineTextFiledWidget(
                inSideContainer: true,
                textLabel: 'Năm sinh',
                textEditingController: controller.dobController,
                onValidate: (p0) {
                  return null;
                },
                onTap: () => controller.onTapChoseFromDate(context),
                readOnly: true,
                suffixIcon: Icon(
                  Icons.calendar_today_outlined,
                  color: AppColors.secondary20,
                  size: 24.px,
                ),
                textStyleInput: textStyleInput,
              ),
            ),
          ],
        )
      ],
    );
  }

  Widget _buildInfoUser() {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(100.px),
      child: Padding(
        padding: EdgeInsets.all(8.px),
        child: Stack(
          fit: StackFit.loose,
          children: [
            ClipOval(
              child: CacheImageWidget(
                imageUrl: controller.user.avatarUrl ?? ImageAssets.demo,
                width: 12.h,
                height: 12.h,
              ),
            ),
            Positioned(
              bottom: 0,
              child: ClipOval(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  heightFactor: 0.4,
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                    child: Container(
                      width: 12.h,
                      height: 12.h,
                      decoration: BoxDecoration(
                        color: AppColors.black.withOpacity(0.3),
                        shape: BoxShape.circle,
                      ),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Icon(
                          Icons.camera_alt,
                          color: AppColors.white,
                          size: 24.px,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
