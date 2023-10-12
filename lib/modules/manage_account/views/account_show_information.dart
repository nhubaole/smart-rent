import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_rent/core/values/app_colors.dart';
import 'package:smart_rent/modules/manage_account/controllers/account_show_infomation_controller.dart';

class AccountShowInformation extends StatelessWidget {
  const AccountShowInformation({super.key});

  @override
  Widget build(BuildContext context) {
    final AccountShowInformationController mainController =
        Get.put(AccountShowInformationController());

    mainController.getInfo();
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            children: [
              Obx(
                () => CircleAvatar(
                  radius: 64,
                  backgroundImage: NetworkImage(
                    mainController.photoUrl,
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: InkWell(
                  onTap: () {
                    mainController.changeImage(context);
                  },
                  child: const CircleAvatar(
                    radius: 16,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      radius: 14,
                      backgroundColor: Colors.blue,
                      child: Icon(
                        Icons.camera_alt,
                        color: Colors.white,
                        size: 16,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            mainController.currentName,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: primary40,
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            mainController.email,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: secondary40,
            ),
          ),
        ],
      ),
    );
  }
}
