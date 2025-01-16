import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:smart_rent/core/config/app_colors.dart';
import 'package:smart_rent/core/routes/app_routes.dart';
import 'package:smart_rent/core/values/image_assets.dart';
import 'package:smart_rent/core/widget/button_setting_widget.dart';
import 'package:smart_rent/core/widget/cache_image_widget.dart';
import 'package:smart_rent/core/widget/keep_alive_wrapper.dart';
import 'package:smart_rent/core/widget/outline_button_widget.dart';
import 'package:smart_rent/core/widget/scaffold_widget.dart';
import 'package:smart_rent/core/widget/solid_button_widget.dart';
import 'package:smart_rent/modules/user_profile/user_profile_controller.dart';

class UserProfilePage extends GetView<UserProfileController> {
  const UserProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return KeepAliveWrapper(
      wantKeepAlive: true,
      child: ScaffoldWidget(
        body: GetBuilder<UserProfileController>(
          id: 'user_profile',
          init: controller,
          builder: (controller) => Stack(
            children: [
              _buildBackground(),
              _buildTextTitlePage(),
              _buildContent(),
            ],
          ),
        ),
      ),
    );
  }

  Container _buildBackground() {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            AppColors.primary40,
            AppColors.primary80,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
    );
  }

  Column _buildContent() {
    return Column(
      children: [
        _buildButtonNavFeature(),
      ],
    );
  }

  Align _buildTextTitlePage() {
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: EdgeInsets.only(left: 16.px, right: 16.px, top: 10.h),
        child: Text(
          'Tài khoản',
          style: TextStyle(
            color: AppColors.white,
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Expanded _buildButtonNavFeature() {
    return Expanded(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          margin: EdgeInsets.only(top: Get.height * 0.15),
          padding: EdgeInsets.only(top: 32.px),
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8.w),
              topRight: Radius.circular(8.w),
            ),
          ),
          child: Column(
            children: [
              _buildInfoUser(),
              SizedBox(height: 16.px),
              ButtonSettingWidget(
                icon: FontAwesomeIcons.person,
                title: 'Thông tin cá nhân',
                onTap: () {
                  Get.toNamed(AppRoutes.userProfileDetail);
                },
              ),
              ButtonSettingWidget(
                icon: Icons.policy,
                title: 'Điều khoản và chính sách',
                onTap: () {},
              ),
              ButtonSettingWidget(
                icon: Icons.notification_important_rounded,
                title: 'Thông báo',
                onTap: () {},
              ),
              ButtonSettingWidget(
                icon: FontAwesomeIcons.toolbox,
                title: 'Báo cáo sự cố',
                onTap: () {},
              ),
              SizedBox(height: 16.px),
              if (controller.user.role == 0)
                OutlineButtonWidget(
                  margin: EdgeInsets.symmetric(horizontal: 16.px),
                  padding: EdgeInsets.zero,
                  height: 40.px,
                  onTap: controller.onAskToUpgradeToLandlord,
                  text: 'Chuyển sang tài khoản Chủ nhà',
                ),
              SizedBox(height: 16.px),
              SolidButtonWidget(
                margin: EdgeInsets.symmetric(horizontal: 16.px),
                padding: EdgeInsets.zero,
                height: 40.px,
                text: 'Đăng xuất',
                onTap: controller.onLogout,
                icon: Icon(
                  Icons.logout,
                  color: AppColors.white,
                  size: 24.px,
                ),
              ),
              SizedBox(height: 16.px),
              _buildInAppUpdate(),
              SizedBox(height: 16.px),
            ],
          ),
        ),
      ),
    );
  }

  Container _buildInAppUpdate() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.px),
      child: Material(
        color: AppColors.transparent,
        child: InkWell(
          enableFeedback: true,
          onTap: controller.checkingAvailabeInAppUpdate,
          splashColor: AppColors.secondary90,
          borderRadius: BorderRadius.circular(8.px),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 8.px),
            width: double.infinity,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.px),
            ),
            child: Text(
              'Thông tin phiên bản ${controller.version}(${controller.buildNumber})',
              style: TextStyle(
                color: AppColors.secondary60,
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Column _buildInfoUser() {
    return Column(
      children: [
        InkWell(
          onTap: () {
            print('object');
          },
          borderRadius: BorderRadius.circular(100.px),
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
              // Positioned(
              //   bottom: 3.h,
              //   right: 3.w,
              //   child: InkWell(
              //     onTap: () {},
              //     child: Container(
              //       padding: EdgeInsets.all(4.px),
              //       decoration: BoxDecoration(
              //         color: AppColors.white,
              //         shape: BoxShape.circle,
              //         border: Border.all(
              //           color: AppColors.primary40,
              //           width: 1.px,
              //         ),
              //       ),
              //       child: Center(
              //         child: Icon(
              //           Icons.edit,
              //           color: AppColors.primary40,
              //           size: 16.px,
              //         ),
              //       ),
              //     ),
              //   ),
              // )
            ],
          ),
        ),
        Text(
          controller.user.fullName ?? '',
          style: TextStyle(
            color: AppColors.primary40,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 8.px),
        Text(
          controller.user.phoneNumber ?? '',
          style: TextStyle(
            color: AppColors.secondary60,
            fontSize: 16.sp,
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(height: 8.px),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.px, vertical: 4.px),
          decoration: BoxDecoration(
            color: AppColors.primary40,
            borderRadius: BorderRadius.circular(4.px),
          ),
          child: Text(
            controller.user.role == 0 ? 'Người thuê' : 'Chủ nhà',
            style: TextStyle(
              color: AppColors.white,
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        )
      ],
    );
  }
}
