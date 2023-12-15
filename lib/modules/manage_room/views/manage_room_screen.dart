import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_rent/core/values/app_colors.dart';
import 'package:smart_rent/modules/manage_room/controllers/manage_room_controller.dart';
import 'package:smart_rent/modules/manage_room/views/sub_screen/invoice_manage.dart';
import 'package:smart_rent/modules/manage_room/views/sub_screen/liked_room.dart';
import 'package:smart_rent/modules/manage_room/views/sub_screen/posted_room.dart';
import 'package:smart_rent/modules/manage_room/views/sub_screen/rented_room.dart';
import 'package:smart_rent/modules/manage_room/views/sub_screen/request_rent.dart';
import 'package:smart_rent/modules/manage_room/views/sub_screen/return_rent.dart';
import 'package:smart_rent/modules/manage_room/views/sub_screen/wait_approve_room.dart';
import 'package:smart_rent/modules/manage_room/views/widgets/TextFormFieldAccount.dart';

class ManageRoomScreen extends StatefulWidget {
  const ManageRoomScreen({super.key});

  @override
  State<ManageRoomScreen> createState() => _ManageRoomScreenState();
}

class _ManageRoomScreenState extends State<ManageRoomScreen> {
  final ManageRoomController manageRoomController =
      Get.find<ManageRoomController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: MediaQuery.sizeOf(context).height,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  primary40,
                  primary95,
                ],
                begin: Alignment.topCenter,
                end: Alignment(0.0, -0.5),
              ),
            ),
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 62, horizontal: 24),
              child: Text(
                'Phòng của bạn',
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          Positioned(
            top: 120,
            left: 0,
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.sizeOf(context).width,
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
              ),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.white,
                    Colors.white,
                  ],
                ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  AccountButtonNav(
                    nameButton: 'Phòng yêu cầu thuê',
                    onPressed: () {
                      manageRoomController.goToScreen(
                        const RequestRentScreen(),
                      );
                    },
                    firstIcon: Icons.luggage,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  AccountButtonNav(
                    nameButton: 'Phòng yêu cầu trả',
                    onPressed: () {
                      manageRoomController.goToScreen(
                        const ReturnRentScreen(),
                      );
                    },
                    firstIcon: Icons.no_luggage,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  AccountButtonNav(
                    nameButton: 'Phòng đã thuê',
                    onPressed: () {
                      manageRoomController.goToScreen(
                        const RentedRoomScreen(),
                      );
                    },
                    firstIcon: Icons.key,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  AccountButtonNav(
                    nameButton: 'Phòng đã đăng',
                    onPressed: () {
                      manageRoomController.goToScreen(
                        const PostedRoomScreen(),
                      );
                    },
                    firstIcon: Icons.upload,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  AccountButtonNav(
                    nameButton: 'Phòng đang chờ duyệt',
                    onPressed: () {
                      manageRoomController.goToScreen(
                        const WaitApproveRoomScreen(),
                      );
                    },
                    firstIcon: Icons.verified,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  AccountButtonNav(
                    nameButton: 'Phòng yêu thích',
                    onPressed: () {
                      manageRoomController.goToScreen(
                        const LikedRoomScreen(),
                      );
                    },
                    firstIcon: Icons.heart_broken,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  AccountButtonNav(
                    nameButton: 'Quản lí hóa đơn',
                    onPressed: () {
                      manageRoomController.goToScreen(
                        const InvoiceManage(),
                      );
                    },
                    firstIcon: Icons.payment,
                  ),
                  const Spacer(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
