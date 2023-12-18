import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:smart_rent/core/values/app_colors.dart';

// enum contentType {
//   RENT_ROOM,
//   NEW_ROOM,
//   PAYMENT,
//   REQUEST_RETURN_ROOM,
// }

class NotificationItemWidget extends StatelessWidget {
  final Map<String, dynamic> data;

  NotificationItemWidget({
    super.key,
    required this.data,
  });
  late double deviceHeight;
  late double deviceWidth;

  @override
  Widget build(BuildContext context) {
    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;
    var date = DateTime.fromMillisecondsSinceEpoch(data['timeStamp'] * 1000);
    String formattedDate = DateFormat('HH:mm dd/MM/yyyy').format(date);
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: deviceWidth * 0.02,
      ),
      child: Card(
        elevation: 0,
        color: data['isRead'] ? Colors.black.withOpacity(0.1) : primary98,
        shape: RoundedRectangleBorder(
          side: const BorderSide(
            color: Colors.transparent,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: deviceWidth * 0.02,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: deviceHeight * 0.1,
                width: deviceWidth * 0.2,
                child: Lottie.asset(
                  data['data']['content_type'] == 'RENT_ROOM'
                      ? 'assets/lottie/like.json'
                      : data['data']['content_type'] == 'PAYMENT'
                          ? 'assets/lottie/noti_payment.json'
                          : 'assets/lottie/home.json',
                  repeat: true,
                  reverse: true,
                  height: deviceHeight * 0.2,
                  width: double.infinity,
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data['notification']['title'],
                      style: const TextStyle(
                        color: secondary20,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    Text(
                      data['notification']['body'],
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.6),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    Text(
                      formattedDate,
                      style: const TextStyle(
                        color: secondary40,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
