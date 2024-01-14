import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:smart_rent/core/values/app_colors.dart';
import 'package:smart_rent/core/widget/room_item.dart';
import 'package:smart_rent/modules/recently/controllers/recently_view_controller.dart';
import 'package:smart_rent/modules/recently/views/widgets/recently_dialog_widget.dart';

class RecentlyViewScreen extends StatelessWidget {
  const RecentlyViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final RecentlyViewController recentlyViewController =
        Get.put(RecentlyViewController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primary98,
        title: const Text(
          'Đã xem gần đây',
          style: TextStyle(
            color: primary40,
            fontWeight: FontWeight.w700,
            fontSize: 22,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Get.dialog(
                RecentlyDialogWidget(
                    onPressed: recentlyViewController.clearList()),
              );
              //recentlyViewController.clearList();
            },
            icon: const Icon(
              Icons.delete,
              color: red60,
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Center(
            child: Obx(
              () {
                if (recentlyViewController.isLoading.value) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: primary95,
                      backgroundColor: Colors.white,
                    ),
                  );
                } else if (recentlyViewController.listRoom.value.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Lottie.asset(
                          'assets/lottie/empty_search.json',
                          repeat: true,
                          reverse: true,
                          height: 300,
                          width: double.infinity,
                        ),
                        const Text(
                          'Bạn chưa xem phòng nào gần đây!!!',
                          style: TextStyle(
                            color: secondary20,
                            fontSize: 18,
                            fontWeight: FontWeight.w200,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: OutlinedButton(
                              onPressed: () {
                                recentlyViewController.getListRoom();
                              },
                              style: ButtonStyle(
                                side: MaterialStateProperty.all(
                                  const BorderSide(
                                    color: primary40,
                                  ),
                                ),
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                              child: const Text(
                                'Tải lại',
                                style: TextStyle(
                                  color: primary40,
                                ),
                              ),
                            ),
                          ),
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
                          recentlyViewController.listRoom.value.length + 1,
                      itemBuilder: (context, index) {
                        if (index <
                            recentlyViewController.listRoom.value.length) {
                          return RoomItem(
                            isRenting: false,
                            isHandleRentRoom: false,
                            isHandleRequestReturnRoom: false,
                            isRequestReturnRent: false,
                            isRequestRented: false,
                            room: recentlyViewController.listRoom.value[index],
                            isLiked: recentlyViewController
                                .listRoom.value[index].listLikes
                                .contains(
                              FirebaseAuth.instance.currentUser!.uid,
                            ),
                          );
                        } else {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: OutlinedButton(
                                onPressed: () {
                                  recentlyViewController.getListRoom();
                                },
                                style: ButtonStyle(
                                  side: MaterialStateProperty.all(
                                    const BorderSide(
                                      color: primary40,
                                    ),
                                  ),
                                  shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                                child: const Text(
                                  'Tải thêm',
                                  style: TextStyle(
                                    color: primary40,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }
                      },
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
