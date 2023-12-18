import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:smart_rent/core/values/app_colors.dart';
import 'package:smart_rent/core/widget/room_item.dart';
import 'package:smart_rent/modules/profile_owner/controllers/profile_owner_controller.dart';

class ProfileOwnerScreen extends StatelessWidget {
  final String uidOwner;
  const ProfileOwnerScreen({
    super.key,
    required this.uidOwner,
  });

  @override
  Widget build(BuildContext context) {
    final ProfileOwnerController profileOwnerController =
        Get.put(ProfileOwnerController(uidOwner: uidOwner));
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Center(
            child: Obx(
              () => !profileOwnerController.isLoading.value
                  ? Column(
                      children: [
                        const SizedBox(
                          height: 15,
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
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                left: 8,
                              ),
                              child: Text(
                                'Bài đã đăng',
                                style: TextStyle(
                                  color: secondary20,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Obx(
                          () {
                            if (profileOwnerController.isLoading.value) {
                              return const Center(
                                child: CircularProgressIndicator(
                                  color: primary60,
                                ),
                              );
                            } else if (profileOwnerController
                                .listRoom.value.isEmpty) {
                              return Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Lottie.asset(
                                      'assets/lottie/empty_box.json',
                                      repeat: true,
                                      reverse: true,
                                      height: 300,
                                      width: double.infinity,
                                    ),
                                    Text(
                                      '${profileOwnerController.profileOwner.value!.username}\nchưa đăng phòng!!!',
                                      style: const TextStyle(
                                        color: secondary20,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w200,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              );
                            }
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                GridView.builder(
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    childAspectRatio: 0.71,
                                    crossAxisSpacing: 5,
                                    // mainAxisSpacing: 20,
                                  ),
                                  itemCount:
                                      profileOwnerController.listRoom.length,
                                  itemBuilder: (context, index) {
                                    return RoomItem(
                                      isHandleRequestReturnRoom: false,
                                      isReturnRent: false,
                                      isRented: false,
                                      room: profileOwnerController
                                          .listRoom[index],
                                      isLiked: profileOwnerController
                                          .listRoom[index].listLikes
                                          .contains(uidOwner),
                                    );
                                  },
                                ),
                              ],
                            );
                          },
                        ),
                      ],
                    )
                  : const CircularProgressIndicator(
                      color: primary60,
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
