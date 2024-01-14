import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:smart_rent/core/values/app_colors.dart';
import 'package:smart_rent/modules/chat/views/chat_screen.dart';
import 'package:smart_rent/modules/handle_rent_room_landlord/controllers/detail_request_rent_room_controller.dart';

// ignore: must_be_immutable
class DetailRequestRentRoomScreen extends StatelessWidget {
  DetailRequestRentRoomScreen({super.key, required this.data});
  final Map<String, dynamic> data;
  late double deviceHeight;
  late double deviceWidth;

  @override
  Widget build(BuildContext context) {
    final detailRequestController =
        Get.put(DetailRequestRentRoomController(data: data));
    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;
    var date = DateTime.fromMillisecondsSinceEpoch(data['timeStamp'] * 1000);
    String formattedDate = DateFormat('HH:mm dd/MM/yyyy').format(date);
    final oCcy = NumberFormat("#,##0", "vi_VN");
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primary40,
        foregroundColor: Colors.white,
        title: const Text(
          'Chi tiết yêu cầu',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
          child: Obx(
        () => detailRequestController.isLoading.value
            ? const CircularProgressIndicator(
                color: primary95,
                backgroundColor: Colors.white,
              )
            : Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: deviceWidth * 0.04,
                  vertical: deviceHeight * 0.01,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: deviceWidth * 0.01),
                          child: Text(
                            'Yêu cầu #...${data['id'].substring(data['id'].length - 8)}',
                            style: const TextStyle(
                              color: secondary20,
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        const Spacer(),
                        const Icon(
                          Icons.timelapse,
                          color: secondary60,
                          size: 20,
                        ),
                        SizedBox(
                          width: deviceWidth * 0.01,
                        ),
                        Text(
                          formattedDate,
                          style: const TextStyle(
                            color: secondary60,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    Card(
                      elevation: 0,
                      color: primary40,
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(
                          color: primary40,
                        ),
                        borderRadius: BorderRadius.circular(deviceWidth * 0.02),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: deviceWidth * 0.04,
                          vertical: deviceHeight * 0.02,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Obx(
                                  () => Text(
                                    detailRequestController
                                        .profileOwner.value!.username,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: deviceHeight * 0.01,
                                ),
                                Obx(
                                  () => GestureDetector(
                                    onTap: () {
                                      detailRequestController.copyToClipboard(
                                        detailRequestController
                                            .profileOwner.value!.phoneNumber,
                                      );
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        const Icon(
                                          Icons.call_outlined,
                                          color: Colors.white,
                                        ),
                                        SizedBox(
                                          width: deviceWidth * 0.01,
                                        ),
                                        Text(
                                          detailRequestController
                                              .profileOwner.value!.phoneNumber,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: deviceHeight * 0.01,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    ElevatedButton(
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                primary98),
                                        foregroundColor:
                                            MaterialStateProperty.all(
                                                primary40),
                                        padding: MaterialStateProperty.all(
                                            EdgeInsets.zero),
                                        shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                        ),
                                      ),
                                      onPressed: () async {
                                        Get.to(
                                          () => ChatScreen(
                                            conversationID:
                                                detailRequestController
                                                    .profileOwner
                                                    .value!
                                                    .phoneNumber,
                                            conversationName:
                                                detailRequestController
                                                    .profileOwner
                                                    .value!
                                                    .username,
                                            userId: detailRequestController
                                                .profileOwner
                                                .value!
                                                .phoneNumber,
                                          ),
                                        );
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: deviceWidth * 0.06,
                                          vertical: deviceHeight * 0.01,
                                        ),
                                        child: const Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              'Chat',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Icon(
                                              Icons.sms_outlined,
                                              size: 24.0,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: deviceWidth * 0.05,
                                    ),
                                    ElevatedButton(
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                secondary90),
                                        foregroundColor:
                                            MaterialStateProperty.all(
                                                secondary40),
                                        padding: MaterialStateProperty.all(
                                            EdgeInsets.zero),
                                        shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                        ),
                                      ),
                                      onPressed: () {},
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: deviceWidth * 0.06,
                                          vertical: deviceHeight * 0.01,
                                        ),
                                        child: const Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text('Gọi'),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Icon(
                                              Icons.phone_outlined,
                                              size: 24.0,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Obx(
                              () => Column(
                                children: [
                                  CircleAvatar(
                                    radius: deviceWidth * 0.1,
                                    backgroundImage: CachedNetworkImageProvider(
                                      detailRequestController
                                          .profileOwner.value!.photoUrl,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: deviceHeight * 0.008,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: deviceWidth * 0.01),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          const Text(
                            'Giá đề xuất',
                            style: TextStyle(
                              color: secondary20,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            height: deviceHeight * 0.008,
                          ),
                          Text(
                            '${oCcy.format(data['price'])}đ',
                            style: const TextStyle(
                              color: secondary40,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(
                            height: deviceHeight * 0.008,
                          ),
                          Obx(
                            () => data['price'] >
                                    detailRequestController.room.value!.price
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      const Icon(
                                        Icons.arrow_upward,
                                        color: Colors.green,
                                      ),
                                      SizedBox(
                                        width: deviceWidth * 0.01,
                                      ),
                                      Text(
                                        'Cao hơn giá niêm yết ${oCcy.format(data['price'] - detailRequestController.room.value!.price)} đ',
                                        style: const TextStyle(
                                          color: Colors.green,
                                          fontSize: 15,
                                        ),
                                      )
                                    ],
                                  )
                                : data['price'] <
                                        detailRequestController
                                            .room.value!.price
                                    ? Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          const Icon(
                                            Icons.arrow_upward,
                                            color: Colors.red,
                                          ),
                                          SizedBox(
                                            width: deviceWidth * 0.01,
                                          ),
                                          Text(
                                            'Thấp hơn giá niêm yết ${oCcy.format(detailRequestController.room.value!.price - data['price'])} đ',
                                            style: const TextStyle(
                                              color: Colors.red,
                                              fontSize: 15,
                                            ),
                                          )
                                        ],
                                      )
                                    : Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          const Icon(
                                            Icons.arrow_upward,
                                            color: primary80,
                                          ),
                                          SizedBox(
                                            width: deviceWidth * 0.01,
                                          ),
                                          Text(
                                            'Bằng giá niêm yết ${oCcy.format(data['price'])} đ',
                                            style: const TextStyle(
                                              color: primary80,
                                              fontSize: 15,
                                            ),
                                          )
                                        ],
                                      ),
                          ),
                          SizedBox(
                            height: deviceHeight * 0.01,
                          ),
                          const Text(
                            'Số lượng người dự định ở cùng',
                            style: TextStyle(
                              color: secondary20,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            height: deviceHeight * 0.008,
                          ),
                          Text(
                            '${data['quantityPeople']} người',
                            style: const TextStyle(
                              color: secondary40,
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(
                            height: deviceHeight * 0.008,
                          ),
                          Obx(
                            () => data['quantityPeople'] >
                                    detailRequestController.room.value!.capacity
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      const Icon(
                                        Icons.check,
                                        color: Colors.red,
                                      ),
                                      SizedBox(
                                        width: deviceWidth * 0.01,
                                      ),
                                      Text(
                                        'Vượt quá sức chứa phòng trọ (quá ${oCcy.format(data['quantityPeople'] - detailRequestController.room.value!.capacity)} người)',
                                        style: const TextStyle(
                                          color: Colors.red,
                                          fontSize: 15,
                                        ),
                                      )
                                    ],
                                  )
                                : Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      const Icon(
                                        Icons.check,
                                        color: Colors.green,
                                      ),
                                      SizedBox(
                                        width: deviceWidth * 0.01,
                                      ),
                                      const Text(
                                        'Phù hợp sức chứa phòng trọ',
                                        style: TextStyle(
                                          color: Colors.green,
                                          fontSize: 15,
                                        ),
                                      )
                                    ],
                                  ),
                          ),
                          SizedBox(
                            height: deviceHeight * 0.01,
                          ),
                          const Text(
                            'Ngày bắt đầu thuê',
                            style: TextStyle(
                              color: secondary20,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            height: deviceHeight * 0.008,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              const Icon(Icons.calendar_month),
                              SizedBox(
                                width: deviceWidth * 0.01,
                              ),
                              Text(
                                data['dateJoin'] == 'joinNow'
                                    ? formattedDate
                                    : data['dateJoin'],
                                style: const TextStyle(
                                  color: secondary40,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: deviceHeight * 0.01,
                          ),
                          const Text(
                            'Ngày kết thúc thuê',
                            style: TextStyle(
                              color: secondary20,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            height: deviceHeight * 0.008,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              const Icon(Icons.calendar_month),
                              SizedBox(
                                width: deviceWidth * 0.01,
                              ),
                              Text(
                                data['dateLeave'] == 'longTime'
                                    ? formattedDate
                                    : data['dateLeave'],
                                style: const TextStyle(
                                  color: secondary40,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: deviceHeight * 0.01,
                          ),
                          const Text(
                            'Yêu cầu đặc biệt',
                            style: TextStyle(
                              color: secondary20,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            height: deviceHeight * 0.008,
                          ),
                          Text(
                            data['specialRequest'],
                            style: const TextStyle(
                              color: secondary40,
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(
                            height: deviceHeight * 0.018,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  detailRequestController.showDialogConfirm(
                                    'Xác nhận từ chối yêu cầu',
                                    'Bạn thực sự từ chối yêu cầu thuê phòng từ ${detailRequestController.profileOwner.value!.username}',
                                    () => detailRequestController
                                        .declineRequestRentRoom(data),
                                  );
                                },
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Container(
                                    width: deviceWidth * 0.4,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                          deviceWidth * 0.01),
                                      color: const Color(0xfffff0f1),
                                    ),
                                    padding: EdgeInsets.all(deviceWidth * 0.03),
                                    child: const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.close,
                                          color: Color(0xffFF425E),
                                        ),
                                        SizedBox(
                                          width: 8,
                                        ),
                                        Text(
                                          'Từ chối',
                                          style: TextStyle(
                                            color: Color(0xffFF425E),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  detailRequestController.showDialogConfirm(
                                    'Xác nhận chấp nhận yêu cầu',
                                    'Bạn thực sự chấp nhận yêu cầu thuê phòng từ ${detailRequestController.profileOwner.value!.username}',
                                    () => detailRequestController
                                        .acceptRequestRentRoom(data),
                                  );
                                },
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Container(
                                    width: deviceWidth * 0.4,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                          deviceWidth * 0.01),
                                      color: const Color(0xffe8ffe8),
                                    ),
                                    padding: EdgeInsets.all(deviceWidth * 0.03),
                                    child: const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.check,
                                          color: Color(0xff3fa835),
                                        ),
                                        SizedBox(
                                          width: 8,
                                        ),
                                        Text(
                                          'Chấp nhận',
                                          style: TextStyle(
                                            color: Color(0xff3fa835),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
      )),
    );
  }
}
