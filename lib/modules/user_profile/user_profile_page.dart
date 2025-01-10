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
        body: Stack(
          children: [
            Container(
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
            ),
            _buildContent(),
          ],
        ),
      ),
    );
  }

  Column _buildContent() {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
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
        ),
        SizedBox(height: 16.px),
        _buildButtonNavFeature(),
      ],
    );
  }

  Expanded _buildButtonNavFeature() {
    return Expanded(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          padding: EdgeInsets.only(top: 32.px),
          width: double.infinity,
          constraints: BoxConstraints(
            minHeight: Get.height,
          ),
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
              SizedBox(height: 32.px),
              ButtonSettingWidget(
                icon: FontAwesomeIcons.person,
                title: 'Thông tin các nhân',
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
                  onTap: controller.onUpgradeToLandlord,
                  text: 'Chuyển sang tài khoản Chủ nhà',
                ),
              SizedBox(height: 16.px),
              SolidButtonWidget(
                margin: EdgeInsets.symmetric(horizontal: 16.px),
                text: 'Đăng xuất',
                onTap: controller.onLogout,
                icon: Icon(
                  Icons.logout,
                  color: AppColors.white,
                  size: 24.px,
                ),
              )
            ],
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
      ],
    );
  }
}
