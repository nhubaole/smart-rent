import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../core/config/app_colors.dart';
import '/core/values/app_colors.dart';
import '/modules/handle_rent_room_landlord/controllers/widgets/item_request_rent_room_controller.dart';

// ignore: must_be_immutable
class ItemRequestRentRoom extends StatelessWidget {
  final Map<String, dynamic> data;
  ItemRequestRentRoom({
    super.key,
    required this.data,
  });
  late double deviceHeight;
  late double deviceWidth;
  @override
  Widget build(BuildContext context) {
    final itemRequestController =
        Get.put(ItemRequestRentRoomController(data: data));
    itemRequestController.getProfile(data['uidTenant']);
    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;
    var date = DateTime.fromMillisecondsSinceEpoch(data['timeStamp'] * 1000);
    String formattedDate = DateFormat('HH:mm dd/MM/yyyy').format(date);
    final oCcy = NumberFormat("#,##0", "vi_VN");
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: deviceWidth * 0.02,
        vertical: deviceHeight * 0.01,
      ),
      child: Card(
        elevation: 0,
        color: AppColors.primary98,
        shape: RoundedRectangleBorder(
          side: const BorderSide(
            color: Colors.transparent,
          ),
          borderRadius: BorderRadius.circular(deviceWidth * 0.01),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: deviceWidth * 0.03,
            vertical: deviceHeight * 0.01,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    '#...${data['id'].substring(data['id'].length - 5)}',
                    style: const TextStyle(
                      color: AppColors.secondary60,
                      fontSize: 18,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  data['dateJoin'] == 'joinNow'
                      ? const Row(
                          children: [
                            Icon(
                              Icons.stars,
                              color: Colors.yellow,
                              size: 18,
                            ),
                            Text(
                              'Có thể dọn vào ở ngay',
                              style: TextStyle(
                                color: Colors.yellow,
                                fontSize: 16,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        )
                      : Text(
                          data['dateJoin'],
                          style: TextStyle(
                            color: Colors.black.withOpacity(0.6),
                            fontSize: 16,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                ],
              ),
              SizedBox(
                height: deviceHeight * 0.001,
              ),
              const Divider(
                color: primary80,
              ),
              SizedBox(
                height: deviceHeight * 0.001,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    'Khách hàng',
                    style: TextStyle(
                      color: AppColors.secondary40,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    'Giá đề xuất',
                    style: TextStyle(
                      color: AppColors.secondary40,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: deviceHeight * 0.008,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Obx(
                    () => itemRequestController.profileOwner.value != null
                        ? CircleAvatar(
                            radius: deviceWidth * 0.09,
                            backgroundImage: CachedNetworkImageProvider(
                              itemRequestController
                                  .profileOwner.value!.photoUrl,
                            ),
                          )
                        : CircleAvatar(
                            radius: deviceWidth * 0.09,
                            backgroundImage: const CachedNetworkImageProvider(
                              'https://images.unsplash.com/photo-1682685797741-f0213d24418c?q=80&w=2670&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                            ),
                          ),
                  ),
                  SizedBox(
                    width: deviceWidth * 0.02,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Obx(
                        () => itemRequestController.profileOwner.value != null
                            ? Text(
                                itemRequestController
                                    .profileOwner.value!.username,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                              )
                            : const SizedBox(),
                      ),
                      SizedBox(
                        height: deviceHeight * 0.002,
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Icon(Icons.star, color: Colors.yellow, size: 16),
                          Icon(Icons.star, color: Colors.yellow, size: 16),
                          Icon(Icons.star, color: Colors.yellow, size: 16),
                          Icon(Icons.star, color: Colors.yellow, size: 16),
                          Icon(Icons.star, color: Colors.yellow, size: 16),
                        ],
                      )
                    ],
                  ),
                  const Spacer(),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        '${oCcy.format(data['price'])}đ',
                        style: const TextStyle(
                          color: AppColors.primary40,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        height: deviceHeight * 0.002,
                      ),
                      Text(
                        formattedDate,
                        style: const TextStyle(
                          color: AppColors.secondary60,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
