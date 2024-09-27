import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/config/app_colors.dart';
import '../../auth/login/views/login_screen.dart';
import '/core/resources/auth_methods.dart';
import '/core/values/app_colors.dart';
import '/modules/manage_account/controllers/account_nav_button_controller.dart';
import '/modules/manage_account/views/nav_screen/account_detail.dart';
import '/modules/manage_account/views/nav_screen/notify_setting.dart';
import '/modules/manage_account/views/nav_screen/policy.dart';

class AccountNavButton extends StatelessWidget {
  const AccountNavButton({super.key});

  @override
  Widget build(BuildContext context) {
    final AccountNavButtonController mainController =
        Get.put(AccountNavButtonController());
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: Column(
          children: [
            AccountButtonNav(
              nameButton: 'Thông tin cá nhân',
              onPressed: () {
                mainController.goToScreen(
                  const AccountDetailScreen(),
                );
              },
              firstIcon: Icons.person,
            ),
            const SizedBox(
              height: 10,
            ),
            AccountButtonNav(
              nameButton: 'Điều khoản và chính sách',
              onPressed: () {
                Get.to(const PolicyScreen());
              },
              firstIcon: Icons.verified_user,
            ),
            const SizedBox(
              height: 10,
            ),
            AccountButtonNav(
              nameButton: 'Thông báo',
              onPressed: () {
                mainController.goToScreen(
                  const NotifySettingScreen(),
                );
              },
              firstIcon: Icons.notifications,
            ),
            const SizedBox(
              height: 10,
            ),
            AccountButtonNav(
              nameButton: 'Báo cáo sự cố',
              onPressed: () {},
              firstIcon: Icons.report,
            ),
            const SizedBox(
              height: 30,
            ),
            InkWell(
              onTap: () {
                AuthMethods.logout();
                Get.offAll(const LoginScreen());
              },
              child: Container(
                alignment: Alignment.center,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: AppColors.primary60),
                child: const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.logout, color: Colors.white),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        'Đăng xuất',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w400),
                      ),
                    ],
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

class AccountButtonNav extends StatelessWidget {
  final String nameButton;
  final void Function() onPressed;
  final IconData firstIcon;

  const AccountButtonNav({
    super.key,
    required this.nameButton,
    required this.onPressed,
    required this.firstIcon,
  });
  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      icon: Icon(
        firstIcon,
        color: AppColors.primary40,
      ),
      label: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            nameButton,
            textAlign: TextAlign.left,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: AppColors.primary40,
            ),
          ),
          const Icon(
            Icons.arrow_forward_ios,
            color: AppColors.primary40,
          )
        ],
      ),
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        shadowColor: AppColors.secondary80,
        //foregroundColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          // side: const BorderSide(
          //   color: AppColors.secondary80,
          // ),
        ),
        fixedSize: const Size(
          double.infinity,
          56,
        ),
      ),
    );
  }
}
