import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_rent/core/resources/auth_methods.dart';
import 'package:smart_rent/core/values/app_colors.dart';
import 'package:smart_rent/modules/manage_account/controllers/account_nav_button_controller.dart';
import 'package:smart_rent/modules/manage_account/views/nav_screen/account_detail.dart';
import 'package:smart_rent/modules/manage_account/views/nav_screen/notify_setting.dart';

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
              onPressed: () {},
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
              },
              child: Container(
                alignment: Alignment.center,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100), color: primary60),
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
        color: primary40,
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
              color: primary40,
            ),
          ),
          const Icon(
            Icons.arrow_forward_ios,
            color: primary40,
          )
        ],
      ),
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        shadowColor: secondary80,
        //foregroundColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          // side: const BorderSide(
          //   color: secondary80,
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
