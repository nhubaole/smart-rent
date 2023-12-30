import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_rent/core/values/app_colors.dart';
import 'package:smart_rent/modules/chat/views/chat_screen.dart';
import 'package:smart_rent/modules/handle_return_room_landlord/controllers/detail_request_return_room_controller.dart';

// ignore: must_be_immutable
class DetailRequestReturnRoomScreen extends StatelessWidget {
  DetailRequestReturnRoomScreen({super.key, required this.roomId});
  final String roomId;
  late double deviceHeight;
  late double deviceWidth;

  @override
  Widget build(BuildContext context) {
    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;
    final detailRequestController = Get.put(
      DetailRequestReturnRoomScreenController(roomId: roomId),
    );
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
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: deviceWidth * 0.04,
            vertical: deviceHeight * 0.01,
          ),
          child: Center(
            child: Obx(
              () => detailRequestController.isLoading.value
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: primary60,
                      ),
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: deviceWidth * 0.007),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.timelapse_rounded,
                                color: secondary40,
                              ),
                              SizedBox(
                                width: deviceWidth * 0.02,
                              ),
                              Text(
                                detailRequestController
                                    .detailTicket.value['returnDate'],
                                style: const TextStyle(
                                  color: secondary40,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: deviceHeight * 0.01,
                        ),
                        Card(
                          elevation: 0,
                          color: primary40,
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(
                              color: primary40,
                            ),
                            borderRadius:
                                BorderRadius.circular(deviceWidth * 0.02),
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
                                    Obx(
                                      () => TextButton.icon(
                                        label: Text(
                                          detailRequestController
                                              .profileOwner.value!.phoneNumber,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.white,
                                          ),
                                        ),
                                        onPressed: () {},
                                        icon: const Icon(
                                          Icons.call_outlined,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
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
                                              horizontal: deviceWidth * 0.03,
                                              vertical: deviceHeight * 0.01,
                                            ),
                                            child: const Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Text('Chat'),
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
                                          width: deviceWidth * 0.1,
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
                                              horizontal: deviceWidth * 0.03,
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
                                  () => CircleAvatar(
                                    radius: 50,
                                    backgroundImage: CachedNetworkImageProvider(
                                      detailRequestController
                                          .profileOwner.value!.photoUrl,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: deviceHeight * 0.02,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: deviceWidth * 0.007),
                          child: const Text(
                            'Ngày trả phòng',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: deviceWidth * 0.007),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.calendar_month_outlined,
                                color: secondary40,
                              ),
                              SizedBox(
                                width: deviceWidth * 0.03,
                              ),
                              const Text(
                                'Dài hạn',
                                style: TextStyle(
                                  color: secondary40,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: deviceHeight * 0.02,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: deviceWidth * 0.007),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Lý do',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                detailRequestController
                                    .detailTicket.value['reason'],
                                style: const TextStyle(
                                  color: secondary40,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: deviceHeight * 0.02,
                        ),
                        GestureDetector(
                          onTap: detailRequestController.showDialogLoading,
                          child: Align(
                            alignment: Alignment.center,
                            child: Container(
                              width: deviceWidth,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(deviceWidth * 0.01),
                                color: const Color(0xffe8ffe8),
                              ),
                              padding: EdgeInsets.all(deviceWidth * 0.03),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.check,
                                    color: Color(0xff3fa835),
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    'Xác nhận đã trả phòng',
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
                        SizedBox(
                          height: deviceHeight * 0.04,
                        ),
                        Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: deviceWidth * 0),
                          child: const Text(
                            'Bất cứ khi nào người thuê đã hoàn tất trả phòng, bạn có thể xác nhận để cập nhật tình trạng phòng.\n\nNếu quá thời hạn trả phòng mà không được xác nhận, yêu cầu trả phòng sẽ bị hủy bỏ.',
                            style: TextStyle(
                              color: secondary40,
                              fontSize: 14,
                            ),
                          ),
                        )
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
