import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_rent/core/values/app_colors.dart';
import 'package:smart_rent/modules/manage_account/controllers/nav_controller/account_detail_controller.dart';

class AccountShowInformation extends StatefulWidget {
  const AccountShowInformation({super.key});

  @override
  State<AccountShowInformation> createState() => _AccountShowInformationState();
}

class _AccountShowInformationState extends State<AccountShowInformation> {
  final mainController = Get.find<AccountDetailController>();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Obx(
        () => mainController.isLoading.value
            ? const LinearProgressIndicator(
                color: primary95,
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Obx(
                    () => mainController.isLoading.value
                        ? const LinearProgressIndicator(
                            color: primary95,
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
                        color: primary40,
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
                        color: secondary40,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Obx(
                    () => mainController.profileOwner.value!.verified
                        ? Card(
                            margin: EdgeInsets.symmetric(
                              horizontal:
                                  MediaQuery.of(context).size.width * 0.35,
                            ),
                            elevation: 0,
                            color: primary98,
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
                        : Card(
                            margin: EdgeInsets.symmetric(
                              horizontal:
                                  MediaQuery.of(context).size.width * 0.35,
                            ),
                            elevation: 0,
                            color: const Color.fromARGB(255, 180, 180, 180),
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Icon(
                                    IconData(0xe16a,
                                        fontFamily: 'MaterialIcons'),
                                    color: Colors.red,
                                  ),
                                  Spacer(),
                                  Text(
                                    'Chưa xác thực',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 11,
                                    ),
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
