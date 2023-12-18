import 'package:flutter/material.dart';
import 'package:smart_rent/core/model/room/room.dart';
import 'package:smart_rent/core/values/app_colors.dart';

class ListRequestReturnRoomScreen extends StatelessWidget {
  ListRequestReturnRoomScreen({
    super.key,
    required this.roomInfo,
  });
  final Room roomInfo;
  late double deviceHeight;
  late double deviceWidht;

  @override
  Widget build(BuildContext context) {
    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidht = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primary98,
        title: const Text(
          'Danh sách yêu cầu trả phòng',
          style: TextStyle(
            color: primary40,
            fontWeight: FontWeight.w700,
            fontSize: 22,
          ),
        ),
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: deviceWidht * 0.02,
          vertical: deviceHeight * 0.01,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  side: const BorderSide(
                    color: secondary80,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(deviceWidht * 0.01),
                ),
                child: Column(
                  children: [
                    const Text(
                      'Thông tin phòng',
                      style: TextStyle(
                        color: primary40,
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(deviceWidht * 0.02),
                      child: Row(
                        children: [
                          const Text(
                            'Tên phòng',
                            style: TextStyle(
                              color: secondary40,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            roomInfo.title,
                            style: const TextStyle(
                              color: secondary20,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          )
                        ],
                      ),
                    ),
                    Divider(
                      color: secondary80,
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text(
                            'Số điện thoại',
                            style: TextStyle(
                              color: secondary40,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Spacer(),
                          Text(
                            '0915355488',
                            style: TextStyle(
                              color: secondary20,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          )
                        ],
                      ),
                    ),
                    Divider(
                      color: secondary80,
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text(
                            'Số tháng đặt cọc',
                            style: TextStyle(
                              color: secondary40,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Spacer(),
                          Text(
                            '1',
                            style: TextStyle(
                              color: secondary20,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          )
                        ],
                      ),
                    ),
                    Divider(
                      color: secondary80,
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text(
                            'Số tiền thanh toán',
                            style: TextStyle(
                              color: secondary40,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Spacer(),
                          Text(
                            '2.000.000đ',
                            style: TextStyle(
                              color: secondary20,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
