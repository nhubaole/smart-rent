import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_rent/core/values/app_colors.dart';
import 'package:smart_rent/modules/profile_owner/controllers/profile_owner_controller.dart';

class ProfileOwnerScreen extends StatelessWidget {
  ProfileOwnerScreen({super.key});
  final ProfileOwnerController profileOwnerController =
      Get.put(ProfileOwnerController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primary98,
        title: const Text(
          'Thông tin chủ nhà',
          style: TextStyle(
            color: primary40,
            fontWeight: FontWeight.w700,
            fontSize: 22,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Center(
          child: Obx(
            () => !profileOwnerController.isLoading.value
                ? Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Card(
                        elevation: 0,
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(
                            color: primary40,
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(21.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Obx(
                                    () => Text(
                                      profileOwnerController
                                          .profileOwner.value!.username,
                                      style: const TextStyle(
                                        color: primary40,
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Obx(
                                    () => TextButton.icon(
                                      label: Text(
                                        profileOwnerController
                                            .profileOwner.value!.phoneNumber,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                          color: primary60,
                                        ),
                                      ),
                                      onPressed: () {},
                                      icon: const Icon(
                                        Icons.call_outlined,
                                        color: primary60,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Obx(
                                () => CircleAvatar(
                                  radius: 50,
                                  backgroundImage: CachedNetworkImageProvider(
                                    profileOwnerController
                                        .profileOwner.value!.photoUrl,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  )
                : const CircularProgressIndicator(
                    color: primary60,
                  ),
          ),
        ),
      ),
    );
  }
}
