import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_rent/core/values/app_colors.dart';
import 'package:smart_rent/core/widget/room_item.dart';
import 'package:smart_rent/modules/recently/controllers/recently_view_controller.dart';

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
          'Chi tiết giao dịch',
          style: TextStyle(
            color: primary40,
            fontWeight: FontWeight.w700,
            fontSize: 22,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Center(
          child: Column(
            children: [
              Obx(
                () => GridView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.71,
                    crossAxisSpacing: 5,
                    // mainAxisSpacing: 20,
                  ),
                  itemCount: recentlyViewController.listRoom.length,
                  itemBuilder: (BuildContext context, int index) {
                    return RoomItem(
                      room: recentlyViewController.listRoom[index],
                      isLiked: false,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
