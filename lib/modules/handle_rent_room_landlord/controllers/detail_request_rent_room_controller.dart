import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:smart_rent/core/model/room/room_model.dart';
import '../../../core/config/app_colors.dart';
import '/blank.dart';
import '/core/model/account/Account.dart';
import '/core/model/invoice/invoice.dart';
import '/core/resources/auth_methods.dart';
import '/modules/root_view/views/root_screen.dart';

class DetailRequestRentRoomController extends GetxController {
  final Map<String, dynamic> data;
  DetailRequestRentRoomController({required this.data});
  var profileOwner = Rx<Account?>(null);
  var isLoading = Rx<bool>(false);
  var room = Rx<RoomModel?>(null);

  @override
  void onInit() {
    getProfile(data['uidTenant']);
    getRoom(data['roomId']);
    super.onInit();
  }

  Future<void> getProfile(String uid) async {
    isLoading.value = true;
    profileOwner.value = await AuthMethods.getUserDetails(uid);
    isLoading.value = false;
  }

  void copyToClipboard(String textToCopy) {
    Clipboard.setData(ClipboardData(text: textToCopy));

    Get.snackbar(
      'Thông báo',
      'Đã sao chép số điện thoại $textToCopy',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.white,
      colorText: Colors.black,
    );
  }

  Future<void> getRoom(String roomId) async {
    isLoading.value = true;
    isLoading.value = false;
  }

  Future<void> declineRequestRentRoom(Map<String, dynamic> dataTicket) async {
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 10,
        channelKey: 'basic_channel',
        title: 'Bạn vừa từ chối một yêu cầu thuê phòng trọ',
        body: 'Hãy chú ý thông báo để giải quyết thắc mắc từ người thuê nhé!',
      ),
    );

    Get.offAll(
      const Blank(
        message: 'Vui lòng đợi',
        screen: RootScreen(),
      ),
    );
  }

  Future<void> acceptRequestRentRoom(Map<String, dynamic> dataTicket) async {
    Account tenantProfile = await AuthMethods.getUserDetails(
      dataTicket['uidTenant'],
    );
    Account landlordProfile = await AuthMethods.getUserDetails(
      dataTicket['uidLandlord'],
    );
    Invoice invoice = Invoice(
      orderCode: 1,
      recieverId: landlordProfile.uid,
      recieverName: landlordProfile.username,
      recieverPhoneNumber: tenantProfile.phoneNumber,
      recieverNumberBank: 'invoice.recieverNumberBank',
      recieverBank: 'invoice.recieverBank',
      addressRoom: landlordProfile.address,
      amountRoom: dataTicket['price'],
      description: 'Tien coc phong tro',
      buyerId: tenantProfile.uid,
      buyerName: tenantProfile.username,
      buyerEmail: tenantProfile.email,
      buyerPhone: tenantProfile.phoneNumber,
      buyerAddress: tenantProfile.address,
      items: [
        {
          'name': 'Phong tro',
          'quantity': 1,
          'price': dataTicket['price'],
          'description': 'Phong tro',
        }
      ],
      roomId: dataTicket['roomId'],
    );

    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 10,
        channelKey: 'basic_channel',
        title: 'Bạn vừa chấp nhận một yêu cầu thuê phòng trọ',
        body:
            'Hãy chú ý thông báo để nhận khoản tiền cọc từ từ người thuê nhé!',
      ),
    );

    Get.offAll(
      const Blank(
        message: 'Vui lòng đợi',
        screen: RootScreen(),
      ),
    );
  }

  Future<void> showDialogLoading() async {
    Get.dialog(
      const PopScope(
        //canPop: false,
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                CircularProgressIndicator(
                  color: AppColors.primary60,
                ),
                SizedBox(
                  height: 16,
                ),
                Text(
                  'Đang xử lý dữ liệu thanh toán...',
                  style: TextStyle(color: AppColors.primary60),
                ),
              ],
            ),
          ),
        ),
      ),
      barrierDismissible: false,
    );

    await Future.delayed(
      const Duration(seconds: 1),
    );
  }

  Future<void> showDialogConfirm(
    String title,
    String content,
    Function()? function,
  ) async {
    Get.dialog(
      AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: const Text('Hủy'),
          ),
          TextButton(
            onPressed: () async {
              if (function != null) {
                await function();
              }
            },
            child: const Text('Đồng ý'),
          ),
        ],
      ),
    );
  }
}
