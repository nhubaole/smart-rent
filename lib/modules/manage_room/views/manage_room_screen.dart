import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_rent/core/values/app_colors.dart';
import 'package:smart_rent/modules/manage_room/controllers/manage_room_controller.dart';
import 'package:smart_rent/modules/manage_room/views/sub_screen/invoice/invoice_manage.dart';
import 'package:smart_rent/modules/manage_room/views/sub_screen/invoice_water_electricity_manager/invoice_we_manager.dart';
import 'package:smart_rent/modules/manage_room/views/sub_screen/liked_room.dart';
import 'package:smart_rent/modules/manage_room/views/sub_screen/posted_room.dart';
import 'package:smart_rent/modules/manage_room/views/sub_screen/rented_room.dart';
import 'package:smart_rent/modules/manage_room/views/sub_screen/request_rent.dart';
import 'package:smart_rent/modules/manage_room/views/sub_screen/return_rent.dart';
import 'package:smart_rent/modules/manage_room/views/sub_screen/wait_approve_room.dart';
import 'package:smart_rent/modules/manage_room/views/widgets/account_button_nav.dart';

// ignore: must_be_immutable
class ManageRoomScreen extends StatelessWidget {
  ManageRoomScreen({super.key});
  late double deviceHeight;
  late double deviceWidth;
  @override
  Widget build(BuildContext context) {
    final manageRoomController = Get.find<ManageRoomController>();
    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;
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
            child: Padding(
              padding: EdgeInsets.only(
                top: deviceHeight * 0.05,
                left: deviceWidth * 0.05,
                right: deviceWidth * 0.08,
              ),
              child: const Text(
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
            top: deviceHeight * 0.1,
            left: 0,
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.sizeOf(context).width,
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(deviceWidth * 0.08),
                  topRight: Radius.circular(deviceWidth * 0.08),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    "Phòng của bạn",
                    style: TextStyle(
                        color: primary40,
                        fontWeight: FontWeight.w600,
                        fontSize: 16),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: AccountButtonNav(
                          nameButton: 'Phòng đã đăng',
                          onPressed: () {
                            manageRoomController.goToScreen(
                              const PostedRoomScreen(),
                            );
                          },
                          firstIcon: 'assets/images/posted.png',
                        ),
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        child: AccountButtonNav(
                          nameButton: 'Phòng yêu thích',
                          onPressed: () {
                            manageRoomController.goToScreen(
                              const LikedRoomScreen(),
                            );
                          },
                          firstIcon: 'assets/images/favorite.png',
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    "Yêu cầu của bạn",
                    style: TextStyle(
                        color: primary40,
                        fontWeight: FontWeight.w600,
                        fontSize: 16),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: AccountButtonNav(
                          nameButton: 'Phòng yêu cầu thuê',
                          onPressed: () {
                            manageRoomController.goToScreen(
                              const RequestRentScreen(),
                            );
                          },
                          firstIcon: 'assets/images/request_rent.png',
                        ),
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        child: AccountButtonNav(
                          nameButton: 'Phòng yêu cầu trả',
                          onPressed: () {
                            manageRoomController.goToScreen(
                              const ReturnRentScreen(),
                            );
                          },
                          firstIcon: 'assets/images/request_return.png',
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    "Lịch sử thuê phòng",
                    style: TextStyle(
                        color: primary40,
                        fontWeight: FontWeight.w600,
                        fontSize: 16),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: AccountButtonNav(
                          nameButton: 'Phòng đang thuê',
                          onPressed: () {
                            manageRoomController.goToScreen(
                              const RentedRoomScreen(),
                            );
                          },
                          firstIcon: 'assets/images/rent.png',
                        ),
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        child: AccountButtonNav(
                          nameButton: 'Phòng đã thuê',
                          onPressed: () {
                            manageRoomController.goToScreen(
                              const RentedRoomScreen(),
                            );
                          },
                          firstIcon: 'assets/images/history.png',
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    "Hóa đơn của bạn",
                    style: TextStyle(
                        color: primary40,
                        fontWeight: FontWeight.w600,
                        fontSize: 16),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: AccountButtonNav(
                          nameButton: 'Hóa đơn tiền cọc',
                          onPressed: () {
                            manageRoomController.goToScreen(
                              const InvoiceManage(),
                            );
                          },
                          firstIcon: 'assets/images/invoice_deposit.png',
                        ),
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        child: AccountButtonNav(
                          nameButton: 'Hóa đơn hàng tháng',
                          onPressed: () {
                            manageRoomController.goToScreen(
                              InvoiceWEManager(),
                            );
                          },
                          firstIcon: 'assets/images/monthly_invoice.png',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
