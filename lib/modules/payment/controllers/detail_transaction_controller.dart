import 'dart:convert';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:smart_rent/core/model/invoice/invoice.dart';
import 'package:smart_rent/core/resources/firebase_fcm.dart';
import 'package:smart_rent/core/resources/firestore_methods.dart';
import 'package:smart_rent/core/resources/payment_os_service.dart';
import 'package:webview_flutter/webview_flutter.dart';

class DetailTransactionController extends GetxController {
  DetailTransactionController({required this.invoice, required this.isReturn});
  final Invoice invoice;
  final bool isReturn;

  var rxInvoice = Rx<Invoice?>(null);
  RxString statusTransaction = 'progress'.obs;
  RxBool isLoading = false.obs;
  RxBool isExisting = false.obs;
  var errorMessage = 'error'.obs;
  late WebViewController webViewController;

  //late Map<String, dynamic> order;

  @override
  void onInit() async {
    webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {
            readResponse();
          },
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      );
    // webViewController = WebViewController()
    //   ..setJavaScriptMode(JavaScriptMode.unrestricted)
    //   ..setNavigationDelegate(
    //     NavigationDelegate(
    //       onProgress: (int progress) {
    //         // Update loading bar.
    //       },
    //       onPageStarted: (String url) {},
    //       onPageFinished: (String url) {
    //         readResponse();
    //       },
    //       onWebResourceError: (WebResourceError error) {},
    //       onNavigationRequest: (NavigationRequest request) {
    //         if (request.url.startsWith('https://www.youtube.com/')) {
    //           return NavigationDecision.prevent;
    //         }
    //         return NavigationDecision.navigate;
    //       },
    //     ),
    //   )
    //   ..loadRequest(
    //     Uri.parse('https://flutter.dev/'),
    //   );

