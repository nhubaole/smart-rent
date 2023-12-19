import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_rent/core/values/app_colors.dart';
import 'package:smart_rent/modules/home/controllers/home_feature_nav_controller.dart';
import 'package:smart_rent/modules/map/views/map_screen.dart';
import 'package:smart_rent/modules/post/views/post_screen.dart';
import 'package:smart_rent/modules/recently/views/recently_view.dart';

class HomeFeatureNavWidget extends StatelessWidget {
  const HomeFeatureNavWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final mainController = Get.put(HomeFeatureNavController());
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(255, 205, 203, 203), // Màu của bóng mờ
            blurRadius: 9.0, // Độ mờ của bóng
            spreadRadius: 3.0, // Độ lan rộng của bóng
            offset: Offset(0, 2), // Vị trí độ lệch của bóng
          ),
        ],
      ),
      margin: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 10,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
            onTap: () {
              mainController.jumpToScreen(const MapScreen());
            },
            child: Container(
              decoration: BoxDecoration(
                color: primary98,
                borderRadius: BorderRadius.circular(16),
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 25,
              ),
              child: const Column(
                children: [
                  Icon(
                    Icons.map,
                    color: primary40,
                  ),
                  Text('Bản đồ'),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              // Get.to(
              //   PaymentInforScreen(
              //     invoice: Invoice(
              //       orderCode: 10,
              //       recieverId: 'x47CBjhEVvVD4sBVWMDkYHYgfcg1',
              //       recieverName: 'Le Bao Nhu',
              //       recieverPhoneNumber: '+84823306992',
              //       recieverNumberBank: 'recieverNumberBank',
              //       recieverBank: 'recieverBank',
              //       addressRoom: 'addressRoom',
              //       amountRoom: 5000,
              //       description: 'test coc phong tro',
              //       buyerId: FirebaseAuth.instance.currentUser!.uid,
              //       buyerName: 'Pham Quoc Danh',
              //       buyerEmail: 'quocdanhmyker@gmail.com',
              //       buyerPhone: '+84373855259',
              //       buyerAddress: 'buyerAddress',
              //       items: [
              //         {
              //           'name': 'Phong tro',
              //           'quantity': 1,
              //           'price': 5000,
              //           'description': 'Phong tro',
              //         }
              //       ],
              //       roomId: '7DogDiAfgjQqfItXyG6a',
              //     ),
              //     isReturn: false,
              //   ),
              // );
              Get.to(PostScreen());
            },
            child: Container(
              decoration: BoxDecoration(
                color: primary98,
                borderRadius: BorderRadius.circular(16),
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 25,
              ),
              child: const Column(
                children: [
                  Icon(
                    Icons.add_box,
                    color: primary40,
                  ),
                  Text('Đăng bài'),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              mainController.jumpToScreen(const RecentlyViewScreen());
            },
            child: Container(
              decoration: BoxDecoration(
                color: primary98,
                borderRadius: BorderRadius.circular(16),
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 15,
              ),
              child: const Column(
                children: [
                  Icon(
                    Icons.history,
                    color: primary40,
                  ),
                  Text('Đã xem\ngần đây'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
