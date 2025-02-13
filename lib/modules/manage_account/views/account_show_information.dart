import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/config/app_colors.dart';
import '/core/values/app_colors.dart';
import '/modules/manage_account/controllers/nav_controller/account_detail_controller.dart';

class AccountShowInformation extends StatelessWidget {
  AccountShowInformation({super.key});
  late double deviceHeight;
  late double deviceWidth;
  @override
  Widget build(BuildContext context) {
    final mainController = Get.find<AccountDetailController>();
    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;
    return Center(
      child: Obx(
        () => mainController.isLoading.value
            ? const LinearProgressIndicator(
                color: AppColors.primary95,
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Obx(
                    () => mainController.isLoading.value
                        ? const LinearProgressIndicator(
                            color: AppColors.primary95,
                          )
                        : const Padding(
                            padding: EdgeInsets.only(top: 0),
                          ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Stack(
                    children: [
                      Obx(
                        () => CircleAvatar(
                          radius: 64,
                          backgroundImage: CachedNetworkImageProvider(
                            mainController.profileOwner.value!.photoUrl,
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
                  Obx(
                    () => Text(
                      mainController.profileOwner.value!.username,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: AppColors.primary40,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Obx(
                    () => Text(
                      mainController.profileOwner.value!.email,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: AppColors.secondary40,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: deviceHeight * 0.02,
                  ),
                  Obx(
                    () => mainController.profileOwner.value!.verified
                        ? Card(
                            margin: EdgeInsets.symmetric(
                              horizontal:
                                  MediaQuery.of(context).size.width * 0.35,
                            ),
                            elevation: 0,
                            color: AppColors.primary98,
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Icon(
                                    IconData(0xe699,
                                        fontFamily: 'MaterialIcons'),
                                    color: Colors.blue,
                                  ),
                                  Spacer(),
                                  Text(
                                    'Đã xác thực',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 11,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        : Column(
                            children: [
                              Container(
                                width: deviceWidth * 0.5,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: red90,
                                ),
                                padding: const EdgeInsets.all(8.0),
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.close,
                                      color: red60,
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      'Chưa xác thực',
                                      style: TextStyle(
                                          color: red60,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ),
                              TextButton(
                                onPressed: () {},
                                style: TextButton.styleFrom(
                                  foregroundColor: Colors.black,
                                ),
                                child: Text(
                                  'Xác thực ngay',
                                  style: TextStyle(
                                    color: Colors.black.withOpacity(0.9),
                                    fontSize: 14,
                                    //decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                            ],
                          ),
                  ),
                ],
              ),
      ),
    );
  }
}