    super.onInit();
    isLoading.value = true;
    mirrorRx(invoice);
    await getWebView();
  }

  mirrorRx(Invoice invoice) {
    rxInvoice.value = invoice;
  }

  void copyToClipboard(String textToCopy) {
    Clipboard.setData(ClipboardData(text: textToCopy));

    Get.snackbar(
      'Thông báo',
      'Đã sao chép vào bộ nhớ tạm $textToCopy',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.white,
      colorText: Colors.black,
    );
  }

  Future<void> getWebView() async {
    DateTime now = DateTime.now().add(const Duration(hours: 1)).toUtc();
    final timeStamp = now.millisecondsSinceEpoch ~/ 1000;

    rxInvoice.value = rxInvoice.value!.copyWith(expireAt: timeStamp);
    var client = http.Client();
    try {
      await FireStoreMethods().addOrderCode(invoice);
      var url = Uri.https('api-merchant.payos.vn', '/v2/payment-requests');
      // print('order-code: ${rxInvoice.value!.orderCode}');
      var response = await http.post(url,
          headers: {
            'Content-Type': 'application/json',
            'x-client-id': dotenv.env['x_client_id_payos']!,
            'x-api-key': dotenv.env['x_api_key_payos']!,
          },
          body: json.encode({
            'orderCode': rxInvoice.value!.orderCode,
            'amount': rxInvoice.value!.amountRoom,
            'description': rxInvoice.value!.description,
            'buyerName': rxInvoice.value!.buyerName,
            'buyerEmail': rxInvoice.value!.buyerEmail,
            'buyerPhone': rxInvoice.value!.buyerPhone,
            'buyerAddress': rxInvoice.value!.buyerAddress,
            'items': rxInvoice.value!.items,
            'cancelUrl': rxInvoice.value!.cancelUrl,
            'returnUrl': rxInvoice.value!.returnUrl,
            'expiredAt': rxInvoice.value!.expireAt,
            'signature': PaymentOSService().getSignature(rxInvoice.value!)
          }));

      // print('Response status: ${response.statusCode}');
      // print('Response body: ${response.body}');

      final Map<String, dynamic> resData = await json.decode(response.body);

      if (response.statusCode == 200 && resData['code'] == '00') {
        rxInvoice.value = rxInvoice.value!.copyWith(
          paymentLinkId: resData['data']['paymentLinkId'].toString(),
        );
        await FireStoreMethods()
            .addInforRequestPayOS(resData, rxInvoice.value!);
        webViewController
            .loadRequest(Uri.parse(resData['data']['checkoutUrl']));
      } else if (response.statusCode == 200 && resData['code'] == '231') {
        isLoading.value = false;
        isExisting.value = true;
        statusTransaction.value = 'fail';

        Get.snackbar(
          'Thông báo',
          'Đơn hàng đã tồn tại, vui lòng thử lại sau',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.white,
          colorText: Colors.black,
        );
        errorMessage.value = resData['desc'];
        return;
      } else {
        statusTransaction.value = 'fail';
        Get.snackbar(
          'Thông báo',
          'Đã có lỗi xảy ra, vui lòng thử lại sau',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.white,
          colorText: Colors.black,
        );
        errorMessage.value = resData['desc'];
        return;
      }
    } finally {
      client.close();
    }
    isLoading.value = false;
  }

  Future<void> readResponse() async {
    // Read the current URL
    String? currentUrl = await webViewController.currentUrl();
    print(currentUrl);
    if (currentUrl ==
        'https://pay.payos.vn/web/${rxInvoice.value!.paymentLinkId}/success') {
      await FireStoreMethods().addInvoice(rxInvoice.value!);
      statusTransaction.value = 'success';
      await FireStoreMethods().updateInvoice(rxInvoice.value!, 'SUCCESS');
      String token =
          await FireStoreMethods().getTokenDevice(rxInvoice.value!.recieverId);
      if (isReturn) {
        // DANH CHO NGUOI CHU PHONG TRA COC CHO NGUOI THUE
        await FireStoreMethods().updateRentedRoom(
          rxInvoice.value!.roomId,
          'APPROVED',
          false,
          'UNKNOWN',
        );
        await FireStoreMethods().addHistoryRoomId(
          rxInvoice.value!.recieverId,
          rxInvoice.value!.roomId,
        );
        await FireStoreMethods().removeRentingRoomId(
          rxInvoice.value!.recieverId,
          rxInvoice.value!.roomId,
        );
        //print('order-code-noti: ${rxInvoice.value!.orderCode}');
        await FirebaseFCM().sendNotificationHTTP(
          rxInvoice.value!.buyerId,
          rxInvoice.value!.recieverId,
          token,
          'Bạn vừa được hoàn cọc từ ${rxInvoice.value!.recieverName}',
          'Nội dung: ${rxInvoice.value!.description} - ${rxInvoice.value!.amountRoom} VNĐ',
          true,
          'imgUrl',
          'APPROVEDPAYMENT',
          {
            'invoice': rxInvoice.value!.toJson(),
          },
        );

        String ticketId = await FireStoreMethods().getTicketRequestReturnRentId(
          rxInvoice.value!.roomId,
          rxInvoice.value!.buyerId,
          rxInvoice.value!.recieverId,
        );

        await FireStoreMethods()
            .updateStatusTicketRequestReturnRent(ticketId, 'NOTWORKING');
        await FireStoreMethods()
            .updateStatusRoom(rxInvoice.value!.roomId, 'APPROVED');
      }

      // DANH CHO NGUOI DI THUE PHONG - NGUOI NAY SE GUI TIEN COC DI
      if (!isReturn) {
        await FireStoreMethods().addRentingRoomId(
          rxInvoice.value!.buyerId,
          rxInvoice.value!.roomId,
        );
      }
      await FirebaseFCM().sendNotificationHTTP(
        rxInvoice.value!.buyerId,
        rxInvoice.value!.recieverId,
        token,
        'Bạn vừa nhận thanh toán từ ${rxInvoice.value!.recieverName}',
        'Nội dung: ${rxInvoice.value!.description} - ${rxInvoice.value!.amountRoom} VNĐ',
        true,
        'imgUrl',
        'PAYMENT',
        {},
      );
      AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: 10,
          channelKey: 'basic_channel',
          title: 'Thanh toán thành công',
          body: 'Bạn đã thanh toán thành công cho căn nhà ...',
        ),
        // actionButtons: [
        //   NotificationActionButton(
        //       key: 'AGREED1', label: 'I agree', autoDismissible: true),
        //   NotificationActionButton(
        //       key: 'AGREED2', label: 'I agree too', autoDismissible: true),
        // ],
      );
    }
  }
}
